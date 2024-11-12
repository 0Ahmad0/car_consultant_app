import 'package:car_consultant/app/screens/admin/widgets/users_and_consultant_search_bar_widget.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/models/user_model.dart';
import '../../../core/widgets/app_search_text_filed.dart';
import '../../../core/widgets/constants_widgets.dart';
import '../../../core/widgets/no_data_found_widget.dart';
import '../../controllers/admin/manage_requests_provider_controller.dart';
import 'widgets/admin_request_widget.dart';

class AdminRequestsScreen extends StatefulWidget {
  const AdminRequestsScreen({super.key});

  @override
  State<AdminRequestsScreen> createState() => _AdminRequestsScreenState();
}

class _AdminRequestsScreenState extends State<AdminRequestsScreen> {
  late ManageRequestsProviderController controller;
  void initState() {
    controller = Get.put(ManageRequestsProviderController());
    controller.onInit();
    super.initState();
  }
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
                  onChanged: (value) {
                    controller.filter(term: value??'');
                  },
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
          StreamBuilder<QuerySnapshot>(
              stream: controller.getRequestsProvider,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return   SliverToBoxAdapter(child:  ConstantsWidgets.circularProgress());
                } else if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasError) {
                    return  SliverToBoxAdapter(child: Text('Error'));
                  } else if (snapshot.hasData) {
                    SliverToBoxAdapter(child:  ConstantsWidgets.circularProgress());
                    controller.requestsProvider.items.clear();
                    if (snapshot.data!.docs.length > 0) {

                      controller.requestsProvider.items =
                          Users.fromJson(snapshot.data?.docs).items;
                    }
                    controller.filter(term: controller.searchController.value.text);
                    return
                      GetBuilder<ManageRequestsProviderController>(
                          builder: (ManageRequestsProviderController manageRequestsProviderController)=>

                          (manageRequestsProviderController.requestsWithFilter.items.isEmpty ?? true)
                              ?
                          SliverFillRemaining(
                            child: NoDataFoundWidget(
                              image: AssetsManager.providerIMG,
                              text: "No Requests Yet",
                              // text: tr(LocaleKeys.home_no_faces_available))
                              // text: StringManager.infoNotFacesYet
                            ),
                          )
                              :

                          buildRequests(context, controller.requestsWithFilter.items ?? []));
                  } else {
                    return SliverToBoxAdapter(child: const Text('Empty data'));
                  }
                } else {
                  return SliverToBoxAdapter(child: Text('State: ${snapshot.connectionState}'));
                }
              }),
          // SliverList.separated(
          //     itemCount: 6,
          //     itemBuilder: (context, index) => AdminRequestWidget(
          //           title: 'User ${index + 1}',
          //           subTitle: 'Requested To Be a Service Provider${index + 1}',
          //         ),
          //     separatorBuilder: (_, __) => verticalSpace(10.h))
        ],
      ),
    );
  }

  Widget buildRequests(BuildContext context,List<UserModel> items){
    return

      SliverList.separated(
        itemBuilder: (context, index) => AdminRequestWidget(
          title:items[index].name?? 'User ${index + 1}',
          subTitle: 'Requested To Be a ${items[index].typeUser??"Service Provider${index + 1}"}',
          user: items[index],
        ),
          separatorBuilder: (_, __) => verticalSpace(10.h),
        itemCount: items.length,
      );

  }
}
