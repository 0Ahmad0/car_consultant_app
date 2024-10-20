import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/get_color_status_appointments.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/style_manager.dart';

class AppointmentsAdminWidget extends StatelessWidget {
  const AppointmentsAdminWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.status,
  });

  final String title;
  final String subTitle;
  final String date;
  final ColorAppointments status;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ListTile(
              dense: true,
              leading: CircleAvatar(),
              title: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font14Regular(),
              ),
              subtitle: Text(
                subTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font12Regular(
                    color: ColorManager.hintTextColor),
              ),
            ),
          ),
          Expanded(
            child: Text(
              date,
              textAlign: TextAlign.start,
              style: StyleManager.font10Regular(),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: getColorStatusAppointments(status).withOpacity(.15),
              ),
              child: Text(
                status.name,
                textAlign: TextAlign.center,
                style: StyleManager.font10Regular(
                    color: getColorStatusAppointments(status)),
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.info_outline,
              ),
            ),
          )
        ],
      ),
    );
  }
}