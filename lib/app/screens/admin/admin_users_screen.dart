import 'package:car_consultant/app/controllers/admin/manage_users_controller.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/app_constant.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_search_text_filed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/enums/enums.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/constants_widgets.dart';
import 'widgets/users_and_consultant_search_bar_widget.dart';
import 'widgets/users_and_consultants_and_providers_widget.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  late ManageUsersController controller;
  void initState() {
    controller = Get.put(ManageUsersController());
    controller.onInit();
    super.initState();
  }
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
        body:  StreamBuilder<QuerySnapshot>(
            stream: controller.getUsers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return    ConstantsWidgets.circularProgress();
              } else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return  Text('Error');
                } else if (snapshot.hasData) {
                  ConstantsWidgets.circularProgress();
                  controller.accounts.items.clear();
                  if (snapshot.data!.docs.length > 0) {

                    controller.accounts.items =
                        Users.fromJson(snapshot.data?.docs).items;
                  }
                  controller.filter(term: "");
                  return
                    GetBuilder<ManageUsersController>(
                        builder: (ManageUsersController manageUsersController)=>

                            buildUsers(context));
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }) ,
      ),
    );
  }
  Widget buildUsers(BuildContext context){
    return
      TabBarView(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AdminAppointmentsSearchBarWithDate(
                  onChanged: (term){
                    controller.filter(term: term??'');
                  },
                ),
              ),
              SliverList.separated(
                separatorBuilder: (_, __) => const Divider(
                  height: 0,
                  thickness: .5,
                ),
                itemBuilder: (context, index) =>
                    UsersAndConsultantsAndProvidersWidget(
                      onTap: () {
                        context.pushNamed(Routes.adminUserInfoRoute, arguments: {"user":controller.users.items[index]});
                      },
                      title:controller.users.items[index].name?? 'User ${index + 1}',
                      subTitle: controller.users.items[index].email??'user${index + 1}@gmail.com',
                      status:
                      index.isEven||true
                          ? AdminUsersAndConsultantsStatus.Active
                          : AdminUsersAndConsultantsStatus.Blocked,
                    ),
                itemCount: controller.users.items.length,
              )
            ],
          ),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AdminAppointmentsSearchBarWithDate(
                  onChanged: (term){
                    controller.filter(term: term??'');
                  },
                ),
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
                            .pushNamed(
                            controller.providers.items[index].typeUser==AppConstants.collectionConsultantProvider
                            // index.isEven
                            ? Routes.adminConsultantInfoRoute
                            :Routes.adminProviderInfoRoute
                            ,arguments: {"provider":controller.providers.items[index]});
                      },
                      title:  controller.providers.items[index].name??'Consultant${index + 1}',
                      subTitle: controller.providers.items[index].email?? 'consultant${index + 1}@gmail.com',
                      status:
                      index.isEven||true
                          ? AdminUsersAndConsultantsStatus.Active
                          : AdminUsersAndConsultantsStatus.Blocked,
                    ),
                itemCount:  controller.providers.items.length,
              )
            ],
          ),
        ],
      );
  }

}

