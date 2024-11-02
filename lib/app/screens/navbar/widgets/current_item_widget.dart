import 'package:car_consultant/core/helpers/get_color_status_appointments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/appointment.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/app_padding.dart';

class CurrentItemWidget extends StatelessWidget {
  const CurrentItemWidget({super.key, required this.status, this.appointment});

  final ColorAppointments status;
  final Appointment? appointment;
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
          Row(
            children: [
              Flexible(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  isThreeLine: true,
                  leading: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: ColorManager.hintTextColor, width: .5),
                    ),
                    child: Icon(
                      Icons.date_range_outlined,
                      color: ColorManager.hintTextColor,
                    ),
                  ),
                  title: Text(
                    "${

                        DateFormat('h:mm').format(
                          appointment?.fromHour??DateTime.now(),
                        )} "
                        "-"
                        " ${DateFormat().add_jm().format(
                      appointment?.toHour??DateTime.now(),
                    )} ,"
                        " ${DateFormat.MMMd().format(
                      appointment?.selectDate??DateTime.now(),
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
                ),
              ),
              status == ColorAppointments.StartingSoon
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.chat_outlined,
                            )),
                        IconButton(
                          onPressed: () {},
                          icon: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(
                                Icons.date_range,
                              ),
                              PositionedDirectional(
                                bottom: -6.h,
                                end: -6.w,
                                child: CircleAvatar(
                                  backgroundColor: ColorManager.whiteColor,
                                  radius: 8.sp,
                                  child: Icon(
                                    Icons.refresh,
                                    size: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chat_outlined,
                      )),
            ],
          )
        ],
      ),
    );
  }
}
