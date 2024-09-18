import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:flutter/material.dart';

import '../../core/utils/const_value_manager.dart';

class PaymentOptionWidget extends StatelessWidget {
  const PaymentOptionWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        context.pushNamed(Routes.paymentInvoiceRoute,arguments: {
          'paymentText':ConstValueManager.paymentList[index]
        });
      },
      leading: CircleAvatar(),
      title: Text(ConstValueManager.paymentList[index]),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }
}
