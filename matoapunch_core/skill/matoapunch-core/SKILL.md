---
name: matoapunch-core
description: Use when working with the matoapunch_core Flutter/Dart package, including Result, Option, Either, AppUseCase, safeCall helpers, and toResult extensions. Trigger for tasks such as adding matoapunch_core to a project, modeling success/error flows, replacing nullable returns or thrown exceptions with Result or Option, building clean architecture use cases with AppUseCase, or writing tests around matoapunch_core-based code.
---

# Matoa Punch Core

Use this skill when the user is implementing or refactoring Flutter or Dart code around `matoapunch_core`.

## What The Package Exports

- `Result<T>` for success or failure results
- `Option<T>` for present or absent values
- `Either<L, R>` for left or right branch modeling
- `AppUseCase<O, I>` as a base contract for use-case classes
- Helpers: `safeCall`, `safeCallSync`, `ok`, `err`, `some`, `none`, `left`, `right`
- Extensions: `Future<T>.toResult()` and `T.toResult()`

If you need the exact public API or usage patterns, read [references/api.md](references/api.md).

## Workflow

1. Add the package import:

```dart
import 'package:matoapunch_core/matoapunch_core.dart';
```

2. Pick the right primitive:

- Use `Result<T>` when an operation either returns data or captures an error.
- Use `Option<T>` when the absence of a value is expected and not exceptional.
- Use `Either<L, R>` when both branches are intentional domain outcomes.
- Use `AppUseCase<O, I>` when the project is organizing application logic into callable use-case classes.

3. Prefer helpers over repetitive boilerplate:

- Wrap async repository or datasource calls with `safeCall`.
- Wrap sync transformations with `safeCallSync`.
- Use `ok` and `err` for concise result construction.
- Use `some`, `none`, `left`, and `right` for readable wrappers.

4. For simple value or future conversion, prefer the extensions:

- `future.toResult()` for `Future<T>`
- `value.toResult()` for plain values

## Guidance

- Keep `Option` for expected emptiness such as missing cache or optional filters.
- Keep `Result` for operational failure such as parsing, storage, transport, or repository errors.
- Use `Either` only when both sides are domain-significant. Do not use it as a weaker `Result`.
- In use cases, return `Future<Result<O>>` and let the boundary capture exceptions close to the side-effect.
- In tests, assert with `.when(...)` or convert `Result` to `Option` when error details are irrelevant.

## Common Patterns

### Repository call

```dart
Future<Result<User>> getUser(String id) {
  return safeCall(() => api.fetchUser(id));
}
```

### Optional lookup

```dart
Option<String> readToken(String? rawToken) {
  if (rawToken == null || rawToken.isEmpty) {
    return none<String>();
  }

  return some(rawToken);
}
```

### Use case

```dart
class GetProfileUseCase extends AppUseCase<Profile, String> {
  GetProfileUseCase(this.repository);

  final ProfileRepository repository;

  @override
  Future<Result<Profile>> call(String params) {
    return safeCall(() => repository.getProfile(params));
  }
}
```

## Validation

- Run `dart analyze`
- Run `flutter test`

Keep changes aligned with the package’s existing API and examples in [README.md](../../../README.md).
