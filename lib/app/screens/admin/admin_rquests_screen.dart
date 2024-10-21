import 'package:car_consultant/app/screens/admin/widgets/users_and_consultant_search_bar_widget.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/app_search_text_filed.dart';
import 'widgets/admin_request_widget.dart';

class AdminRequestsScreen extends StatelessWidget {
  const AdminRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringManager.requestsText,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: AppPaddingWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSearchTextFiled(
                  onPressed: () {},
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                ),
                verticalSpace(20.h),
                Text(
                  StringManager.requestsText,
                  style: StyleManager.font16SemiBold(),
                ),
                verticalSpace(10.h),
              ],
            ),
          )),
          SliverList.separated(
              itemCount: 6,
              itemBuilder: (context, index) => AdminRequestWidget(
                    title: 'User ${index + 1}',
                    subTitle: 'Requested To Be a Service Provider${index + 1}',
                  ),
              separatorBuilder: (_, __) => verticalSpace(10.h))
        ],
      ),
    );
  }
}
