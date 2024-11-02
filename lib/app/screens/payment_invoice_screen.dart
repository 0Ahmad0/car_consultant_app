import 'dart:math';

import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../controllers/request_order_controller.dart';

class PaymentInvoiceScreen extends StatelessWidget {
  const PaymentInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.paymentInvoiceText),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20.h),
              Text(
                StringManager.paymentConformationText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                          color: ColorManager.shadowColor.withOpacity(.9),
                          spreadRadius: 2.sp,
                          blurRadius: 10.sp,
                          offset: Offset(2.sp, 2.sp))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      style: StyleManager.font14Regular(
                              color: ColorManager.hintTextColor)
                          .copyWith(height: 2),
                      TextSpan(children: [
                        TextSpan(
                          text: StringManager.yourText,
                        ),
                        TextSpan(
                          text: args['paymentText'],
                          style: StyleManager.font14Bold(),
                        ),
                        TextSpan(
                          text: StringManager.yourRequestCreatedText,
                        ),
                      ]),
                    ),
                    verticalSpace(20.h),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: ColorManager.grayColor,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                                color: ColorManager.shadowColor.withOpacity(.9),
                                offset: Offset(2.sp, 2.sp),
                                blurRadius: 10.sp,
                                spreadRadius: 2.sp)
                          ]),
                      child: Text(
                       "${ (DateTime.now().hour+12345)*12345 + (DateTime.now().minute~/2)*123}",
                       // "${ Random().nextInt(1000000000)}",
                        // 'Invoice Number',
                        style: StyleManager.font16SemiBold(),
                      ),
                    ),
                    verticalSpace(20.h),
                    Text(
                      StringManager.toPayInvoiceFollowStepsText,
                      style: StyleManager.font14Regular(
                          color: ColorManager.hintTextColor),
                    ),
                    verticalSpace(10.h),
                    Text.rich(
                      textAlign: TextAlign.start,
                      style: StyleManager.font12Regular(
                              color: ColorManager.hintTextColor)
                          .copyWith(height: 2),
                      TextSpan(children: [
                        TextSpan(
                          text: StringManager.paymentInvoiceSteps[0],
                        ),
                        TextSpan(
                          text: StringManager.paymentInvoiceSteps[1],
                        ),
                        TextSpan(
                            text: args['paymentText'],
                            style: StyleManager.font12SemiBold(
                                color: ColorManager.blackColor)),
                        TextSpan(
                          text: StringManager.paymentInvoiceSteps[2],
                        ),
                        TextSpan(
                          text: StringManager.paymentInvoiceSteps[3],
                        ),
                      ]),
                    ),
                    verticalSpace(100.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        StringManager.expirationText,
                        textAlign: TextAlign.center,
                        style: StyleManager.font16SemiBold(
                            color: ColorManager.primaryColor),
                      ),
                    ),
                    verticalSpace(10.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        DateFormat.yMMMd().add_jm().format(DateTime.now()),
                        textAlign: TextAlign.center,
                        style: StyleManager.font14Bold(),
                      ),
                    ),
                    verticalSpace(10.h),
                    AppButton(
                      onPressed: () {
                        Get.put(RequestOrderController()).addAppointment(context);
                      },
                      text: StringManager.continueText,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
