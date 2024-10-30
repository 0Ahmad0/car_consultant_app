import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_container_with_shadow.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/models/education_resource.dart';
import '../../core/widgets/constants_widgets.dart';
import '../../core/widgets/no_data_found_widget.dart';
import '../controllers/emergency_services_controller.dart';
import '../widgets/educational_content_widget.dart';
import '../widgets/emergency_content_widget.dart';

class EmergencyServicesScreen extends StatefulWidget {
  const EmergencyServicesScreen({super.key});

  @override
  State<EmergencyServicesScreen> createState() => _EmergencyServicesScreenState();
}

class _EmergencyServicesScreenState extends State<EmergencyServicesScreen> {
  late EmergencyServicesController controller;
  void initState() {
    controller = Get.put(EmergencyServicesController());
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.emergencyServicesText),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppPaddingWidget(
              child: Text(
                StringManager.emergencyServicesContentText,
                style: StyleManager.font16Regular(),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: controller.getEmergencyServices,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return   SliverToBoxAdapter(child:  ConstantsWidgets.circularProgress());
                } else if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasError) {
                    return  SliverToBoxAdapter(child: Text('Error'));
                  } else if (snapshot.hasData) {
                    SliverToBoxAdapter(child:  ConstantsWidgets.circularProgress());
                    controller.emergencyServices.items.clear();
                    if (snapshot.data!.docs.length > 0) {

                      controller.emergencyServices.items =
                          EducationResources.fromJson(snapshot.data?.docs).items;
                    }
                    controller.filter(term: controller.searchController.value.text);
                    return
                      GetBuilder<EmergencyServicesController>(
                          builder: (EmergencyServicesController emergencyServicesController)=>
                          (emergencyServicesController.emergenciesWithFilter.items.isEmpty ?? true)
                              ?
                          SliverToBoxAdapter(
                            child: NoDataFoundWidget(
                              // text: tr(LocaleKeys.home_no_faces_available))
                              // text: StringManager.infoNotFacesYet
                            ),
                          )
                              :

                          buildEmergencyServices(context, controller.emergenciesWithFilter.items ?? []));
                  } else {
                    return SliverToBoxAdapter(child: const Text('Empty data'));
                  }
                } else {
                  return SliverToBoxAdapter(child: Text('State: ${snapshot.connectionState}'));
                }
              }),
          // SliverList.separated(
          //   itemBuilder: (context, index) => EmergencyContentWidget(),
          //   separatorBuilder: (_, __) => verticalSpace(20.h),
          //   itemCount: 2,
          // ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppPaddingWidget(
                  child: Text(
                    StringManager.urgentServicesText,
                    style: StyleManager.font16Regular(),
                  ),
                ),
                AppPaddingWidget(
                  verticalPadding: 0,
                  child: AppContainerWithShadow(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius: BorderRadius.circular(8.r)
                        ),
                        child: Image.asset(
                          AssetsManager.supportIMG,
                        ),
                      ),
                      title: Text(StringManager.urgentSupportTeamText,style: StyleManager.font14SemiBold(),),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Text(StringManager.getHelpSupportTeamText,style: StyleManager.font12Regular(
                          color: ColorManager.hintTextColor
                        ),),
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: ColorManager.primaryColor,
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.call,color: ColorManager.whiteColor,),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget buildEmergencyServices(BuildContext context,List<EducationResourceModel> items){
    return

      SliverList.separated(
          itemBuilder: (context, index) => EmergencyContentWidget(
              emergencyServices:items[index]
          ),
          separatorBuilder: (_, __) => verticalSpace(20.h),
        itemCount: items.length,
      );

  }
}
