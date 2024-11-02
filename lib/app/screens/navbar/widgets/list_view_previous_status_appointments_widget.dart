import 'package:car_consultant/app/screens/navbar/widgets/previous_item_widget.dart';
import 'package:car_consultant/app/screens/navbar/widgets/upcoming_item_widget.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/widgets/no_appointments_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/appointment.dart';

class ListViewPreviousStatusAppointmentsWidget extends StatelessWidget {


  final List list;
  final String emptyListText;
  final  List<Appointment> items;
  const ListViewPreviousStatusAppointmentsWidget({
    super.key,
    required this.list,
    required this.emptyListText, required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? NoAppointmentsWidget(text: emptyListText)
        : ListView.separated(
        itemBuilder: (context, index) =>
            PreviousItemWidget(status: list.first,appointment: items[index],),
            // PreviousItemWidget(status: list[index]),
        separatorBuilder: (_, __) => verticalSpace(4.h),
        itemCount: items.length
    );
  }
}
