import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/seeder.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    authController.init();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AppPaddingWidget(
            child: Form(
              key: authController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(20.h),
                  Text(
                    StringManager.goodToSeeYouText,
                    style: StyleManager.font24Medium(),

                  ),
                  verticalSpace(14.h),
                  Text(
                    StringManager.loginToYourAccountText,
                    style: StyleManager.font16Regular(),
                  ),
                  verticalSpace(40.h),
                  AppTextField(
                    iconData: Icons.call_outlined,
                   controller:  authController.emailController,
                    hintText: StringManager.enterEmailHintText,
                      validator: (value)=>authController.validateEmail(value??'')
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    controller: authController.passwordController,
                    obscureText: true,
                    suffixIcon: true,
                    validator: (value)=>authController.validatePassword(value??''),
                    hintText: StringManager.enterPasswordHintText,
                  ),
                  verticalSpace(10.h),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {
                        context.pushNamed(Routes.forgotPasswordRoute);
                      },
                      child: Text(
                        StringManager.forgotPasswordLoginText,
                        style: StyleManager.font16Regular(),
                      ),
                    ),
                  ),
                  verticalSpace(20.h),
                  AppButton(
                    onPressed: () {
                      // Seeder.serviceProvider();
                      // context.pushReplacement(Routes.navbarRoute);
                      if (authController.formKey.currentState!.validate()) {
                      authController.login(context);}

                    },
                    text: StringManager.loginText,
                  ),
                  verticalSpace(20.h),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: StringManager.doNotHaveAnAccountText + " ",
                        style: StyleManager.font14Regular(
                          color: ColorManager.blackColor,
                        ),
                      ),
                      TextSpan(
                          text: StringManager.signUpText,
                          style: StyleManager.font14Bold(
                            color: ColorManager.primaryColor,
                          ).copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: ColorManager.primaryColor,
                              decorationThickness: 1),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushReplacement(Routes.signUpRoute);
                            }),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
