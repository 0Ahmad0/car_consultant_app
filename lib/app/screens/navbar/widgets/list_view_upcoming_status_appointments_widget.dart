import 'package:car_consultant/app/screens/navbar/widgets/provider_appoinmtment_item_widget.dart';
import 'package:car_consultant/app/screens/navbar/widgets/upcoming_item_widget.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/widgets/no_appointments_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/appointment.dart';

class ListViewUpcomingStatusAppointmentsWidget extends StatelessWidget {
  final List list;
  final  List<Appointment> items;
  final String emptyListText;
  final  bool? isProvider;
  const ListViewUpcomingStatusAppointmentsWidget({
    super.key,
    required this.list,
    required this.emptyListText, required this.items, this.isProvider,
  });

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? NoAppointmentsWidget(text: emptyListText)
        : ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            itemBuilder: (context, index) =>
            (isProvider==true)?
            ProviderAppointmentItemWidget(status: list.first,appointment: items[index],):
                UpcomingItemWidget(status:
                list.first
                  ,appointment: items[index],),
                // UpcomingItemWidget(status: list[index],appointment: items[index],),
            separatorBuilder: (_, __) => verticalSpace(4.h),
            itemCount: items.length,
          );
  }
}
