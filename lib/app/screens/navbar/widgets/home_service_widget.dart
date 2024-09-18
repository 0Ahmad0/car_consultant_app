import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/color_manager.dart';

class HomeServiceWidget extends StatelessWidget {
  const HomeServiceWidget({
    super.key,
    required this.text,
    required this.image,

    this.route = '',
  });

  final String text;
  final String image;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        context.pushNamed(route);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        width: ScreenUtil.defaultSize.width / 2,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 50.w,
              height: 50.h,
            ),
            verticalSpace(14.h),
            Text(
              text,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}


