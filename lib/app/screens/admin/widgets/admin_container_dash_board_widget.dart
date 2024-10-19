import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/utils/style_manager.dart';

class AdminContainerDashBoardWidget extends StatelessWidget {
  const AdminContainerDashBoardWidget({
    super.key,
    this.typeText = '',
    this.countText = 0,
  });
  final String typeText;
  final int countText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 12.w, vertical: 54.h),
      decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.shadowColor,
              spreadRadius: 2.sp,
              blurRadius: 10.sp,
              offset: Offset(2.sp, 0),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          horizontalSpace(20.w),
          CircularPercentIndicator(
            radius: 40.sp,
            percent: .7,
            lineWidth: 5.sp,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundWidth: 1.8,
            backgroundColor: ColorManager.hintTextColor,
            progressColor: ColorManager.blueColor,
            animation: true,
            center: Transform.rotate(
                angle: -.75,
                child: Icon(
                  Icons.arrow_right_alt,
                  size: 44.sp,
                  color: ColorManager.hintTextColor,
                )),
          ),
          horizontalSpace(20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringManager.totalText + '  ' + typeText,
                  style: StyleManager.font16Regular(
                      color: ColorManager.hintTextColor),
                ),
                verticalSpace(18.h),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: '${countText}' + ' ',
                    style: StyleManager.font16SemiBold(),
                  ),
                  TextSpan(
                    text: typeText,
                    style: StyleManager.font16SemiBold(),
                  ),
                ])),
              ],
            ),
          )
        ],
      ),
    );
  }
}
