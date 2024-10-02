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

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Upcoming', 'Current', 'Previous'];
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
            tabs: [
              Tab(
                text: tabs[0],
              ),
              Tab(
                text: tabs[1],
              ),
              Tab(
                text: tabs[2],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NoAppointmentsWidget(text: tabs[0],),
            NoAppointmentsWidget(text: tabs[1],),
            NoAppointmentsWidget(text: tabs[2],),
          ],
        ),
      ),
    );
  }
}
