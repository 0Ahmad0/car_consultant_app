import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/color_manager.dart';
class HomeServiceFullWidthWidget extends StatelessWidget {
  const HomeServiceFullWidthWidget({
    super.key,
    required this.image,
    this.route = '',
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;
  final String image;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: route.isNotEmpty ? () {
        context.pushNamed(route);
      }:null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                  color: ColorManager.shadowColor.withOpacity(.9),
                  blurRadius: 10.sp,
                  offset: Offset(2.sp, 2.sp),
                  spreadRadius: 2.sp)
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            CircleAvatar(
              backgroundColor: ColorManager.primaryColor,
              radius: 30.sp,
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: Image.asset(
                  image,
                  width: 50.w,
                  height: 50.h,
                ),
              ),
            ),
            horizontalSpace(14.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(6.h),
                  Text(
                    subTitle,
                    style: StyleManager.font12Regular(color: ColorManager.hintTextColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
