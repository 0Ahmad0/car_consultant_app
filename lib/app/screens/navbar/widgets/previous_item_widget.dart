import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/get_color_status_appointments.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/app_padding.dart';

class PreviousItemWidget extends StatelessWidget {
  const PreviousItemWidget({super.key, required this.status});

  final ColorAppointments status;

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(
              'Consultant 1',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  StyleManager.font16SemiBold(color: ColorManager.blackColor),
            ),
            leading: Container(
              width: 50.w,
              height: 50.w,
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Image.asset(AssetsManager.consultantServiceIMG),
            ),
            trailing: status == ColorAppointments.Pending
                ? IconButton(
                    onPressed: () {}, icon: Icon(Icons.location_on_outlined))
                : null,
          ),
          const Divider(
            thickness: .5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StringManager.statusText,
                style:
                    StyleManager.font14Bold(color: ColorManager.hintTextColor),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: getColorStatusAppointments(status).withOpacity(.175),
                ),
                child: Text(
                  status.name,
                  style: StyleManager.font14SemiBold(
                      color: getColorStatusAppointments(status)),
                ),
              )
            ],
          ),
          verticalSpace(10.h),
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
            title: Text(
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
            subtitle: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                StringManager.scheduleText,
                style: StyleManager.font12Medium(
                    color: ColorManager.hintTextColor),
              ),
            ),
            trailing: status == ColorAppointments.Canceled
                ? null
                : InkWell(
                    onTap: () {
                      context.pushNamed(Routes.reviewRoute);
                    },
                    child: Image.asset(
                      AssetsManager.rateIcon,
                      height: 30.h,
                      width: 100.w,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
