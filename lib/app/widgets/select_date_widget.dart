import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/const_value_manager.dart';
import '../../core/utils/style_manager.dart';

class SelectDateListWidget extends StatelessWidget {
  const SelectDateListWidget({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.center,
      duration: Duration(milliseconds: ConstValueManager.animationDuration),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: currentIndex == index
            ? ColorManager.primaryColor.withOpacity(.1)
            : ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            color: currentIndex == index
                ? ColorManager.primaryColor
                : ColorManager.hintTextColor,
            width: currentIndex == index ? 1.5 : 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${DateFormat().add_EEEE().format(ConstValueManager.dateList[index])}',
            style: StyleManager.font14Bold(
                color: currentIndex == index
                    ? ColorManager.primaryColor
                    : ColorManager.blackColor),
          ),
          verticalSpace(4.h),
          Text(
            '${DateFormat.d().format(ConstValueManager.dateList[index])}',
            style: StyleManager.font14Bold(
                color: currentIndex == index
                    ? ColorManager.primaryColor
                    : ColorManager.blackColor),
          ),
        ],
      ),
    );
  }
}
