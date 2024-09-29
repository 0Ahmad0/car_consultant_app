import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/educational_content_widget.dart';

class EducationalResourcesScreen extends StatelessWidget {
  const EducationalResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.educationalResourcesText),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppPaddingWidget(
            child: Text(
              StringManager.educationalContentText,
              style: StyleManager.font16Regular(),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              itemBuilder: (context, index) => EducationalContentWidget(),
              separatorBuilder: (_, __) => verticalSpace(20.h),
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
