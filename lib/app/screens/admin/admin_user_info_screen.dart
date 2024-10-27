import 'package:car_consultant/core/helpers/get_color_status_appointments.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
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
                                              color:
                                                  ColorManager.hintTextColor),
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
                                              color:
                                                  ColorManager.hintTextColor),
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
                                              color:
                                                  ColorManager.hintTextColor),
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
                                              color:
                                                  ColorManager.hintTextColor),
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
                  ),
                  verticalSpace(20.h),
                  Text(
                    StringManager.latestAppointmentsText,
                    style: StyleManager.font16SemiBold(),
                  ),
                  verticalSpace(10.h),
                ],
              ),
            ),
          ),
          SliverList.separated(
              itemCount: 4,
              itemBuilder: (context, index) => AppPaddingWidget(
                    verticalPadding: 4,
                    child: AppContainerWithShadow(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Image.asset(
                              AssetsManager.consultIMG,
                            ),
                            title: Text(
                              'Consultant 7',
                              style: StyleManager.font14SemiBold(),
                            ),
                          ),
                          const Divider(
                            thickness: .5,
                          ),
                          Row(
                            children: [
                              Text(
                                StringManager.statusText,
                                style: StyleManager.font14SemiBold(
                                    color: ColorManager.hintTextColor),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                    color: getColorStatusAppointments(
                                            ColorAppointments.Confirmed)
                                        .withOpacity(.15),
                                    borderRadius: BorderRadius.circular(6.r)),
                                child: Text(
                                  ColorAppointments.Confirmed.name,
                                  style: StyleManager.font10Regular(
                                      color: getColorStatusAppointments(
                                          ColorAppointments.Confirmed)),
                                ),
                              )
                            ],
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: Text(
                              StringManager.scheduleText,
                              style: StyleManager.font12SemiBold(),
                            ),
                            subtitle: Text(
                              '9:00-9:30 AM ,  ${DateFormat.d().add_yMMM().format(DateTime.now())}',
                              style: StyleManager.font12Regular(
                                  color: ColorManager.hintTextColor),
                            ),
                            leading: Container(
                              padding: EdgeInsets.all(8.sp),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorManager.hintTextColor
                                )
                              ),
                              child: Icon(Icons.date_range_outlined),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              separatorBuilder: (_, __) => verticalSpace(10.h))
        ],
      ),
    );
  }
}
