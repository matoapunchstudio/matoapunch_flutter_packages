import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matoapunch_core/src/domain/base/base.dart';

part 'result.freezed.dart';

/// Represents either a successful value or a captured error.
@freezed
sealed class Result<T> with _$Result<T> {
  /// Base constructor for shared [Result] helpers.
  const Result._();

  /// Creates a successful result containing [data].
  const factory Result.data(T data) = _ResultData;

  /// Creates a failed result containing [error] and an optional [stackTrace].
  const factory Result.error({
    required Object error,
    StackTrace? stackTrace,
  }) = _ResultError;

  /// Converts this result into an [Option], dropping any error details.
  Option<T> toOption() {
    return when(
      data: Option.some,
      error: (_, _) => Option.none(),
    );
  }
}
