# Secure Software Delivery Rules

## 1. Source Security

- No secrets in source, plist, or committed config files.
- Keep entitlements minimal and intentional.
- Large platform changes require review from `@architect`.

## 2. Build Security

- Prefer reproducible native builds through `xcodebuild` or `swift build`.
- Lock dependencies when external packages are introduced.
- Avoid unnecessary third-party Bluetooth wrappers unless the platform gap justifies them.

## 3. Data Integrity

- Never treat missing battery data as zero.
- Persist only the minimum local data needed for settings and user preferences.
- Notification logic must guard against duplicate spam.

## 4. Permissions & Privacy

- Ask for notification permission intentionally and explain why.
- Request only the system capabilities the product actually uses.
- Document any OS limitation that affects device detection or battery visibility.
