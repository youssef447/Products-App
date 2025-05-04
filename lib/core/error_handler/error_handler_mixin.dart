import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'failure.dart';

mixin ErrorHandlerMixin {
  Future<Either<Failure, T>> errorHandler<T>(
      Future<T> Function() operation) async {
    try {
      final res = await operation();
      return Right(res);
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      return Left(ServiceFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
