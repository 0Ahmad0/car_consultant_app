import '/core/helpers/spacing.dart';
import '/core/utils/assets_manager.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/string_manager.dart';
import '/core/utils/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({
    super.key,
    this.image = 'AssetsManager.noDataFoundIMG',
    this.text = 'StringManager.noDataFoundText',
    this.resultCount,
  });

  final String image;
  final String text;
  final int? resultCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          image,
          fit: BoxFit.cover,
        ),
        verticalSpace(12.h),
        Text(
          'StringManager.noDataFoundText',
          style: StyleManager.font20SemiBold(
              color: ColorManager.blackColor),
        )
      ],
    );
  }
}
