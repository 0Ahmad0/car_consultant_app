import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/style_manager.dart';

class RequestInfoListTileWidget extends StatelessWidget {
  const RequestInfoListTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(4.h),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StyleManager.font14Regular(color: ColorManager.primaryColor),
          ),
          Text(
            subTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StyleManager.font12Regular(color: ColorManager.hintTextColor),
          ),
          verticalSpace(4.h),
        ],
      ),
    );
  }
}
