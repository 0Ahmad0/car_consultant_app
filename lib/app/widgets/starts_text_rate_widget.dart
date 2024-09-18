import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';

class StartsTextRateWidget extends StatelessWidget {
  const StartsTextRateWidget({
    super.key,
    required this.text,
    required this.rate,
  });

  final String text;
  final int rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StyleManager.font12Regular(color: ColorManager.hintTextColor),
          ),
        ),
        horizontalSpace(10.w),
        Expanded(
          child: Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.grade,
                color: rate >=(index+1)?ColorManager.rateStarColor:ColorManager.grayColor,
                size: 18.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}
