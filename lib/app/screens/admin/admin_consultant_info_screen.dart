import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:flutter/material.dart';

class AdminConsultantInfoScreen extends StatelessWidget {
  const AdminConsultantInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.consultantInfoText),
      ),
    );
  }
}
