import 'package:car_consultant/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/string_manager.dart';
import '../../../core/utils/style_manager.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.notificationText),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsManager.noNotificationIMG,
            width: 140.w,
            height: 140.h,
          ),
          verticalSpace(30.h),
          Text(
            StringManager.noNotificationText,
            textAlign: TextAlign.center,
            style:
                StyleManager.font14Regular(color: ColorManager.hintTextColor),
          ),
        ],
      ),
    );
  }
}
