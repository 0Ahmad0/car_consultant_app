import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
   PaymentSuccessfulScreen({super.key});
  String? text;
  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    text=args?['text'];
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.paymentSuccessfulText),
      ),
      body: AppPaddingWidget(
        child: Column(
          children: [
            const Spacer(),
            Column(
              children: [
                SvgPicture.asset(
                  AssetsManager.checkIcon,
                  width: 100.w,
                  height: 100.h,
                ),
                verticalSpace(10.h),
                Text(
                  text??StringManager.paymentSuccessfulText,
                  style: StyleManager.font18Medium(),
                )
              ],
            ),
            const Spacer(),
            AppButton(onPressed: () {
              context.pushAndRemoveUntil(
                  Routes.navbarRoute,
                  predicate: (route) => false
              );
            }, text: StringManager.goBackToHomeText),
          ],
        ),
      ),
    );
  }
}
