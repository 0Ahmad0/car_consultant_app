import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 3,
        sigmaY: 3,
      ),
      child: FadeInUp(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              width: double.maxFinite,
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
                          StringManager.deleteUserText,
                          style: StyleManager.font18SemiBold(),
                        ),
                        verticalSpace(10.h),
                        Text(
                          StringManager.areYouSureDeleteUSerText,
                          textAlign: TextAlign.center,
                          style: StyleManager.font14Regular(
                              color: ColorManager.hintTextColor),
                        ),
                        verticalSpace(10.h),
                        Row(
                          children: [
                            Flexible(
                                child: AppOutlinedButton(
                              onPressed: () {
                                context.pop();
                              },
                              text: StringManager.cancelText,
                            )),
                            horizontalSpace(10.w),
                            Flexible(
                                child: AppButton(
                                  color: ColorManager.errorColor,
                              onPressed: () {
                                    //ToDo Delete User
                              },
                              text: StringManager.deleteText,
                            )),
                          ],
                        )
                      ],
                    ),
                    PositionedDirectional(
                      end: 0,
                      child: InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(
                          Icons.close,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}