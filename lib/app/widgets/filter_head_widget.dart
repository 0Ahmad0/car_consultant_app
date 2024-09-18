import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/string_manager.dart';
import '../../core/utils/style_manager.dart';

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
                ),
                DropdownMenuItem(
                  child: Text('Best Rate'),
                  value: 'Best Rate',
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
