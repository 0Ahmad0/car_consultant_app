import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/dialogs/sign_out_dialog.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/image_user_provider.dart';
import 'widgets/profile_item_lIst_tile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.profileText),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<ProfileController>(
                  init: Get.put(ProfileController()),
                  builder: (controller) {
                    return Row(
                      children: [
                        ImageUserProvider(
                          url: controller.currentUser.value?.photoUrl,
                          radius: 34.sp,
                        ),
                        // CircleAvatar(
                        //   radius: 34.sp,
                        //   child: Icon(Icons.person),
                        // ),
                        horizontalSpace(10.w),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [



                              Text(
                                controller.currentUser.value?.name ??
                                    'User Name',
                              ),
                              if(controller.currentUser.value!.typeUser!=null)...[
                                verticalSpace(10.h),
                                Text(
                                  controller.currentUser.value!.typeUser!,
                                  style: StyleManager.font14SemiBold(
                                      color: ColorManager.hintTextColor),
                                )
                              ]

                              ,
                            ],
                          ),
                        ),
                        // Text(
                        //   controller.currentUser.value?.name ??
                        //       'User Name',
                        // )
                      ],
                    );
                  }
              ),
              //
              verticalSpace(20.h),
              Text(
                StringManager.accountSettingText,
                style: StyleManager.font14SemiBold(
                  color: ColorManager.hintTextColor
                ),
              ),
              verticalSpace(10.h),
              ProfileItemLIstTileWidget(
                icon: Icons.person_outline,
                title: StringManager.personalInformationText,
                route: Routes.personalInformationRoute,
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.payment,
                title: StringManager.paymentText,
                route: Routes.paymentOptionRoute,
              ),
              // ProfileItemLIstTileWidget(
              //   icon: Icons.notifications_none,
              //   title: StringManager.notificationText,
              //   route: Routes.notificationsRoute,
              // ),
              ProfileItemLIstTileWidget(
                icon: Icons.settings_outlined,
                title: StringManager.settingText,
                route: Routes.settingRoute,
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.logout,
                title: StringManager.signOutText,
                showArrow: false,
                onTap: () {
                  Get.lazyPut(() => AuthController());
                  showDialog(
                    context: context,
                    builder: (_) => SignOutDialog(),
                  );
                },
              ),
              Divider(
                thickness: .5,
              ),
              verticalSpace(10.h),
              Text(
                StringManager.moreText,
                style: StyleManager.font14SemiBold(
                    color: ColorManager.hintTextColor
                ),
              ),
              verticalSpace(10.h),
              ProfileItemLIstTileWidget(
                icon: Icons.privacy_tip_outlined,
                title: StringManager.privacyPolicyText,
                route: Routes.privacyPolicyRoute,
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.monetization_on_outlined,
                title: StringManager.refundAndCancellationPolicyRouteText,
                route: Routes.refundAndCancellationPolicyRoute,
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.document_scanner,
                title: StringManager.termsAndConditionsText,
                route: Routes.termsAndConditionsRoute,
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.question_mark,
                title: StringManager.contactUsText,
                route: Routes.contactUsRoute,
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.info_outlined,
                title: StringManager.aboutUsText,
                route: Routes.aboutUsRoute,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

