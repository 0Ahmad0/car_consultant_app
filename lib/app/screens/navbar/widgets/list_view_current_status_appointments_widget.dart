import 'package:car_consultant/app/screens/navbar/widgets/current_item_widget.dart';
import 'package:car_consultant/app/screens/navbar/widgets/provider_appoinmtment_item_widget.dart';
import 'package:car_consultant/app/screens/navbar/widgets/upcoming_item_widget.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/widgets/no_appointments_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/models/appointment.dart';
import '../../../controllers/profile_controller.dart';

class ListViewCurrentStatusAppointmentsWidget extends StatelessWidget {


  final List list;
  final String emptyListText;
  final  List<Appointment> items;
  final  bool? isProvider;

  const ListViewCurrentStatusAppointmentsWidget({
    super.key,
    required this.list,
    required this.emptyListText, required this.items, this.isProvider,
  });

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? NoAppointmentsWidget(text: emptyListText)
        : ListView.separated(
        itemBuilder: (context, index) =>
        (isProvider==true)?

            ProviderAppointmentItemWidget(status: list.first,appointment: items[index],)
            :CurrentItemWidget(status: list.first,appointment: items[index],),
            // CurrentItemWidget(status: list[index]),
        separatorBuilder: (_, __) => verticalSpace(4.h),
        itemCount: items.length
    );
  }
}
