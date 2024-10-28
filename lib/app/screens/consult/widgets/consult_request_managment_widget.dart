import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/app_container_with_shadow.dart';
import '../../../../core/widgets/app_padding.dart';

class ConsultRequestManagementWidget extends StatelessWidget {
  const ConsultRequestManagementWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      verticalPadding: 0,
      child: AppContainerWithShadow(
        child: Column(
          children: [
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: ColorManager.whiteColor,
                child: Icon(
                  Icons.account_circle,
                  size: 44.sp,
                ),
              ),
              title: Text(
                'User 10',
                style: StyleManager.font14SemiBold(),
              ),
              subtitle: Text(
                'Scheduled a New Appointment',
                style: StyleManager.font12Regular(
                    color: ColorManager.hintTextColor),
              ),
            ),
            const Divider(
              thickness: .5,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              isThreeLine: true,
              leading: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: ColorManager.hintTextColor, width: .5),
                ),
                child: Icon(
                  Icons.date_range_outlined,
                  color: ColorManager.hintTextColor,
                ),
              ),
              subtitle: Text(
                "${DateFormat().add_Hm().format(
                      DateTime.now(),
                    )} "
                "-"
                " ${DateFormat().add_jm().format(
                      DateTime.now(),
                    )} ,"
                " ${DateFormat.MMMd().format(
                  DateTime.now(),
                )}",
                style: StyleManager.font12SemiBold(),
              ),
              title: Text(
                StringManager.scheduleAtText,
                style: StyleManager.font12Medium(
                    color: ColorManager.hintTextColor),
              ),
            ),
            const Divider(
              thickness: .5,
            ),
            Row(
              children: [
                Flexible(
                    child: AppButton(
                        onPressed: () {}, text: StringManager.acceptText)),
                horizontalSpace(10.w),
                Flexible(
                    child: AppOutlinedButton(
                  onPressed: () {},
                  text: StringManager.cancelText,
                      color: ColorManager.errorColor,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
