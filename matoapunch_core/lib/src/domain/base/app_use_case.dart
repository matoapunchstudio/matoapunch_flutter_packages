import 'package:matoapunch_core/src/domain/base/result.dart';

/// Base contract for an application use case that maps [I] into [O].
// ignore: one_member_abstracts
abstract class AppUseCase<O, I> {
  /// Executes the use case with the given [params].
  Future<Result<O>> call(I params);
}
