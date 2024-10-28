import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/no_data_found_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/models/education_resource.dart';
import '../../core/widgets/constants_widgets.dart';
import '../controllers/education_resources_controller.dart';
import '../widgets/educational_content_widget.dart';

class EducationalResourcesScreen extends StatefulWidget {
  const EducationalResourcesScreen({super.key});

  @override
  State<EducationalResourcesScreen> createState() => _EducationalResourcesScreenState();
}

class _EducationalResourcesScreenState extends State<EducationalResourcesScreen> {
  late EducationResourcesController controller;
  void initState() {
    controller = Get.put(EducationResourcesController());
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.educationalResourcesText),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppPaddingWidget(
            child: Text(
              StringManager.educationalContentText,
              style: StyleManager.font16Regular(),
            ),
          ),
          Expanded(
            child:
          StreamBuilder<QuerySnapshot>(
          stream: controller.getEducationResources,
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          return    ConstantsWidgets.circularProgress();
          } else if (snapshot.connectionState ==
          ConnectionState.active) {
          if (snapshot.hasError) {
          return  Text('Error');
          } else if (snapshot.hasData) {
          ConstantsWidgets.circularProgress();
          controller.educationResources.items.clear();
          if (snapshot.data!.docs.length > 0) {
          controller.educationResources.items =
              EducationResources.fromJson(snapshot.data?.docs).items;
          }
          controller.filterPersons(term: controller.searchController.value.text);
          return
          GetBuilder<EducationResourcesController>(
          builder: (EducationResourcesController educationResourcesController)=>
          (educationResourcesController.educationsWithFilter.items.isEmpty ?? true)
          ?
          NoDataFoundWidget(
              // text: tr(LocaleKeys.home_no_faces_available))
          // text: StringManager.infoNotFacesYet
          )
              :

          buildEducationResources(context, controller.educationsWithFilter.items ?? []));
          } else {
          return const Text('Empty data');
          }
          } else {
          return Text('State: ${snapshot.connectionState}');
          }
          })


            // ListView.separated(
            //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            //   itemBuilder: (context, index) => EducationalContentWidget(),
            //   separatorBuilder: (_, __) => verticalSpace(20.h),
            //   itemCount: 10,
            // ),
          )
        ],
      ),
    );
  }
  Widget buildEducationResources(BuildContext context,List<EducationResourceModel> items){
    return
    ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      itemBuilder: (context, index) => EducationalContentWidget(
        educationResourceModel: items[index],
      ),
      separatorBuilder: (_, __) => verticalSpace(20.h),
      itemCount: items.length,
    );

  }

}
