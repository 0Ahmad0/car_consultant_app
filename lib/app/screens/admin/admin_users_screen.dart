import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_search_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/enums.dart';
import 'widgets/users_and_consultant_search_bar_widget.dart';
import 'widgets/users_and_consultants_and_providers_widget.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringManager.usersText),
          bottom: TabBar(
            unselectedLabelStyle: StyleManager.font14Regular(),
            labelStyle: StyleManager.font14Regular(),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            tabs: [
              Tab(
                text: StringManager.usersText,
              ),
              Tab(
                text: StringManager.consultantsAndProvidersText,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AdminAppointmentsSearchBarWithDate(),
                ),
                SliverList.separated(
                  separatorBuilder: (_, __) => const Divider(
                    height: 0,
                    thickness: .5,
                  ),
                  itemBuilder: (context, index) =>
                      UsersAndConsultantsAndProvidersWidget(
                    onTap: () {
                      context.pushNamed(Routes.userInfoRoute, arguments: {});
                    },
                    title: 'User ${index + 1}',
                    subTitle: 'user${index + 1}@gmail.com',
                    status: index.isEven
                        ? AdminUsersAndConsultantsStatus.Active
                        : AdminUsersAndConsultantsStatus.Blocked,
                  ),
                  itemCount: 20,
                )
              ],
            ),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AdminAppointmentsSearchBarWithDate(),
                ),
                SliverList.separated(
                  separatorBuilder: (_, __) => const Divider(
                    height: 0,
                    thickness: .5,
                  ),
                  itemBuilder: (context, index) =>
                      UsersAndConsultantsAndProvidersWidget(
                    onTap: () {
                      context
                          .pushNamed(Routes.consultantInfoRoute, arguments: {});
                    },
                    title: 'Consultant${index + 1}',
                    subTitle: 'consultant${index + 1}@gmail.com',
                    status: index.isEven
                        ? AdminUsersAndConsultantsStatus.Active
                        : AdminUsersAndConsultantsStatus.Blocked,
                  ),
                  itemCount: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

