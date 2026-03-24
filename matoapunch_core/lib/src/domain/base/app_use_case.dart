import 'package:matoapunch_core/src/domain/base/result.dart';

abstract class AppUseCase<O, I> {
  Future<Result<O>> call(I params);
}
