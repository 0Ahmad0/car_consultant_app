import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/const_value_manager.dart';

class AdminHomeTypesButtonWidget extends StatelessWidget {
  const AdminHomeTypesButtonWidget(
      {super.key, required this.text, required this.isSelected, this.onTap});

  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: AnimatedContainer(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          duration: Duration(milliseconds: 600),
          decoration: BoxDecoration(
              color: isSelected?ColorManager.primaryColor :ColorManager.grayColor,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                    color: ColorManager.shadowColor,
                    offset: Offset(2.sp, 0),
                    blurRadius: 10.sp,
                    spreadRadius: 2.sp)
              ]),
          child: Text(
            text,
            style: StyleManager.font14Regular(color: isSelected?ColorManager.whiteColor :ColorManager.blackColor),
          ),
        ),
      ),
    );
  }
}
