import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/string_manager.dart';
import '../../core/utils/style_manager.dart';
import '../controllers/request_order_controller.dart';

class OrderDetailsSectionWidget extends StatelessWidget {
  const OrderDetailsSectionWidget({
    super.key, this.fee, this.typeUser,
  });
  final int? fee;
  final String? typeUser;
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context)
            .copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            StringManager.orderDetailsText,
            style: StyleManager.font14SemiBold(),
          ),
          children: [
            Divider(
              height: 1.0,
            ),
            ListTile(
              title: Text(
                typeUser?? StringManager.consultantText,
                style: StyleManager.font14Regular(),
              ),
              trailing: Text(
                '${fee??20} \$',
                style: StyleManager.font14SemiBold(
                    color: ColorManager.hintTextColor),
              ),
            ),
            Divider(
              height: 1.0,
            ),
            ListTile(
                title: Text(
                  StringManager.appFeeText,
                  style: StyleManager.font14Regular(),
                ),
                trailing: Text(
                  '${5} \$',
                  style: StyleManager.font14SemiBold(
                      color: ColorManager.hintTextColor),
                )),
            Divider(
              height: 1.0,
            ),
            ListTile(
                title: Text(
                  StringManager.totalText,
                  style: StyleManager.font14Bold(),
                ),
                trailing: Text(
                  '${(fee??20)+5} \$',
                  style: StyleManager.font14Bold(),
                )),
            Divider(
              height: 1.0,
            ),
          ],
        ));
  }
}
