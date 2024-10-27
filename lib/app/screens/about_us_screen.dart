import 'package:car_consultant/core/helpers/sizer.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.aboutUsText),
      ),
      body: AppPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(AssetsManager.logoIMG,)),
            verticalSpace(20.h),
            Expanded(
              flex: 2,
              child: Text(
                ConstValueManager.aboutUsMapText['text'],
                textAlign: TextAlign.start,
                style: StyleManager.font14Regular().copyWith(height: 1.75),
              ),
            )
          ],
        ),
      ),
    );
  }
}
