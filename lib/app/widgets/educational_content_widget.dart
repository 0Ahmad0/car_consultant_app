import 'package:car_consultant/core/helpers/sizer.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/models/education_resource.dart';

class EducationalContentWidget extends StatelessWidget {
  const EducationalContentWidget({
    super.key, this.educationResourceModel,
  });
  final EducationResourceModel? educationResourceModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
                color: ColorManager.shadowColor.withOpacity(.9),
                offset: Offset(2.sp, 2.sp),
                blurRadius: 10.sp,
                spreadRadius: 2.sp)
          ]),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  educationResourceModel?.photoUrl??
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUDkCqGfRI3qDDs7MzeCyLCPOWjhbnqX2xw0P22K7rktN7eORJeIVCgYIom3I9o4VNXeY&usqp=CAU'
                  ,fit: BoxFit.fitHeight,
                  height: 140.h,
                ),
              ),
            ),
            horizontalSpace(10.w),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    educationResourceModel?.title??
                    'Proper Oil Refilling Technique',
                    style: StyleManager.font16Regular(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(10.h),
                  Text(
                    educationResourceModel?.about??
                    'Video description'
                    'Check the oil level regularly.'
                    'Pour slowly to avoid spills.',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font14Regular(
                        color: ColorManager.hintTextColor),
                  ),
                  const Divider(
                    color: ColorManager.hintTextColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.grade,
                            color: ColorManager.rateStarColor,
                            size: 18.sp,
                          ),
                          horizontalSpace(4.w),
                          Text(
                            '${educationResourceModel?.review??5.0}',
                            style: StyleManager.font14Bold(),
                          )
                        ],
                      ),
                      Text(
                        '${educationResourceModel?.numLike??200} ' + StringManager.likesText,
                        style: StyleManager.font12Regular(
                            color: ColorManager.blackColor.withOpacity(.5)),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
