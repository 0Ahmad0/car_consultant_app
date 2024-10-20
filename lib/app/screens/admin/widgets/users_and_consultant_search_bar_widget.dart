import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/app_padding.dart';
import '../../../../core/widgets/app_search_text_filed.dart';

class UsersAndConsultantSearchWidget extends StatelessWidget {
  const UsersAndConsultantSearchWidget({
    super.key,
    this.onPressed,
    this.onChanged,
    this.onSubmitted,
  });

  final VoidCallback? onPressed;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(10.h),
        AppPaddingWidget(
          child: AppSearchTextFiled(
            onPressed: onPressed,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ),
        verticalSpace(10.h),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(color: ColorManager.grayColor),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  StringManager.userNameText,
                  // textAlign: TextAlign.center,
                  style: StyleManager.font14SemiBold(),
                ),
              ),
              Expanded(
                  child: Text(
                StringManager.statusText,
                textAlign: TextAlign.end,
                style: StyleManager.font14SemiBold(),
              )),
              Expanded(
                  child: Text(
                StringManager.infoText,
                textAlign: TextAlign.end,
                style: StyleManager.font14SemiBold(),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

class AdminAppointmentsSearchBarWithDate extends StatelessWidget {
  const AdminAppointmentsSearchBarWithDate({
    super.key,
    this.onPressed,
    this.onChanged,
    this.onSubmitted,
  });

  final VoidCallback? onPressed;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(10.h),
        AppPaddingWidget(
          child: AppSearchTextFiled(
            onPressed: onPressed,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          ),
        ),
        verticalSpace(10.h),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(color: ColorManager.grayColor),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  StringManager.userNameText,
                  textAlign: TextAlign.start,
                  style: StyleManager.font14SemiBold(),
                ),
              ),
              Expanded(
                  child: Text(
                StringManager.statusText,
                textAlign: TextAlign.start,
                style: StyleManager.font14SemiBold(),
              )),
              Expanded(
                  child: Text(
                StringManager.dateText,
                textAlign: TextAlign.center,
                style: StyleManager.font14SemiBold(),
              )),
              Expanded(
                  child: Text(
                StringManager.infoText,
                textAlign: TextAlign.end,
                style: StyleManager.font14SemiBold(),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
