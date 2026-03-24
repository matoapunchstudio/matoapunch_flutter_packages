import 'package:matoapunch_core/src/domain/base/either.dart';
import 'package:matoapunch_core/src/domain/base/option.dart';
import 'package:matoapunch_core/src/domain/base/result.dart';

Future<Result<T>> safeCall<T>(Future<T> Function() func) async {
  try {
    final data = await func();
    return ok(data);
  } on Exception catch (e, st) {
    return err(e, st);
  }
}

Result<T> safeCallSync<T>(T Function() func) {
  try {
    final data = func();
    return ok(data);
  } on Exception catch (e, st) {
    return err(e, st);
  }
}

Result<T> ok<T>(T data) {
  return Result.data(data);
}

Result<T> err<T>(Object error, [StackTrace? stackTrace]) {
  return Result.error(error: error, stackTrace: stackTrace);
}

Option<T> some<T>(T value) {
  return Option.some(value);
}

Option<T> none<T>() {
  return Option.none();
}

Either<L, R> left<L, R>(L value) {
  return Either.left(value);
}

Either<L, R> right<L, R>(R value) {
  return Either.right(value);
}
