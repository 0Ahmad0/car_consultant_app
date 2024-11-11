import 'package:car_consultant/app/screens/navbar/widgets/home_service_full_width_widget.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceProviderControlPanelScreen extends StatelessWidget {
  const ServiceProviderControlPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringManager.consultantControlPanelText,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: AppPaddingWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeServiceFullWidthWidget(
                  image: AssetsManager.manageRequestIMG,
                  title: StringManager.manageRequestTitleText,
                  subTitle: StringManager.manageRequestSubTitleText,
                  route: Routes.serviceProviderManageRequestRoute,
                ),
                verticalSpace(20.h),
                HomeServiceFullWidthWidget(
                  image: AssetsManager.appointmentsOverviewIMG,
                  title: StringManager.appointmentsOverviewTitleText,
                  subTitle: StringManager.appointmentsOverviewSubTitleText,
                  route: Routes.serviceProviderManageAppointmentsRoute,
                ),
                verticalSpace(20.h),
                HomeServiceFullWidthWidget(
                  image: AssetsManager.manageProfileIMG,
                  title: StringManager.manageProfileTitleText,
                  subTitle: StringManager.manageProfileSubTitleText,
                  route: Routes.serviceProviderManageProfileRoute,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
