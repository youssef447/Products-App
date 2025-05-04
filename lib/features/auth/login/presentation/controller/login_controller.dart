import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_tracking/core/extensions/context_extension.dart';
import 'package:product_tracking/core/helpers/app_context.dart';
import 'package:product_tracking/core/routes/app_routes.dart';
import 'package:product_tracking/core/widgets/loading/loading_dialog.dart';
import 'package:product_tracking/features/auth/login/data/data_source/token_service.dart';
import 'package:product_tracking/features/auth/login/data/repo/login_repo.dart';
import 'package:product_tracking/features/user/controller/user_controller.dart';

class LoginController extends GetxController {
  final AuthRepo authRepo;
  LoginController({required this.authRepo});
  late final TextEditingController usernameController;
  late final TextEditingController passController;
  late final GlobalKey<FormState> formKey;
  @override
  onInit() {
    setResources();
    super.onInit();
  }

  setResources() {
    usernameController = TextEditingController();
    passController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  bool showPass = false;
  toggleShowPass() {
    showPass = !showPass;
    update();
  }

  signin() async {
    FocusManager.instance.primaryFocus?.unfocus();
    showLoadingIndicator();
    final res = await authRepo.login(
        username: usernameController.text, password: passController.text);
    hideLoadingIndicator();
    res.fold(
      (ifLeft) => Get.snackbar('Error', ifLeft.message),
      (ifRight) async {
        await getCurrentUser();
        AppContext.getContext!.navigateTo(AppRoutes.homeNavbar);
      },
    );
  }

  Future<bool> getCurrentUser() async {
    if (await TokenService.getAccessToken() == null) return false;
    await Get.find<UserController>().getCurrentUser();
    if (Get.find<UserController>().user == null) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    usernameController.dispose();
    passController.dispose();
    super.dispose();
  }
}
