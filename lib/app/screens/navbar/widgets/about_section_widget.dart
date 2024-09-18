import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/utils/style_manager.dart';

class AboutSectionWidget extends StatelessWidget {
  const AboutSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringManager.aboutText,style: StyleManager.font16SemiBold(),),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.person_outline),
          title: Text(StringManager.personalInformationText),
          subtitle: Text(
            '${StringManager.privacyText}, ${StringManager.securityText}',
            style: StyleManager.font12Regular(
                color: ColorManager.hintTextColor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 14.sp,
          ),
        ),
      ],
    );
  }
}
