import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewCarScreen extends StatelessWidget {
  const AddNewCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.addNewCardText),
      ),
      body: AppPaddingWidget(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        hintText: StringManager.cardNumberText,
                      ),
                      verticalSpace(20.h),
                      AppTextField(
                        hintText: StringManager.cardHolderNameText,
                      ),
                      verticalSpace(20.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringManager.expirationDateText,
                                  style: StyleManager.font14Bold(),
                                ),
                                verticalSpace(10.h),
                                AppTextField(
                                  hintText: StringManager.expirationDateHintText,
                                ),
                              ],
                            ),
                          ),
                          horizontalSpace(10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringManager.cvvText,
                                  style: StyleManager.font14Bold(),
                                ),
                                verticalSpace(10.h),
                                AppTextField(
                                  hintText: StringManager.cvvText,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            AppButton(onPressed: (){
              context.pushNamed(
                Routes.paymentSuccessfulRoute
              );
            }, text: StringManager.payText)
          ],
        ),
      ),
    );
  }
}
