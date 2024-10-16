import 'package:car_consultant/app/screens/navbar/widgets/upcoming_item_widget.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/widgets/no_appointments_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewUpcomingStatusAppointmentsWidget extends StatelessWidget {
  final List list;
  final String emptyListText;

  const ListViewUpcomingStatusAppointmentsWidget({
    super.key,
    required this.list,
    required this.emptyListText,
  });

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? NoAppointmentsWidget(text: emptyListText)
        : ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            itemBuilder: (context, index) =>
                UpcomingItemWidget(status: list[index]),
            separatorBuilder: (_, __) => verticalSpace(4.h),
            itemCount: list.length,
          );
  }
}
