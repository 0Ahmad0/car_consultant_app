import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/string_manager.dart';

class ProfileItemLIstTileWidget extends StatelessWidget {
  const ProfileItemLIstTileWidget({
    super.key,
    required this.title,
    required this.icon,
    this.route,
    this.onTap,
     this.showArrow = true,
  });

  final String title;
  final IconData icon;
  final String? route;
  final VoidCallback? onTap;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: route == null
          ? onTap
          : () {
              context.pushNamed(route!);
            },
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
      ),
      trailing: showArrow?Icon(Icons.keyboard_arrow_right,color: ColorManager.blackColor,):null,
      title: Text(
        title,
      ),
    );
  }
}
