import 'package:freezed_annotation/freezed_annotation.dart';

part 'either.freezed.dart';

/// {@template either}
/// Either description
/// {@endtemplate}
@freezed
sealed class Either<L, R> with _$Either<L, R> {
  const Either._();

  const factory Either.left(L left) = _EitherLeft;

  const factory Either.right(R right) = _EitherRight;
}
