import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormSubmittedSuccessFullScreen extends StatelessWidget {
  const FormSubmittedSuccessFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.formSubmitText),
      ),
      body: AppPaddingWidget(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              AssetsManager.checkIcon,
            ),
            verticalSpace(20.h),
            Text(
              StringManager.formSubmitText,
              style: StyleManager.font14Bold(),
            ),
            verticalSpace(10.h),
            Text(
              StringManager.formSubmitSubTitleText,
              style:
                  StyleManager.font14Regular(color: ColorManager.hintTextColor),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
