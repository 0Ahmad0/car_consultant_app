import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/string_manager.dart';
import '../../core/utils/style_manager.dart';
import '../../core/widgets/app_padding.dart';

class AiBotWelcomeWidget extends StatelessWidget {
  const AiBotWelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CircleAvatar(
                backgroundColor: ColorManager.primaryColor,
                radius: 50.sp,
              ),
              Positioned(
                bottom: -2,
                child: Image.asset(
                  AssetsManager.aiBotIMG,
                  width: 80.w,
                  height: 80.h,
                ),
              ),
            ],
          ),
          verticalSpace(20.h),
          Text(
            StringManager.consultAiTitleText,
            style: StyleManager.font14SemiBold(),
          ),
          verticalSpace(10.h),
          Text(
            StringManager.consultAiSubTitleText,
            textAlign: TextAlign.center,
            style: StyleManager.font12Regular(
                color: ColorManager.hintTextColor
            ),
          ),
        ],
      ),
    );
  }
}
