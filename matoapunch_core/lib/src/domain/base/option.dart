import 'package:freezed_annotation/freezed_annotation.dart';

part 'option.freezed.dart';

/// {@template option}
/// Option description
/// {@endtemplate}
@freezed
sealed class Option<T> with _$Option<T> {
  const Option._();

  const factory Option.some(T data) = _OptionSome;

  const factory Option.none() = _OptionNone;

  /// Returns the wrapped value or computes a fallback with [orElse].
  T getOrElse(T Function() orElse) {
    return when(
      some: (data) => data,
      none: () => orElse(),
    );
  }

  /// Returns `true` when this option contains no value.
  bool isNone() {
    return when(
      some: (data) => false,
      none: () => true,
    );
  }

  /// Returns `true` when this option contains a value.
  bool isSome() {
    return when(
      some: (data) => true,
      none: () => false,
    );
  }
}
