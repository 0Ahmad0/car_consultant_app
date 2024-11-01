import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/string_manager.dart';
import '../../core/utils/style_manager.dart';
import '../controllers/providers_controller.dart';
import '../controllers/service_providers_controller.dart';

class FilterHeadWidget extends StatelessWidget {
  const FilterHeadWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            StringManager.sortByText,
            style: StyleManager.font14Bold(),
          ),
        ),
        horizontalSpace(10.w),
        Flexible(
            child: DropdownButtonFormField(
              icon: Icon(Icons.keyboard_arrow_down),
              style: StyleManager.font14Regular(),
              isDense: true,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                  hintText: StringManager.sortByText,
                  border: InputBorder.none
              ),
              items: [
                DropdownMenuItem(
                  child: Text('Best Selling'),
                  value: 'Best Selling',
                  onTap: (){
                    Get.put(ProvidersController()).sortByBestFee();
                  },
                ),
                DropdownMenuItem(
                  child: Text('Best Rate'),
                  value: 'Best Rate',
                  onTap: (){
                    Get.put(ProvidersController()).sortByBestRate();

                  },
                ),
              ],
              onChanged: (value) {
                log('${value}');
              },
            ))
      ],
    );
  }
}
