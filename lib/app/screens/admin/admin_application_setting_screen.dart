import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_container_with_shadow.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class AdminApplicationSettingScreen extends StatefulWidget {
  const AdminApplicationSettingScreen({super.key});

  @override
  State<AdminApplicationSettingScreen> createState() =>
      _AdminApplicationSettingScreenState();
}

class _AdminApplicationSettingScreenState
    extends State<AdminApplicationSettingScreen> {
  bool notify = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.applicationSettingsText),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringManager.backupText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              AppContainerWithShadow(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  trailing: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: ColorManager.primaryColor,
                      ),
                      onPressed: () {},
                      child: Text(
                        StringManager.backupText,
                        style: StyleManager.font14Regular(
                            color: ColorManager.whiteColor),
                      )),
                  title: Text(
                    StringManager.lastBackupInText +
                        ' - ' +
                        DateFormat.d().add_yMMM().format(DateTime.now()),
                  ),
                ),
              ),
              verticalSpace(20.h),
              Text(
                StringManager.dataPrivacyAndTermsText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              AppPaddingWidget(
                  horizontalPadding: 10,
                  verticalPadding: 10,
                  child: Text(
                    StringManager.editTermsAndConditionsText,
                    style: StyleManager.font12SemiBold(),
                  )),
              AppPaddingWidget(
                horizontalPadding: 10,
                verticalPadding: 0,
                child: AppTextField(
                  isMultiLine: true,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  hintText: StringManager.editTermsAndConditionsHintText,
                  minLine: 4,
                  maxLine: 8,
                ),
              ),
              AppPaddingWidget(
                horizontalPadding: 10,
                verticalPadding: 0,
                child: Text(
                  StringManager.lastUpdateText +
                      ' - ' +
                      DateFormat.yMd().format(DateTime.now()),
                  style: StyleManager.font12Regular(),
                ),
              ),
              verticalSpace(20.h),
              AppPaddingWidget(
                  horizontalPadding: 10,
                  verticalPadding: 10,
                  child: Text(
                    StringManager.editPrivacyPolicyText,
                    style: StyleManager.font12SemiBold(),
                  )),
              AppPaddingWidget(
                horizontalPadding: 10,
                verticalPadding: 0,
                child: AppTextField(
                  isMultiLine: true,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  hintText: StringManager.editPrivacyPolicyHintText,
                  minLine: 4,
                  maxLine: 8,
                ),
              ),
              AppPaddingWidget(
                horizontalPadding: 10,
                verticalPadding: 0,
                child: Text(
                  StringManager.lastUpdateText +
                      ' - ' +
                      DateFormat.yMd().format(DateTime.now()),
                  style: StyleManager.font12Regular(),
                ),
              ),
              verticalSpace(20.h),
              Text(
                StringManager.dataPrivacyAndTermsUpdateText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              StatefulBuilder(builder: (context, notifySetState) {
                return SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(StringManager.notifyUsersForDataPrivacyAndTermsUpdatesText),
                    value: notify,
                    onChanged: (value) {
                      notifySetState(() {
                        notify = value;
                      });
                    });
              }),
              verticalSpace(20.h),
              Row(
                children: [
                  Flexible(
                      flex: 2,
                      child: AppButton(
                          onPressed: () {
                          },
                          text: StringManager.saveChangesText)),
                  horizontalSpace(10.w),
                  Flexible(
                      child: AppOutlinedButton(
                          onPressed: () {
                            context.pop();
                          },
                          text: StringManager.cancelText)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
