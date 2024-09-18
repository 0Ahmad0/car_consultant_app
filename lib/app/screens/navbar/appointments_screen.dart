import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
            tabs: [
              Tab(
                text: 'Upcoming',
              ),
              Tab(
                text: 'History',
              ),
              Tab(
                text: 'Draft',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.indigo,
            ),
            Container(
              color: Colors.cyan,
            ),
          ],
        ),
      ),
    );
  }
}
