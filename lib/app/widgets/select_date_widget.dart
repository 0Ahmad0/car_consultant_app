import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/const_value_manager.dart';
import '../../core/utils/style_manager.dart';
import '../controllers/provider_appointments_controller.dart';

class SelectDateListWidget extends StatelessWidget {
   SelectDateListWidget({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  final int index;
  final int currentIndex;
   List<DateTime> dateSlots=[];
  @override
  Widget build(BuildContext context) {
    dateSlots=   Get.put(ProviderAppointmentsController()).getDateSlots();
    return AnimatedContainer(
      alignment: Alignment.center,
      duration: Duration(milliseconds: ConstValueManager.animationDuration),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
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
          FittedBox(
            child: Text(
              '${DateFormat().add_EEEE().format(dateSlots[index])}',
              style: StyleManager.font12SemiBold(
                  color: currentIndex == index
                      ? ColorManager.primaryColor
                      : ColorManager.blackColor),
            ),
          ),
          verticalSpace(4.h),
          FittedBox(
            child: Text(
              '${DateFormat.d().format(dateSlots[index])}',
              // '${DateFormat.d().format(ConstValueManager.dateList[index])}',
              style: StyleManager.font12SemiBold(
                  color: currentIndex == index
                      ? ColorManager.primaryColor
                      : ColorManager.blackColor),
            ),
          ),
        ],
      ),
    );
  }
}
