import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/utils/style_manager.dart';

class UsersAndConsultantsAndProvidersWidget extends StatelessWidget {
  const UsersAndConsultantsAndProvidersWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.status,
    this.onTap,
  });

  final String title;
  final String subTitle;
  final AdminUsersAndConsultantsStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ListTile(
              dense: true,
              leading: CircleAvatar(),
              title: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.font14Regular(),
              ),
              subtitle: Text(
                subTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    StyleManager.font12Regular(color: ColorManager.hintTextColor),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: status == AdminUsersAndConsultantsStatus.Active
                    ? ColorManager.activeColor.withOpacity(.15)
                    : ColorManager.blockedColor.withOpacity(.15)),
            child: Text(
              status == AdminUsersAndConsultantsStatus.Active
                  ? StringManager.activeText
                  : StringManager.blockedText,
              textAlign: TextAlign.center,
              style: StyleManager.font12Regular(
                  color: status == AdminUsersAndConsultantsStatus.Active
                      ? ColorManager.activeColor
                      : ColorManager.blockedColor),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.info_outline,
              ),
            ),
          )
        ],
      ),
    );
  }
}
