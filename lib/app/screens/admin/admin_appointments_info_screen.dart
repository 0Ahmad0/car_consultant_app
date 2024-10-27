import 'package:car_consultant/core/helpers/get_color_status_appointments.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_container_with_shadow.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AdminAppointmentsInfoScreen extends StatelessWidget {
  const AdminAppointmentsInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.appointmentInfoText),
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
                      StringManager.appointmentInformationText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppContainerWithShadow(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringManager.dateText,
                                  style: StyleManager.font14SemiBold(
                                      color: ColorManager.primaryColor),
                                ),
                                Text(
                                  DateFormat.d()
                                      .add_yMMM()
                                      .format(DateTime.now()),
                                  style: StyleManager.font12Regular(
                                      color: ColorManager.hintTextColor),
                                ),
                                verticalSpace(10.h),
                                Text(
                                  StringManager.timeText,
                                  style: StyleManager.font14SemiBold(
                                      color: ColorManager.primaryColor),
                                ),
                                Text(
                                  '9:00-9:30 AM',
                                  style: StyleManager.font12Regular(
                                      color: ColorManager.hintTextColor),
                                ),
                                verticalSpace(10.h),
                                Text(
                                  StringManager.paymentText,
                                  style: StyleManager.font14SemiBold(
                                      color: ColorManager.primaryColor),
                                ),
                                Text(
                                  'Done',
                                  style: StyleManager.font12Regular(
                                      color: ColorManager.hintTextColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringManager.typeText,
                                  style: StyleManager.font14SemiBold(
                                      color: ColorManager.primaryColor),
                                ),
                                Text(
                                  'Consultation',
                                  style: StyleManager.font12Regular(
                                      color: ColorManager.hintTextColor),
                                ),
                                verticalSpace(10.h),
                                Text(
                                  StringManager.statusText,
                                  style: StyleManager.font14SemiBold(
                                      color: ColorManager.primaryColor),
                                ),
                                Text(
                                  args['status'],
                                  style: StyleManager.font12Regular(
                                      color: ColorManager.hintTextColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(20.h),
                    Text(
                      StringManager.appointmentSetByText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppContainerWithShadow(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorManager.whiteColor,
                            radius: 30.sp,
                            child: Icon(
                              Icons.account_circle,
                              size: 60.sp,
                            ),
                          ),
                          horizontalSpace(20.w),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringManager.nameText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        'User 14',
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                      verticalSpace(10.h),
                                      Text(
                                        StringManager.dateOfBirthText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        DateFormat.d()
                                            .add_yMMM()
                                            .format(DateTime.now()),
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                      verticalSpace(10.h),
                                      Text(
                                        StringManager.phoneText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        '0501882888',
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringManager.emailText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        'user14@mail.com',
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    verticalSpace(20.h),
                    Text(
                      StringManager.appointmentSetWithText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppContainerWithShadow(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorManager.whiteColor,
                            radius: 30.sp,
                            child: Image.asset(
                              AssetsManager.consultIMG,
                            ),
                          ),
                          horizontalSpace(20.w),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringManager.nameText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        'User 14',
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                      verticalSpace(10.h),
                                      Text(
                                        StringManager.dateOfBirthText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        DateFormat.d()
                                            .add_yMMM()
                                            .format(DateTime.now()),
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                      verticalSpace(10.h),
                                      Text(
                                        StringManager.phoneText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        '0501882888',
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringManager.emailText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        'user14@mail.com',
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: args['status'] == ColorAppointments.Pending.name,
            child: AppPaddingWidget(
                child: AppButton(
                    onPressed: () {}, text: StringManager.confirmPaymentText)),
          )
        ],
      ),
    );
  }
}
