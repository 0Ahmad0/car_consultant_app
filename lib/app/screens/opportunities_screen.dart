import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/routing/routes.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/string_manager.dart';
import 'navbar/widgets/home_service_full_width_widget.dart';

class OpportunitiesScreen extends StatelessWidget {
  const OpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.freelanceOpportunitiesText),
      ),
      body: AppPaddingWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                context.pushNamed(Routes.becomeRouts,arguments: {
                  "text" : "Consult"
                });
              },
              child: HomeServiceFullWidthWidget(
                image: AssetsManager.consultIMG,
                title: StringManager.beComeConsultantTitleText,
                subTitle: StringManager.beComeConsultantSubTitleText,
              ),
            ),
            verticalSpace(30.h),
            InkWell(
              onTap: (){
                context.pushNamed(Routes.becomeRouts,arguments: {
                  "text" : "Service Provider"
                });
              },
              child: HomeServiceFullWidthWidget(
                image: AssetsManager.providerIMG,
                title: StringManager.beComeProviderTitleText,
                subTitle: StringManager.beComeProviderSubTitleText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
