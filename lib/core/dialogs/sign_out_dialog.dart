import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/controllers/auth_controller.dart';
import '../widgets/app_button.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      StringManager.signOutText,
                      style: StyleManager.font20Bold(),
                    ),
                    verticalSpace(10.h),
                    Text(
                      StringManager.doYouWantToSignoutText,
                      style: StyleManager.font14Regular(
                          color: ColorManager.hintTextColor),
                    ),
                    verticalSpace(10.h),
                    Row(
                      children: [
                        Flexible(
                            child: AppButton(
                          onPressed: () {
                            AuthController.instance.signOut(context);

                          },
                          text: StringManager.signOutText,
                        )),
                        horizontalSpace(20.w),
                        Flexible(
                            child: AppOutlinedButton(
                          onPressed: () {
                            context.pop();
                          },
                          text: StringManager.cancelText,
                        )),
                      ],
                    )
                  ],
                ),
                Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(Icons.close),
                    )

                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}
