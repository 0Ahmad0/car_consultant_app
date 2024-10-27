import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/const_value_manager.dart';
import '../../core/utils/style_manager.dart';

class SelectTimeListWidget extends StatelessWidget {
  const SelectTimeListWidget({
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
        color: currentIndex == index &&
            ConstValueManager.timeList[index].status !=
                SelectTimeOrderStatus.book
            ? ColorManager.primaryColor.withOpacity(.1)
            : ConstValueManager.timeList[index].status ==
            SelectTimeOrderStatus.book?
            ColorManager.grayColor:ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
            color: currentIndex == index &&
                ConstValueManager.timeList[index].status !=
                    SelectTimeOrderStatus.book
                ? ColorManager.primaryColor
                : ConstValueManager.timeList[index].status ==
                SelectTimeOrderStatus.book
                ? ColorManager.grayColor :ColorManager.hintTextColor,
            width: currentIndex == index &&
                ConstValueManager.timeList[index].status !=
                    SelectTimeOrderStatus.book
                ? 1
                : 2),
      ),
      child: FittedBox(
        child: Text(
          '${DateFormat().add_Hm().format(
              ConstValueManager.timeList[index].fromTime)}'
              ' - '
              '${DateFormat().add_Hm().add_j().format(
              ConstValueManager.timeList[index].toTime)}',
          style: StyleManager.font12SemiBold(
            color: currentIndex == index
                ? ColorManager.primaryColor
                : ConstValueManager.timeList[index].status ==
                SelectTimeOrderStatus.book
                ? ColorManager.hintTextColor
                : ColorManager.blackColor,
          ),
        ),
      ),
    );
  }
}

enum SelectTimeOrderStatus {
  selected,
  empty,
  book,
}

class TimeHourModel {
  final SelectTimeOrderStatus status;
  final DateTime fromTime;
  final DateTime toTime;

  TimeHourModel({
    required this.status,
    required this.fromTime,
    required this.toTime,
  });
}
