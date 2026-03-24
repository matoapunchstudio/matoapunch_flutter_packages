# API Reference

## Import

```dart
import 'package:matoapunch_core/matoapunch_core.dart';
```

## Result

Use `Result<T>` for operations that can succeed or fail.

```dart
final success = Result.data('hello');
final failure = Result<String>.error(error: Exception('failed'));

success.when(
  data: (value) => print(value),
  error: (error, stackTrace) => print(error),
);
```

`Result<T>` also exposes:

- `toOption()` to discard error details and convert success to `Option.some`

## Option

Use `Option<T>` for optional values.

```dart
final withValue = Option.some('token');
final withoutValue = Option<String>.none();

final token = withValue.getOrElse(() => 'guest');
final hasToken = withValue.isSome();
final missing = withoutValue.isNone();
```

## Either

Use `Either<L, R>` when both branches are valid outcomes.

```dart
final leftValue = Either<String, int>.left('invalid');
final rightValue = Either<String, int>.right(200);
```

## AppUseCase

Use `AppUseCase<O, I>` as the base contract for application use cases.

```dart
class GetProfileUseCase extends AppUseCase<String, int> {
  @override
  Future<Result<String>> call(int params) async {
    return safeCall(() async => 'user-$params');
  }
}
```

## Helpers

```dart
final result = ok('done');
final failure = err<String>(Exception('failed'));

final someValue = some(10);
final noValue = none<int>();

final errorSide = left<String, int>('invalid');
final successSide = right<String, int>(200);
```

## Extensions

```dart
final asyncResult = Future.value('ready').toResult();
final syncResult = 7.toResult();
```
