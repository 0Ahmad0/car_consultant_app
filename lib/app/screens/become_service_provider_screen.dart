import 'dart:io';

import 'package:animate_do/animate_do.dart';
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

import '../../core/utils/string_manager.dart';

class BecomeServiceProviderScreen extends StatefulWidget {
  const BecomeServiceProviderScreen({super.key});

  @override
  State<BecomeServiceProviderScreen> createState() => _BecomeServiceProviderScreenState();
}

class _BecomeServiceProviderScreenState extends State<BecomeServiceProviderScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.becomeAServiceProviderText ),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringManager.name,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              AppTextField(
                hintText: StringManager.enterNameHintText,
              ),
              verticalSpace(20.h),
              Text(
                StringManager.workshopNameText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              AppTextField(
                hintText: StringManager.workshopNameHintText,
              ),
              verticalSpace(20.h),
              Text(
                StringManager.tellAboutYourWorkShopText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                            color: ColorManager.grayColor, width: .5)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: ColorManager.hintTextColor,
                        )),
                    hintText: StringManager.tellUsHintText,
                    helperText: StringManager.tellUsHelperText),
                minLines: 4,
                maxLines: 8,
                maxLength: 300,
                textInputAction: TextInputAction.newline,
              ),
              verticalSpace(20.h),
              Text(
                StringManager.uploadFilesText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              StatefulBuilder(builder: (context, uploadFilesSetState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.grayColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringManager.categoryText,
                            style: StyleManager.font14SemiBold(),
                          ),
                          verticalSpace(10.h),
                          Row(
                            children: [
                              Checkbox(value: true, onChanged: (Value) {}),
                              horizontalSpace(8.w),
                              Text(StringManager.categoryRepairServicesText)
                            ],
                          ),
                          verticalSpace(10.h),
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (Value) {}),
                              horizontalSpace(8.w),
                              Text(StringManager.categoryInspectionAndDiagnosticsText)
                            ],
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(20.h),
                    Text(
                      StringManager.locationText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppTextField(
                      hintText: StringManager.enterYourLocationText,
                      keyboardType: TextInputType.numberWithOptions(),
                    ),
                    verticalSpace(20.h),
                    AppButton(
                        onPressed: () {
                        }, text: StringManager.submitText)
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
