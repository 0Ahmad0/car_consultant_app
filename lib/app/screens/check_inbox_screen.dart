import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckInboxScreen extends StatelessWidget {
  const CheckInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringManager.checkYourInboxText,
            style: StyleManager.font16SemiBold(),
          ),
          verticalSpace(10.h),
          Text(
            StringManager.sentEmailVerifyToResetPasswordText,
            style: StyleManager.font16Regular(
              color: ColorManager.hintTextColor
            ),
          ),
          verticalSpace(30.h),
          AppButton(onPressed: (){
            context.pushReplacement(Routes.loginRoute);

          }, text: StringManager.goToLoginText)
        ],
      ),
    );
  }
}
