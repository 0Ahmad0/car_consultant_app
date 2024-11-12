import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/user_model.dart';

class AdminRequestWidget extends StatelessWidget {
  const AdminRequestWidget({
    super.key,
    required this.title,
    required this.subTitle, this.user,
  });

  final String title;
  final String subTitle;
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 4.h
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.shadowColor,
            spreadRadius: 2.sp,
            blurRadius: 10.sp,
            offset: Offset(2.sp, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                subTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font12Regular(
                    color: ColorManager.hintTextColor),
              ),
            ),
          ),
          Divider(
            thickness: .5.sp,
          ),
          AppPaddingWidget(
            verticalPadding: 0,
            horizontalPadding: 50.w,
            child: AppButton(
              onPressed: () {
                context.pushNamed(Routes.adminRequestInfoRoute,arguments: {"user":user});
              },
              text: StringManager.viewText,
            ),
          )
        ],
      ),
    );
  }
}
