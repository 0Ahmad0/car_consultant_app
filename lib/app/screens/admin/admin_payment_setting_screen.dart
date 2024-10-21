import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_container_with_shadow.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield_with_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminPaymentSettingScreen extends StatefulWidget {
  const AdminPaymentSettingScreen({super.key});

  @override
  State<AdminPaymentSettingScreen> createState() =>
      _AdminPaymentSettingScreenState();
}

class _AdminPaymentSettingScreenState extends State<AdminPaymentSettingScreen> {
  final commissionRateController = TextEditingController(text: '5%');
  bool notificationValue = false;

  @override
  void dispose() {
    commissionRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.paymentSettingsText),
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
                      StringManager.paymentMethodText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppContainerWithShadow(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            ConstValueManager.paymentList.length,
                            (index) => StatefulBuilder(
                                    builder: (context, checkBoxSetState) {
                                  return InkWell(
                                    onTap: () {
                                      checkBoxSetState(() {
                                        ConstValueManager
                                                .paymentList[index].isSelected =
                                            !ConstValueManager
                                                .paymentList[index].isSelected;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: ConstValueManager
                                                .paymentList[index].isSelected,
                                            onChanged: (value) {
                                              checkBoxSetState(() {
                                                ConstValueManager
                                                    .paymentList[index]
                                                    .isSelected = value!;
                                              });
                                            }),
                                        horizontalSpace(10.w),
                                        Text(
                                          ConstValueManager
                                              .paymentList[index].text,
                                          style: StyleManager.font14Regular(
                                              color: ConstValueManager
                                                      .paymentList[index]
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
                      StringManager.commissionRateText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    AppTextFiledWithEdit(
                      controller: commissionRateController,
                    ),
                    verticalSpace(20.h),
                    Text(
                      StringManager.paymentNotificationsText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    StatefulBuilder(builder: (context, notificationSetState) {
                      return SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            StringManager.sendPaymentConfirmationsText,
                            style: StyleManager.font14Regular(),
                          ),
                          value: notificationValue,
                          onChanged: (value) {
                            notificationSetState(() {
                              notificationValue = value;
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
                          if (commissionRateController.text.isNotEmpty) {
                            
                          }
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
