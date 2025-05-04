import 'package:get/get.dart';
import 'package:meal_tracking/features/auth/login/data/repo/login_repo.dart';

import '../data/model/user_model.dart';

class UserController extends GetxController {
  UserModel? user;
  final AuthRepo authRepo;
  UserController({required this.authRepo});

  getCurrentUser() async {
    final res = await authRepo.getCurrentAuthUser();

    res.fold(
      (ifLeft) {},
      (ifRight) => user = ifRight,
    );
  }
}
