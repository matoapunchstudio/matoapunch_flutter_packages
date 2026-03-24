import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matoapunch_core/src/domain/base/base.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.data(T data) = _ResultData;

  const factory Result.error({
    required Object error,
    StackTrace? stackTrace,
  }) = _ResultError;

  Option<T> toOption() {
    return when(
      data: Option.some,
      error: (_, _) => Option.none(),
    );
  }
}
