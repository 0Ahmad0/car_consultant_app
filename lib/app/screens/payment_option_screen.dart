import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/no_data_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/payment_option_widget.dart';

class PaymentOptionScreen extends StatelessWidget {
  const PaymentOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.paymentOptionText),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(Routes.addNewCardRoute);
            },
            icon: Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: ConstValueManager.paymentList.isEmpty
          ? NoDataFoundWidget()
          : ListView.separated(
              separatorBuilder: (_, __) => Divider(height: 2.h),
              itemBuilder: (context, index) => PaymentOptionWidget(
                index: index,
              ),
              itemCount: ConstValueManager.paymentList.length,
            ),
    );
  }
}
