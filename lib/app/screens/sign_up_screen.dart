import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:flutter/cupertino.dart';
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

import '../../core/helpers/validator.dart';
import '../controllers/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  late List s;

  @override
  void initState() {
    s = ConstValueManager.conditionPasswordList;
    passwordController.addListener(() {
      setState(() {
        s = ConstValueManager.conditionPasswordList;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

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
                    validator: (value) =>
                        authController.validateFullName(value ?? ''),
                    hintText: StringManager.enterNameHintText,
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    iconData: Icons.email_outlined,
                    controller: authController.emailController,
                    validator: (value) =>
                        authController.validateEmail(value ?? ''),
                    hintText: StringManager.enterEmailHintText,
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    iconData: Icons.call_outlined,
                    controller: authController.phoneController,
                    validator: (value) =>
                        authController.validatePhoneNumber(value ?? ''),
                    hintText: StringManager.enterPhoneHintText,
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    obscureText: true,
                    suffixIcon: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return StringManager.requiredField;
                      } else {
                        s = Validator.validatePassword(value);
                      }
                      return null;
                    },
                    hintText: StringManager.enterSetPasswordHintText,
                  ),
                  verticalSpace(10.h),
                  Visibility(
                    visible: passwordController.value.text.isNotEmpty,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringManager.conditionPasswordText,
                          style: StyleManager.font14SemiBold(),
                        ),
                        verticalSpace(10.h),
                        Column(
                          children: s
                              .map((e) => Row(
                                    children: [
                                      Icon(
                                        e.isValidate
                                            ? Icons.check_circle
                                            : Icons.circle,
                                        color: e.isValidate
                                            ? ColorManager.primaryColor
                                            : ColorManager.grayColor,
                                        size: 18.sp,
                                      ),
                                      horizontalSpace(8.w),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.h),
                                        child: Text(
                                          e.text,
                                          style: StyleManager.font12Regular(
                                            color: e.isValidate
                                                ? ColorManager.primaryColor
                                                : ColorManager.hintTextColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(20.h),
                  AppTextField(
                    obscureText: true,
                    suffixIcon: true,
                    controller: authController.confirmPasswordController,
                    validator: (value) =>
                        authController.validatePassword(value ?? ''),
                    hintText: StringManager.enterConfirmPasswordHintText,
                  ),
                  verticalSpace(40.h),
                  AppButton(
                    onPressed: () {
                      if (authController.formKey.currentState!.validate()) {
                        authController.signUp(context);
                      }
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
