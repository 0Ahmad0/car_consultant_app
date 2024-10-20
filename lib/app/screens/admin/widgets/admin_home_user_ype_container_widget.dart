import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/app_button.dart';

class AdminHomeUserTypeContainerWidget extends StatelessWidget {
  const AdminHomeUserTypeContainerWidget({
    super.key,
    required this.typeText,
  });

  final String typeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(
        vertical: 10.h
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: ColorManager.whiteColor,
          boxShadow: [
            BoxShadow(
                color: ColorManager.shadowColor,
                blurRadius: 10.sp,
                spreadRadius: 2.sp,
                offset: Offset(2.sp, 0))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsetsDirectional.zero,
            leading: CircleAvatar(),
            title: Text(
              'User 10',
              style: StyleManager.font14SemiBold(),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                StringManager.requestedToBeText +' ' +typeText,
                style: StyleManager.font14Regular(
                    color: ColorManager.hintTextColor),
              ),
            ),
          ),
          const Divider(
            thickness: .5,
          ),

          Row(
            children: [
              Flexible(child: AppButton(onPressed: (){}, text: StringManager.viewText)),
              horizontalSpace(10.w),
              Flexible(child: AppOutlinedButton(onPressed: (){}, text: StringManager.dismissText)),
            ],
          )
        ],
      ),
    );
  }
}
