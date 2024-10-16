import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.privacyPolicyText),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Html(data:  ConstValueManager.privacyPolicy['text'],
            ),
          ],
        ),
      ),
    );
  }
}
