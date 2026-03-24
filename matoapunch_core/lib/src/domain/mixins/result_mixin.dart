import 'package:matoapunch_core/src/domain/base/result.dart';
import 'package:matoapunch_core/src/helpers/app_helper.dart';

extension FutureToResultMixin<T> on Future<T> {
  Future<Result<T>> toResult() => safeCall(() => this);
}

extension FuncToResultMixin<T> on T {
  Result<T> toResult() => safeCallSync(() => this);
}
