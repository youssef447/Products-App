import 'package:get/get.dart';
import 'package:product_tracking/features/auth/login/data/repo/login_repo.dart';

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
