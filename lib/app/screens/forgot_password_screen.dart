import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:car_consultant/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/string_manager.dart';
import '../../core/utils/style_manager.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20.h),
              Text(
                StringManager.forgotPasswordText,
                style: StyleManager.font24Medium(),
              ),
              verticalSpace(10.h),
              Text(
                StringManager.pleaseEnterValidEmailText,
                textAlign: TextAlign.start,
              ),
              verticalSpace(40.h),
              AppTextField(
                hintText: StringManager.enterEmailHintText,
                iconData: Icons.call_outlined,
              ),
              verticalSpace(40.h),
              AppButton(onPressed: (){
                context.pushReplacement(Routes.checkYourInboxRoute);
              }, text: StringManager.submitText)

            ],
          ),
        ),
      ),
    );
  }
}
