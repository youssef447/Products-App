part of '../pages/login_page.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppFormField(
            hintText: 'username',
            maxLines: 1,
            collapsed: true,
            controller: controller.usernameController,
            keyboardType: TextInputType.text,
            suffixIcon: const SizedBox(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.w,
            ),
            validator: ValidationHelper.empty,
          ),
          const VerticalSpace(14),
          GetBuilder<LoginController>(builder: (_) {
            return AppFormField(
              hintText: 'Password',
              controller: controller.passController,
              maxLines: 1,
              isObscureText: !controller.showPass,
              collapsed: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.w,
              ),
              suffixIcon: GestureDetector(
                onTap: () => controller.toggleShowPass(),
                child: Icon(controller.showPass
                    ? Icons.visibility_off_outlined
                    : Icons.remove_red_eye),
              ),
              validator: ValidationHelper.empty,
            );
          }),
          const VerticalSpace(14),
          AppDefaultButton(
            text: 'Login',
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                controller.signin();
              }
            },
          )
        ],
      ),
    );
  }
}
