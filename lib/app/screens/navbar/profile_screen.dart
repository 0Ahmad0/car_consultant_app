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

import '../../controllers/auth_controller.dart';
import 'widgets/about_section_widget.dart';
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
              AboutSectionWidget(),
              Divider(),
              ProfileItemLIstTileWidget(
                icon: Icons.message,
                title: StringManager.messageText,
                route: Routes.messagesRoute,
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.payment,
                title: StringManager.paymentText,
                route: Routes.messagesRoute,
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.notifications_none,
                title: StringManager.notificationText,
                route: Routes.notificationsRoute,
              ),
              Divider(),
              ProfileItemLIstTileWidget(
                icon: Icons.settings_outlined,
                title: StringManager.settingText,
                route: '',
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.logout,
                title: StringManager.signOutText,
                onTap: () {
                  Get.lazyPut(() => AuthController());
                  AuthController.instance.signOut(context);

                  // showDialog(
                  //   context: context,
                  //   builder: (_) => Center(
                  //     child: CircularProgressIndicator(),
                  //   ),
                  // );
                },
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.privacy_tip_outlined,
                title: StringManager.privacyPolicyText,
                route: '',
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.document_scanner,
                title: StringManager.termsAndConditionsText,
                route: '',
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.question_mark,
                title: StringManager.customerSupportText,
                route: '',
              ),
              ProfileItemLIstTileWidget(
                icon: Icons.info_outlined,
                title: StringManager.aboutText,
                route: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
