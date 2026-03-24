# Matoa Punch Core

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Core functional types and clean architecture primitives for Matoa Punch Studio packages.

## What This Package Provides

- `Result<T>` for success or failure outcomes
- `Option<T>` for optional values
- `Either<L, R>` for left or right branching results
- `AppUseCase<O, I>` as a base contract for use cases
- Helper functions such as `safeCall`, `ok`, `err`, `some`, `none`, `left`, and `right`
- `toResult()` extensions for wrapping values and futures

## Installation

Make sure Flutter is installed, then add the package:

```sh
dart pub add matoapunch_core
```

## Import

```dart
import 'package:matoapunch_core/matoapunch_core.dart';
```

## Result

Use `Result<T>` to model an operation that either returns data or fails with an error.

```dart
final success = Result.data('hello');
final failure = Result<String>.error(error: Exception('failed'));

success.when(
  data: (value) => print('Success: $value'),
  error: (error, stackTrace) => print('Error: $error'),
);
```

`safeCall` and `safeCallSync` wrap thrown exceptions into `Result.error`.

```dart
Future<Result<String>> loadName() {
  return safeCall(() async {
    return 'Matoa';
  });
}

Result<int> parseCount() {
  return safeCallSync(() => 42);
}
```

Shorthand helpers are also exported:

```dart
final result = ok('done');
final failure = err<String>(Exception('failed'));
```

## Option

Use `Option<T>` when a value may or may not exist.

```dart
final withValue = Option.some('token');
final withoutValue = Option<String>.none();

final token = withValue.getOrElse(() => 'guest');
final hasToken = withValue.isSome();
final isMissing = withoutValue.isNone();
```

Helper constructors:

```dart
final someValue = some(10);
final noValue = none<int>();
```

## Either

Use `Either<L, R>` when both branches are valid outcomes and you want to preserve which side you received.

```dart
final leftValue = Either<String, int>.left('invalid');
final rightValue = Either<String, int>.right(200);

rightValue.when(
  left: (value) => print('Left: $value'),
  right: (value) => print('Right: $value'),
);
```

Helper constructors:

```dart
final errorSide = left<String, int>('invalid');
final successSide = right<String, int>(200);
```

## AppUseCase

`AppUseCase<O, I>` gives you a consistent contract for application use cases.

```dart
class GetProfileUseCase extends AppUseCase<String, int> {
  @override
  Future<Result<String>> call(int params) async {
    return safeCall(() async {
      return 'user-$params';
    });
  }
}
```

## Extensions

Convert futures and plain values into `Result` with the built-in extensions:

```dart
final asyncResult = Future.value('ready').toResult();
final syncResult = 7.toResult();
```

## Exports

The package exports:

- `domain/base`: `AppUseCase`, `Either`, `Option`, `Result`
- `domain/mixins`: `toResult()` extensions
- `helpers`: `safeCall`, `safeCallSync`, and shorthand constructors

## Development

Format Dart files:

```sh
dart format lib test
```

Run tests:

```sh
flutter test
```

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
