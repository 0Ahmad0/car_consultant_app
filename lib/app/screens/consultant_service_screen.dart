import 'dart:developer';

import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/consultant_service_widget.dart';
import '../widgets/filter_head_widget.dart';

class ConsultantServiceScreen extends StatelessWidget {
  const ConsultantServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.consultantServiceText),
      ),
      body: AppPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterHeadWidget(),
            verticalSpace(20.h),
            Expanded(
                child: ListView.separated(
              separatorBuilder: (_, __) => Divider(
                thickness: .75,
                height: 30.h,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return ConsultantServiceWidget(index: index,);
              },
            ))
          ],
        ),
      ),
    );
  }
}


