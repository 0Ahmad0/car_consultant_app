import 'package:car_consultant/core/enums/enums.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/helpers/get_color_status_appointments.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/style_manager.dart';
import 'widgets/admin_appointments_widget.dart';
import 'widgets/users_and_consultant_search_bar_widget.dart';

class AdminAppointmentsScreen extends StatelessWidget {
  const AdminAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.appointmentsText),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AdminAppointmentsSearchBarWithDate(),
          ),
          SliverList.separated(
            itemBuilder: (context, index) => AppointmentsAdminWidget(
              title: 'User ${index+1}',
              subTitle: 'Type ${index/100}',
              date: DateFormat.d().add_yMMM().format(DateTime.now()),
              status: ConstValueManager.adminAppointmentsList[index],
            ),
            separatorBuilder: (_, __) => Divider(
              thickness: .5.sp,
              height: 0,
            ),
            itemCount: ConstValueManager.adminAppointmentsList.length,
          )
        ],
      ),
    );
  }
}
