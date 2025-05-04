import 'package:dartz/dartz.dart';
import 'package:product_tracking/core/error_handler/error_handler_mixin.dart';
import 'package:product_tracking/core/error_handler/failure.dart';
import 'package:product_tracking/features/user/data/model/user_model.dart';

import '../services/user_service.dart';

class UserRepo with ErrorHandlerMixin {
  final UserDataSource userDataSource;
  UserRepo({
    required this.userDataSource,
  });
  Future<Either<Failure, UserModel?>> getUser(String email) async {
    return errorHandler(() async {
      final data = await userDataSource.getUser(email);
      if (data == null) return null;

      return UserModel.fromMap(data);
    });
  }
}
