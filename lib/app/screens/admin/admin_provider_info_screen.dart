import 'package:car_consultant/core/helpers/get_color_status_appointments.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/dialogs/delete_user_dialog.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/models/user_model.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/style_manager.dart';
import '../../../core/widgets/app_container_with_shadow.dart';

class AdminProviderInfoScreen extends StatelessWidget {
   AdminProviderInfoScreen({super.key});
  UserModel? provider;
  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    provider=args['provider'];
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.providerInfoText),
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
                              child: Image.asset(AssetsManager.providerIMG),
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
                                          provider?.name?? 'User 14',
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
                                              .format(
                                              provider?.birthDate??
                                              DateTime.now()),
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
                                          provider?.phoneNumber??'0501882888',
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
                                          provider?.email??'user14@mail.com',
                                          style: StyleManager.font12Regular(
                                              color:
                                              ColorManager.hintTextColor),
                                        ),
                                        verticalSpace(10.h),
                                        Text(
                                          StringManager.locationText,
                                          style: StyleManager.font14SemiBold(
                                              color: ColorManager.primaryColor),
                                        ),
                                        Text(
                                          provider?.additionalInfo?.location?.address??  'MERA2749',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
                    StringManager.aboutText,
                    style: StyleManager.font16SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppContainerWithShadow(
                    child: Text(
                      provider?.additionalInfo?.about??
                      'Service Provider with over 10 years of experience in delivering quality services and ensuring customer satisfaction.',
                      style: StyleManager.font12Regular(
                          color: ColorManager.hintTextColor),
                    ),
                  ),
                  verticalSpace(20.h),
                  Text(
                    StringManager.expertiseText,
                    style: StyleManager.font16SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppContainerWithShadow(
                    child: Text(
                      provider?.additionalInfo?.expertise??
                      """. Engine diagnostics and repair
. Brake systems maintenance
. Fuel systems inspection and repair""",
                      style: StyleManager.font12Regular(
                          color: ColorManager.hintTextColor),
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
                        leading: Icon(Icons.account_circle,size: 60.sp),
                        title: Text(
                          'User 7',
                          style: StyleManager.font14SemiBold(),
                        ),
                      ),
                      verticalSpace(10.h),
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
                                    ColorAppointments.Concluded)
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
                                  color: ColorManager.hintTextColor)),
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
