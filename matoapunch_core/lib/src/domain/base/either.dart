import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:matoapunch_core/src/domain/base/option.dart';

part 'either.freezed.dart';

/// Represents a value of one of two possible types.
///
/// By convention, `left` is used for failure/error values and `right`
/// is used for success values. This is useful for error handling
/// where both the error and success cases need to carry data.
@freezed
sealed class Either<L, R> with _$Either<L, R> {
  const Either._();

  const factory Either.left(L left) = _EitherLeft;

  const factory Either.right(R right) = _EitherRight;

  /// Converts this [Either] into an [Option], keeping the right value
  /// or returning [Option.none] if left.
  Option<R> toOption() {
    return when(
      left: (_) => Option.none(),
      right: Option.some,
    );
  }
}
