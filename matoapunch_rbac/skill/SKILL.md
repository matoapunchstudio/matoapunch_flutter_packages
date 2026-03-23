---
name: matoapunch-rbac
description: Use this skill when working with the Matoapunch RBAC Flutter/Dart package. Trigger it for tasks involving `MatoapunchRbac`, `Permission`, `Role`, `ShouldHavePermission`, RBAC JSON/base64 encoding, permission-check extensions, or the `RbacGuard` widget. Also use it when adding RBAC to Flutter UI, changing serialization, updating public exports, or documenting this package.
---

# Matoapunch RBAC

## Overview

This skill helps you implement, extend, and document the `matoapunch_rbac` package consistently with its current API and data rules.

Read the package README first for examples and intended usage. Then inspect the touched source files before changing behavior.

## Current Public Surface

Prefer public imports when writing package examples or consumer code:

```dart
import 'package:matoapunch_rbac/matoapunch_rbac.dart';
```

Area imports are also available:

```dart
import 'package:matoapunch_rbac/domain.dart';
import 'package:matoapunch_rbac/extensions.dart';
import 'package:matoapunch_rbac/utils.dart';
import 'package:matoapunch_rbac/widgets.dart';
```

Current main areas:
- `MatoapunchRbac`: immutable RBAC state and permission checks
- `Permission`: permission entity, identity based on `name`
- `Role`: role entity with `permissions`
- `ShouldHavePermission`: contract for permission-carrying types
- `RbacCodec`: base64 encode/decode for `List<Permission>`
- extensions for codec and RBAC checks
- `RbacGuard`: widget guard for permission-protected UI

## Rules That Must Stay Consistent

Keep these behaviors aligned unless the user explicitly asks for a breaking change:
- `Permission.name` is the stable identity used for equality and checks
- JSON output uses snake_case keys like `display_name`
- JSON input must accept both snake_case and legacy camelCase keys
- encoded permission payloads must remain backward-compatible when decoding
- prefer public barrel exports instead of telling users to import from `src/`
- `RbacGuard` defaults to `SizedBox.shrink()` as denied fallback

## Common Workflows

### Add or change entities

When changing `Permission` or `Role`:
- update docs on constructors, fields, and JSON methods
- preserve `Equatable` behavior based on `name`
- update direct entity tests
- if serialization changes, verify `RbacCodec` behavior and backward compatibility

### Add RBAC behavior

When changing `MatoapunchRbac`:
- keep state immutable
- prefer constructor or factory-based creation
- keep permission lookups based on permission names
- add tests for both positive and negative checks
- if adding convenience APIs, avoid duplicating core logic outside `MatoapunchRbac`

### Add extension helpers

When adding new extensions:
- keep the real logic in core types where possible
- let extensions delegate to `MatoapunchRbac` or `RbacCodec`
- add focused tests in `test/src/extensions/`
- prefer naming that reads naturally at call sites

### Add widget helpers

When adding Flutter widgets like guards:
- keep widget APIs thin and delegate permission evaluation to `MatoapunchRbac`
- support ergonomic constructors only if they normalize back into the core RBAC API
- add widget tests for allowed and denied states
- prefer zero-layout denied fallback unless the user explicitly wants mounted hidden content

### Update exports

When exposing new public APIs:
- add exports through the nearest barrel file
- keep `lib/matoapunch_rbac.dart` as the full-package entrypoint
- preserve area entrypoints in `lib/` when relevant
- avoid requiring consumers to import from `src/`

## File Map

Useful files to inspect first:
- `README.md`
- `lib/matoapunch_rbac.dart`
- `lib/src/matoapunch_rbac.dart`
- `lib/src/domain/entities/permission.dart`
- `lib/src/domain/entities/role.dart`
- `lib/src/domain/abstracts/should_have_permission.dart`
- `lib/src/extensions/rbac_check_ext.dart`
- `lib/src/extensions/rbac_codec_ext.dart`
- `lib/src/utils/rbac_codec.dart`
- `lib/src/widgets/rbac_guard.dart`
- `test/`

## Validation

After changes, run:

```sh
flutter analyze
flutter test
```

If the task touches serialization or compatibility, add tests for:
- current snake_case output
- legacy camelCase input
- RBAC base64 decode round trips

## Good Requests For This Skill

Examples of requests that should trigger this skill:
- "add a new permission check helper"
- "update `Role` serialization"
- "protect this widget with RBAC"
- "add docs for `MatoapunchRbac`"
- "keep JSON snake_case but backward compatible"
- "export this API publicly"
- "reorganize tests for this package"
