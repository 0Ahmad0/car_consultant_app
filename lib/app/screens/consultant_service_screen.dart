import 'dart:developer';

import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/models/user_model.dart';
import '../../core/utils/app_constant.dart';
import '../../core/widgets/constants_widgets.dart';
import '../../core/widgets/no_data_found_widget.dart';
import '../controllers/providers_controller.dart';
import '../widgets/consultant_service_widget.dart';
import '../widgets/filter_head_widget.dart';

class ConsultantServiceScreen extends StatefulWidget {
  const ConsultantServiceScreen({super.key});

  @override
  State<ConsultantServiceScreen> createState() => _ConsultantServiceScreenState();
}

class _ConsultantServiceScreenState extends State<ConsultantServiceScreen> {
  late ProvidersController controller;

  void initState() {
    controller = Get.put(ProvidersController());
    controller.typeProvider=AppConstants.collectionConsultantProvider;
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.consultantServiceText),
      ),
      body: AppPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterHeadWidget(),
            verticalSpace(20.h),
            Expanded(
                child:
                StreamBuilder<QuerySnapshot>(
                    stream: controller.getProviders,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return    ConstantsWidgets.circularProgress();
                      } else if (snapshot.connectionState ==
                          ConnectionState.active) {
                        if (snapshot.hasError) {
                          return  Text('Error');
                        } else if (snapshot.hasData) {
                          ConstantsWidgets.circularProgress();
                          controller.providers.items.clear();
                          if (snapshot.data!.docs.length > 0) {

                            controller.providers.items =
                                Users.fromJson(snapshot.data?.docs).items;
                          }
                          controller.filterProviders(term: controller.searchController.value.text);
                          return
                            GetBuilder<ProvidersController>(
                                builder: (ProvidersController providersController)=>
                                (providersController.providersWithFilter.items.isEmpty ?? true)
                                    ?
                                NoDataFoundWidget(
                                  // text: tr(LocaleKeys.home_no_faces_available))
                                  // text: StringManager.infoNotFacesYet
                                )
                                    :

                                buildConsultantService(context, controller.providersWithFilter.items ?? []));
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    })

            //     ListView.separated(
            //   separatorBuilder: (_, __) => Divider(
            //     thickness: .75,
            //     height: 30.h,
            //   ),
            //   itemCount: 20,
            //   itemBuilder: (context, index) {
            //     return ConsultantServiceWidget(index: index,);
            //   },
            // )
            )
          ],
        ),
      ),
    );
  }
  Widget buildConsultantService(BuildContext context,List<UserModel> items){
    return
      ListView.separated(
        separatorBuilder: (_, __) => Divider(
          thickness: .75,
          height: 30.h,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ConsultantServiceWidget(index: index,
            consultantService: items[index],
          );
        },
      );

  }

}


