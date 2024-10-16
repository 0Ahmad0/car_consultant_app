import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoAppointmentsWidget extends StatelessWidget {
  const NoAppointmentsWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsManager.noAppointmentsIMG,
            width: 100.w,
            height: 100.h,
          ),
          verticalSpace(20.h),
          Text.rich(
            style: StyleManager.font20SemiBold(),
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: StringManager.noText + ' '
                ),
                TextSpan(
                  text: text+ ' ',
                  style: StyleManager.font20SemiBold(
                    color: ColorManager.primaryColor
                  ),
                ),
                TextSpan(
                  text: StringManager.appointmentsText
                ),
              ]
            ),
          ),
          verticalSpace(10.h),
          Text.rich(
            style: StyleManager.font14Regular(
              color: ColorManager.hintTextColor
            ),
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: StringManager.currentlyYouDoNotHaveText + ' '
                ),
                TextSpan(
                  text: text+ ' ',
                  style: StyleManager.font14Regular(
                    color: ColorManager.primaryColor
                  ),
                ),
                TextSpan(
                  text: StringManager.appointmentsText
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}
