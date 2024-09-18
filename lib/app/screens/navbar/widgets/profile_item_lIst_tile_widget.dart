import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/string_manager.dart';

class ProfileItemLIstTileWidget extends StatelessWidget {
  const ProfileItemLIstTileWidget({
    super.key,
    required this.title,
    required this.icon,
    this.route,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final String? route;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: route == null
          ? onTap
          : () {
              context.pushNamed(route!);
            },
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
      ),
      title: Text(
        title,
      ),
    );
  }
}
