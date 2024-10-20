import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:flutter/material.dart';

class AdminUserInfoScreen extends StatelessWidget {
  const AdminUserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.userInfoText),
      ),
    );
  }
}
