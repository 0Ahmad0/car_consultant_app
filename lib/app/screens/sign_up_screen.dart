import 'package:flutter/material.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
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

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                    StringManager.createAccountText,
                    style: StyleManager.font24Medium(),

                  ),
                  verticalSpace(40.h),
                  AppTextField(
                    iconData: Icons.person_outline,
                    controller: authController.nameController,
                    validator: (value)=>authController.validateFullName(value??''),
                    hintText: StringManager.enterNameHintText,
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    iconData: Icons.email_outlined,
                    controller: authController.emailController,
                    validator: (value)=>authController.validateEmail(value??''),
                    hintText: StringManager.enterEmailHintText,
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    iconData: Icons.call_outlined,
                    controller: authController.phoneController,
                    validator: (value)=>authController.validatePhoneNumber(value??''),
                    hintText: StringManager.enterPhoneHintText,
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    obscureText: true,
                    suffixIcon: true,
                    controller: authController.passwordController,
                    validator: (value)=>authController.validatePassword(value??''),
                    hintText: StringManager.enterSetPasswordHintText,
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    obscureText: true,
                    suffixIcon: true,
                    controller: authController.confirmPasswordController,
                    validator: (value)=>authController.validatePassword(value??''),

                    hintText: StringManager.enterConfirmPasswordHintText,
                  ),
                  verticalSpace(40.h),
                  AppButton(
                    onPressed: () {
                      if (authController.formKey.currentState!.validate()) {
                        authController.signUp(context);}
                    },
                    text: StringManager.signUpText,
                  ),
                  verticalSpace(20.h),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: StringManager.allReadyHaveAnAccountText + " ",
                        style: StyleManager.font14Regular(
                          color: ColorManager.blackColor,
                        ),
                      ),
                      TextSpan(
                          text: StringManager.loginText,
                          style: StyleManager.font14Bold(
                            color: ColorManager.primaryColor,
                          ).copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: ColorManager.primaryColor,
                              decorationThickness: 1),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.pushReplacement(Routes.loginRoute);
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
