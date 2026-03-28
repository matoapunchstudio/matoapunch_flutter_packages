import 'package:freezed_annotation/freezed_annotation.dart';

part 'option.freezed.dart';

/// Represents an optional value that may or may not contain data.
///
/// Similar to nullable types but with explicit `some` and `none` cases.
/// Use [Option] when you need to represent the presence or absence of
/// a value without using `null`.
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
