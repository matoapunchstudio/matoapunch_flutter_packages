import 'package:matoapunch_core/src/domain/base/result.dart';
import 'package:matoapunch_core/src/helpers/app_helper.dart';

/// Extensions for converting futures into [Result] values.
extension FutureToResultMixin<T> on Future<T> {
  /// Awaits this future and wraps its outcome in a [Result].
  Future<Result<T>> toResult() => safeCall(() => this);
}

/// Extensions for wrapping plain values into [Result] values.
extension FuncToResultMixin<T> on T {
  /// Converts this value into a successful [Result].
  Result<T> toResult() => safeCallSync(() => this);
}
