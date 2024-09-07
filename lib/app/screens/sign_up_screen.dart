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

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AppPaddingWidget(
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
                  hintText: StringManager.enterNameHintText,
                ),
                verticalSpace(20.h),
                AppTextField(
                  iconData: Icons.email_outlined,
                  hintText: StringManager.enterEmailHintText,
                ),
                verticalSpace(20.h),
                AppTextField(
                  iconData: Icons.call_outlined,
                  hintText: StringManager.enterPhoneHintText,
                ),
                verticalSpace(20.h),
                AppTextField(
                  obscureText: true,
                  suffixIcon: true,
                  hintText: StringManager.enterSetPasswordHintText,
                ),
                verticalSpace(20.h),
                AppTextField(
                  obscureText: true,
                  suffixIcon: true,
                  hintText: StringManager.enterConfirmPasswordHintText,
                ),
                verticalSpace(40.h),
                AppButton(
                  onPressed: () {},
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

    );
  }
}
