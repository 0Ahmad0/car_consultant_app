import 'dart:developer';

import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../core/widgets/app_padding.dart';
import '../../controllers/profile_controller.dart';
import 'widgets/home_service_full_width_widget.dart';
import 'widgets/home_service_widget.dart';

var _borderTextFiled = ({Color color = ColorManager.primaryColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: color));

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.homeText),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringManager.welcomeBackText,
                          style: StyleManager.font14SemiBold(
                              color: ColorManager.hintTextColor),
                        ),
                        verticalSpace(10.h),
    GetBuilder<ProfileController>(
   init: Get.put(ProfileController()),
    builder: (controller) {
                       return Text(
                         controller.currentUser.value?.name??  'User Name',
                          style: StyleManager.font16Regular(),
                        );}),
                      ],
                    ),
                  )
                ],
              ),
              verticalSpace(20.h),
              TextField(
                onSubmitted: (value) {
                  log('${value}');
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorManager.grayColor,
                    border: _borderTextFiled(),
                    focusedBorder:
                        _borderTextFiled(color: ColorManager.primaryColor),
                    enabledBorder:
                        _borderTextFiled(color: ColorManager.hintTextColor),
                    hintText: StringManager.whatAreYouLookingText,
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    )),
              ),
              verticalSpace(20.h),
              Text(
                StringManager.servicesText,
                style: StyleManager.font20SemiBold(),
              ),
              verticalSpace(20.h),
              Row(
                children: [
                  Expanded(
                    child: HomeServiceWidget(
                      image: AssetsManager.consultantServiceIMG,
                      text: StringManager.consultantServiceText,
                      route: Routes.consultantServiceRoute,
                    ),
                  ),
                  horizontalSpace(28.w),
                  Expanded(
                    child: HomeServiceWidget(
                      image: AssetsManager.serviceProviderIMG,
                      text: StringManager.serviceProviderText,
                    ),
                  ),
                ],
              ),
              verticalSpace(20.h),
              Row(
                children: [
                  Expanded(
                    child: HomeServiceWidget(
                      image: AssetsManager.educationalResourcesIMG,
                      text: StringManager.educationalResourcesText,
                    ),
                  ),
                  horizontalSpace(28.w),
                  Expanded(
                    child: HomeServiceWidget(
                      image: AssetsManager.emergencyServicesIMG,
                      text: StringManager.emergencyServicesText,
                    ),
                  ),
                ],
              ),
              verticalSpace(20.h),
              HomeServiceFullWidthWidget(
                image: AssetsManager.freelanceOpportunitiesIMG,
                title: StringManager.freelanceOpportunitiesText,
                subTitle: StringManager.becomeCarText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
