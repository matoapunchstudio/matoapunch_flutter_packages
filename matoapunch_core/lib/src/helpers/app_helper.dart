import 'package:matoapunch_core/src/domain/base/either.dart';
import 'package:matoapunch_core/src/domain/base/option.dart';
import 'package:matoapunch_core/src/domain/base/result.dart';

/// Executes an async callback and captures thrown exceptions as [Result.error].
Future<Result<T>> safeCall<T>(Future<T> Function() func) async {
  try {
    final data = await func();
    return ok(data);
  } on Exception catch (e, st) {
    return err(e, st);
  }
}

/// Executes a sync callback and captures thrown exceptions as [Result.error].
Result<T> safeCallSync<T>(T Function() func) {
  try {
    final data = func();
    return ok(data);
  } on Exception catch (e, st) {
    return err(e, st);
  }
}

/// Creates a successful [Result] containing [data].
Result<T> ok<T>(T data) {
  return Result.data(data);
}

/// Creates a failed [Result] containing [error] and an optional [stackTrace].
Result<T> err<T>(Object error, [StackTrace? stackTrace]) {
  return Result.error(error: error, stackTrace: stackTrace);
}

/// Creates an [Option] containing [value].
Option<T> some<T>(T value) {
  return Option.some(value);
}

/// Creates an empty [Option].
Option<T> none<T>() {
  return Option.none();
}

/// Creates an [Either] containing a left value.
Either<L, R> left<L, R>(L value) {
  return Either.left(value);
}

/// Creates an [Either] containing a right value.
Either<L, R> right<L, R>(R value) {
  return Either.right(value);
}
