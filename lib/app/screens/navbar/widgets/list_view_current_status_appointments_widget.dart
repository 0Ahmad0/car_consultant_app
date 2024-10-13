import 'package:car_consultant/app/screens/navbar/widgets/current_item_widget.dart';
import 'package:car_consultant/app/screens/navbar/widgets/upcoming_item_widget.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/widgets/no_appointments_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListViewCurrentStatusAppointmentsWidget extends StatelessWidget {


  final List list;
  final String emptyListText;

  const ListViewCurrentStatusAppointmentsWidget({
    super.key,
    required this.list,
    required this.emptyListText,
  });

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? NoAppointmentsWidget(text: emptyListText)
        : ListView.separated(
        itemBuilder: (context, index) => CurrentItemWidget(status: list[index]),
        separatorBuilder: (_, __) => verticalSpace(4.h),
        itemCount: list.length
    );
  }
}
