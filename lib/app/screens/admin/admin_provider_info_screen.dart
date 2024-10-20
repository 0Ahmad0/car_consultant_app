import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:flutter/material.dart';

class AdminProviderInfoScreen extends StatelessWidget {
  const AdminProviderInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.providerInfoText),
      ),
    );
  }
}
