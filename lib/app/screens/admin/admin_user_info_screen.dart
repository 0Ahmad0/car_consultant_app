import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/dialogs/delete_user_dialog.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/style_manager.dart';
import '../../../core/widgets/app_container_with_shadow.dart';

class AdminUserInfoScreen extends StatelessWidget {
  const AdminUserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.userInfoText),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppContainerWithShadow(
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => DeleteUserDialog(),
                          );
                        },
                        child: Icon(Icons.delete_outline),
                      ),
                    ),
                    Row(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  ],
                ),
              ),
              verticalSpace(20.h),
              Text(
                StringManager.moreInformationText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              AppContainerWithShadow(
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringManager.createdText,
                          style: StyleManager.font14SemiBold(
                              color: ColorManager.primaryColor),
                        ),
                        Text(
                          DateFormat.d().add_yMMM().format(DateTime(1999)),
                          style: StyleManager.font12Regular(
                              color: ColorManager.hintTextColor),
                        ),
                        verticalSpace(10.h),
                        Text(
                          StringManager.appointmentsText,
                          style: StyleManager.font14SemiBold(
                              color: ColorManager.primaryColor),
                        ),
                        Text(
                          '${19}',
                          style: StyleManager.font12Regular(
                              color: ColorManager.hintTextColor),
                        ),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringManager.statusText,
                          style: StyleManager.font14SemiBold(
                              color: ColorManager.primaryColor),
                        ),
                        Text(
                          'Active',
                          style: StyleManager.font12Regular(
                              color: ColorManager.hintTextColor),
                        ),
                        verticalSpace(10.h),
                        Text(
                          StringManager.appointmentRatingText,
                          style: StyleManager.font14SemiBold(
                              color: ColorManager.primaryColor),
                        ),
                        Text(
                          '${10}',
                          style: StyleManager.font12Regular(
                              color: ColorManager.hintTextColor),
                        ),
                      ],
                    )),
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
