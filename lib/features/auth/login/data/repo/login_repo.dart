import 'package:dartz/dartz.dart';
import 'package:product_tracking/features/auth/login/data/data_source/login_service.dart';
import 'package:product_tracking/features/auth/login/data/data_source/token_service.dart';
import 'package:product_tracking/features/user/data/model/user_model.dart';

import '../../../../../core/error_handler/error_handler_mixin.dart';
import '../../../../../core/error_handler/failure.dart';

class AuthRepo with ErrorHandlerMixin {
  final AuthService authService;

  AuthRepo(this.authService);
  Future<Either<Failure, void>> login(
      {required String username, required String password}) async {
    return errorHandler(() async {
      final response = await authService.signIn(
        data: {
          'username': username,
          'password': password,
          'expiresInMins': 10,
        },
      );
      await _saveTokens(
        accessToken: response.data['accessToken'],
        refreshToken: response.data['refreshToken'],
      );
      getCurrentAuthUser();
    });
  }

  Future<Either<Failure, UserModel?>> getCurrentAuthUser() async {
    return errorHandler(() async {
      final response = await authService.getCurrentAuthUser();
      return response.data == null ? null : UserModel.fromMap(response.data);
    });
  }

  Future<void> _saveTokens(
      {required String accessToken, required String refreshToken}) async {
    await TokenService.setAccessToken(accessToken);
    await TokenService.setRefreshToken(refreshToken);
  }
}
