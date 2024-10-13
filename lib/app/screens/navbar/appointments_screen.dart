import 'package:car_consultant/app/screens/navbar/widgets/current_item_widget.dart';
import 'package:car_consultant/app/screens/navbar/widgets/list_view_previous_status_appointments_widget.dart';
import 'package:car_consultant/app/screens/navbar/widgets/previous_item_widget.dart';
import 'package:car_consultant/app/screens/navbar/widgets/upcoming_item_widget.dart';
import 'package:car_consultant/core/helpers/get_color_status_appointments.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../core/widgets/no_appointments_widget.dart';
import 'widgets/list_view_current_status_appointments_widget.dart';
import 'widgets/list_view_upcoming_status_appointments_widget.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ConstValueManager.lengthAppointmentsTabBar,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.whiteColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorManager.whiteColor),
          ),
          elevation: 0.0,
          title: Text(StringManager.appointmentsText),
          bottom: TabBar(
            indicatorPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            splashBorderRadius: BorderRadius.circular(8.r),
            tabs: ConstValueManager.tabs
                .map(
                  (e) => Tab(
                    text: e,
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          children: [
            ListViewUpcomingStatusAppointmentsWidget(
              list: [
                ColorAppointments.Confirmed,
                ColorAppointments.Rescheduled,
                ColorAppointments.Pending,
              ],
              emptyListText: ConstValueManager.tabs[0],
            ),
            ListViewCurrentStatusAppointmentsWidget(
              list: [
                ColorAppointments.Ongoing,
                ColorAppointments.StartingSoon,
                ColorAppointments.StartingSoon,
              ],
              emptyListText: ConstValueManager.tabs[1],
            ),
            ListViewPreviousStatusAppointmentsWidget(
              list: [
                ColorAppointments.Concluded,
                ColorAppointments.Concluded,
                ColorAppointments.Canceled,

              ],
              emptyListText: ConstValueManager.tabs[2],
            ),
          ],
        ),
      ),
    );
  }
}
