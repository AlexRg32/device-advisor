---
name: database-design
description: Persistence design guidance for local-first apps. Helps choose between UserDefaults, file storage, SQLite, and richer local models.
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Local Persistence Design

## Core Principle

Choose the smallest persistence tool that matches the product.

## Default Order

1. `UserDefaults` for simple preferences
2. files for exported artifacts
3. SQLite or richer stores only when query needs justify them

## For This Project

- Default to `UserDefaults`
- Do not introduce a database for simple thresholds and lightweight device metadata
- Revisit only if historical tracking or analytics appears
