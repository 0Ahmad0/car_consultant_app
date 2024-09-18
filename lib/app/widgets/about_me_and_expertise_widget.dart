import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/formate_text_line.dart';
import '../../core/helpers/spacing.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';
import '../../core/widgets/app_padding.dart';

class AboutMeAndExpertiseWidget extends StatelessWidget {
  const AboutMeAndExpertiseWidget({
    super.key,
    required this.title,
    required this.description,
    this.isListFormat = false,
  });

  final String title;
  final String description;
  final bool isListFormat;

  @override
  Widget build(BuildContext context) {
    List<String> formattedLines = formatText(description);
    return AppPaddingWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: StyleManager.font20Bold(),
          ),
          verticalSpace(20.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.shadowColor.withOpacity(.5),
                    blurRadius: 8.sp,
                    spreadRadius: 2.sp,
                    offset: Offset(2.sp, 2.sp),
                  )
                ]),
            child: isListFormat
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: formattedLines
                        .map((line) => Text(
                              line,
                              style: StyleManager.font14Regular(
                                      color: ColorManager.hintTextColor)
                                  .copyWith(height: 2.5),
                            ))
                        .toList(),
                  )
                : Text(
                    description,
                    style: StyleManager.font14Regular(
                            color: ColorManager.hintTextColor)
                        .copyWith(
                      height: 2.15,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
