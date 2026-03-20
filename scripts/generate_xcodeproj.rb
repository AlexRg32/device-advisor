#!/usr/bin/env ruby

require 'fileutils'
require 'xcodeproj'

PROJECT_NAME = 'DeviceAdvisor'
PROJECT_PATH = "#{PROJECT_NAME}.xcodeproj"
APP_BUNDLE_ID = 'com.alexrg32.deviceadvisor'
TEST_BUNDLE_ID = 'com.alexrg32.deviceadvisor.tests'
DEPLOYMENT_TARGET = '14.0'

def add_swift_files(group, directory, target)
  Dir.children(directory).sort.each do |entry|
    next if entry.start_with?('.')

    path = File.join(directory, entry)

    if File.directory?(path)
      subgroup = group.new_group(entry, entry)
      add_swift_files(subgroup, path, target)
      next
    end

    next unless File.extname(entry) == '.swift'

    file_ref = group.new_file(entry)
    target.add_file_references([file_ref])
  end
end

FileUtils.rm_rf(PROJECT_PATH)

project = Xcodeproj::Project.new(PROJECT_PATH)
project.root_object.attributes['LastSwiftUpdateCheck'] = '2600'
project.root_object.attributes['LastUpgradeCheck'] = '2600'

main_group = project.main_group
main_group.new_file('README.md')
main_group.new_file('Package.swift')

sources_group = main_group.new_group('Sources', 'Sources')
tests_group = main_group.new_group('Tests', 'Tests')

app_target = project.new_target(:application, PROJECT_NAME, :osx, DEPLOYMENT_TARGET)
test_target = project.new_target(:unit_test_bundle, "#{PROJECT_NAME}Tests", :osx, DEPLOYMENT_TARGET)
test_target.add_dependency(app_target)

add_swift_files(sources_group, 'Sources', app_target)
add_swift_files(tests_group, 'Tests', test_target)

project.build_configurations.each do |config|
  config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = DEPLOYMENT_TARGET
  config.build_settings['SWIFT_VERSION'] = '6.0'
end

app_target.build_configurations.each do |config|
  config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = APP_BUNDLE_ID
  config.build_settings['PRODUCT_NAME'] = PROJECT_NAME
  config.build_settings['SWIFT_VERSION'] = '6.0'
  config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = DEPLOYMENT_TARGET
  config.build_settings['GENERATE_INFOPLIST_FILE'] = 'YES'
  config.build_settings['INFOPLIST_KEY_CFBundleDisplayName'] = 'Device Advisor'
  config.build_settings['INFOPLIST_KEY_LSUIElement'] = 'YES'
  config.build_settings['INFOPLIST_KEY_NSBluetoothAlwaysUsageDescription'] = 'Device Advisor lee el estado de bateria de dispositivos Bluetooth conectados.'
  config.build_settings['CODE_SIGN_STYLE'] = 'Automatic'
  config.build_settings['DEVELOPMENT_TEAM'] = ''
end

test_target.build_configurations.each do |config|
  config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = TEST_BUNDLE_ID
  config.build_settings['PRODUCT_NAME'] = "#{PROJECT_NAME}Tests"
  config.build_settings['SWIFT_VERSION'] = '6.0'
  config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = DEPLOYMENT_TARGET
  config.build_settings['GENERATE_INFOPLIST_FILE'] = 'YES'
  config.build_settings['CODE_SIGN_STYLE'] = 'Automatic'
  config.build_settings['DEVELOPMENT_TEAM'] = ''
  config.build_settings['TEST_HOST'] = '$(BUILT_PRODUCTS_DIR)/DeviceAdvisor.app/Contents/MacOS/DeviceAdvisor'
  config.build_settings['BUNDLE_LOADER'] = '$(TEST_HOST)'
end

scheme = Xcodeproj::XCScheme.new
scheme.add_build_target(app_target)
scheme.add_test_target(test_target)
scheme.set_launch_target(app_target)
scheme.save_as(PROJECT_PATH, PROJECT_NAME, true)

project.save

puts "Generated #{PROJECT_PATH}"
