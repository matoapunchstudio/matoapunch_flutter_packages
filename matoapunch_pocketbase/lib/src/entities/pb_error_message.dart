import 'package:freezed_annotation/freezed_annotation.dart';

part 'pb_error_message.freezed.dart';

/// {@template pb_error_message}
/// Represents a field-level error returned by PocketBase.
/// {@endtemplate}
@freezed
abstract class PbErrorMessage with _$PbErrorMessage {
  /// {@macro pb_error_message}
  const factory PbErrorMessage({
    required String key,
    required String code,
    required String message,
  }) = _PbErrorMessage;

  const PbErrorMessage._();

  /// Builds a [PbErrorMessage] from a PocketBase exception payload.
  factory PbErrorMessage.fromExceptionResponse(
    String key,
    Map<String, dynamic> payload,
  ) {
    final currentCode = payload['code']?.toString() ?? 'unknown';
    final currentMessage = payload['message']?.toString() ?? 'Unknown error';
    return PbErrorMessage(
      key: key,
      code: currentCode,
      message: currentMessage,
    );
  }
}
