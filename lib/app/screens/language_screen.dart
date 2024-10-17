import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool languageUs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.languageText),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Image.asset(
                  AssetsManager.usFlagIcon,
                  width: 30.w,
                  height: 30.h,
                ),
                contentPadding: EdgeInsets.zero,
                trailing: languageUs?Icon(
                  Icons.check_circle,
                  color: ColorManager.primaryColor,
                ):null,
                onTap: () {
                  setState(() {
                  languageUs = true;

                  });
                },
                dense: true,
                title: Text(
                  StringManager.englishUSText,
                  style: StyleManager.font14SemiBold(),
                ),
              ),
              verticalSpace(10.h),
              ListTile(
                leading: Image.asset(
                  AssetsManager.ukFlagIcon,
                  width: 30.w,
                  height: 30.h,
                ),
                contentPadding: EdgeInsets.zero,
                trailing: !languageUs?Icon(
                  Icons.check_circle,
                  color: ColorManager.primaryColor,
                ):null,
                onTap: () {
                  setState(() {
                    languageUs = false;

                  });
                },
                dense: true,
                title: Text(
                  StringManager.englishUKText,
                  style: StyleManager.font14SemiBold(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
