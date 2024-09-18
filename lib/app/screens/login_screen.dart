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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  hintText: StringManager.enterEmailHintText,
                ),
                verticalSpace(20.h),
                AppTextField(
                  obscureText: true,
                  suffixIcon: true,
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
                    context.pushReplacement(Routes.navbarRoute);
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
    );
  }
}
