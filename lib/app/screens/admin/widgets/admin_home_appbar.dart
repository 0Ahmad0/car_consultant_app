import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/style_manager.dart';

class AdminHomeAppBarWidget extends StatelessWidget {
  const AdminHomeAppBarWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Image.asset(
            AssetsManager.logoIMG,
            width: 100.w,
            height: 100.h,
          ),
        ),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: StyleManager.font14SemiBold(),
          ),
        ),
      ],
    );
  }
}
