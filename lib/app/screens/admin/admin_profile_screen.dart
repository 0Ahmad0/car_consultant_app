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
import '../navbar/widgets/profile_item_lIst_tile_widget.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

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
              Row(
                children: [
                  CircleAvatar(
                    radius: 34.sp,
                    child: Icon(Icons.person),
                  ),
                  horizontalSpace(10.w),
                  Flexible(
                    child: Text(
                      'User Name',
                    ),
                  )
                ],
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
                StringManager.systemSettingsText,
                style: StyleManager.font14SemiBold(
                    color: ColorManager.hintTextColor
                ),
              ),
              verticalSpace(10.h),
              ProfileItemLIstTileWidget(
                icon: Icons.monetization_on_outlined,
                title: StringManager.paymentSettingsText,
                route: Routes.paymentSettingRoute,
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.notifications_none,
                title: StringManager.notificationSettingsText,
                route: Routes.notificationSettingsRoute,
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.person_outline_sharp,
                title: StringManager.userRegistrationText,
                route: Routes.userRegistrationRoute
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.settings_applications_outlined,
                title: StringManager.applicationSettingsText,
                route: Routes.applicationSettingRoute,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

