import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RefundAndCancellationPolicyScreen extends StatelessWidget {
  const RefundAndCancellationPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.refundAndCancellationPolicyRouteText),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Html(data: ConstValueManager.refundAndCancellationPolicy['text'])
          ],
        ),
      ),
    );
  }
}
