---
name: matoapunch-pocketbase
description: Use when working on the matoapunch_pocketbase Flutter package or when integrating it into an app. Triggers for tasks like initializing MatoapunchPocketbase, using explicit user/admin PocketBase clients, handling login or auth refresh, updating PbSingleton or PbAdminSingleton, working with PB_BASE_URL or simulated login dart-defines, parsing PocketBase field errors with PbErrorMessage, or migrating older code away from legacy selector patterns.
---

# matoapunch-pocketbase

Use this skill when changing this package or writing code that consumes it.

## What to check first

- Read [references/package-notes.md](references/package-notes.md) for the current API and package conventions.
- If the task changes public behavior, inspect:
  - `lib/src/matoapunch_pocketbase.dart`
  - `lib/src/singletons/`
  - `test/matoapunch_pocketbase_test.dart`

## Working rules

- Prefer explicit access through `user`, `admin`, `userClient`, and `adminClient`.
- Do not reintroduce mutable mode-switching APIs when explicit clients solve the task.
- Keep user and admin auth behavior aligned. Shared behavior should live in the internal auth base, not be duplicated.
- Preserve the requirement that callers must initialize the package before reading a PocketBase client.
- Keep auth persistence based on `shared_preferences`.
- When touching auth/session behavior, update tests and run `flutter analyze` and `flutter test`.

## Integration defaults

- Import `package:matoapunch_pocketbase/matoapunch_pocketbase.dart`.
- Initialize with `await MatoapunchPocketbase().init();` before reading clients.
- `PB_BASE_URL` is required as a compile-time define.
- `simulateLogin()` is for local development and depends on `PB_SIMULATED_EMAIL` and `PB_SIMULATED_PASSWORD`.

## Documentation expectations

- Keep `README.md` aligned with the actual public API.
- If public entrypoints or env vars change, update both code comments and README examples.

