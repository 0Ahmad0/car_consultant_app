import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/color_manager.dart';
import '../../../core/utils/const_value_manager.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_container_with_shadow.dart';

class AdminUserRegistrationScreen extends StatefulWidget {
  const AdminUserRegistrationScreen({super.key});

  @override
  State<AdminUserRegistrationScreen> createState() => _AdminUserRegistrationScreenState();
}

class _AdminUserRegistrationScreenState extends State<AdminUserRegistrationScreen> {

  bool emailVerification = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.userRegistrationText),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: AppPaddingWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringManager.mandatoryRegistrationFieldsText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppContainerWithShadow(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            ConstValueManager.mandatoryRegistrationList.length,
                            (index) =>
                                StatefulBuilder(builder: (context, checkBoxSetState) {
                                  return InkWell(
                                    onTap: () {
                                      checkBoxSetState(() {
                                        ConstValueManager
                                                .mandatoryRegistrationList[index]
                                                .isSelected =
                                            !ConstValueManager
                                                .mandatoryRegistrationList[index]
                                                .isSelected;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: ConstValueManager
                                                .mandatoryRegistrationList[index]
                                                .isSelected,
                                            onChanged: (value) {
                                              checkBoxSetState(() {
                                                ConstValueManager
                                                    .mandatoryRegistrationList[index]
                                                    .isSelected = value!;
                                              });
                                            }),
                                        horizontalSpace(10.w),
                                        Text(
                                          ConstValueManager
                                              .mandatoryRegistrationList[index].text,
                                          style: StyleManager.font14Regular(
                                              color: ConstValueManager
                                                      .mandatoryRegistrationList[
                                                          index]
                                                      .isSelected
                                                  ? ColorManager.primaryColor
                                                  : ColorManager.hintTextColor),
                                        )
                                      ],
                                    ),
                                  );
                                })),
                      ),
                    ),
                    verticalSpace(20.h),
                    Text(
                      StringManager.emailVerificationText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    StatefulBuilder(builder: (context, notificationSetState) {
                      return SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            StringManager.requireEmailVerificationText,
                            style: StyleManager.font14Regular(),
                          ),
                          value: emailVerification,
                          onChanged: (value) {
                            notificationSetState(() {
                              emailVerification = value;
                            });
                          });
                    })
                  ],
                ),
              ),
            ),
          ),
          AppPaddingWidget(
            child: Row(
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
            ),
          )

        ],
      ),
    );
  }
}
