import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/models/appointment.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/widgets/constants_widgets.dart';
import '../../../core/widgets/no_data_found_widget.dart';
import '../../controllers/manage_request_appointments_controller.dart';
import 'widgets/service_provider_request_managment_widget.dart';

class ServiceProviderManageRequestScreen extends StatefulWidget {
  const ServiceProviderManageRequestScreen({super.key});

  @override
  State<ServiceProviderManageRequestScreen> createState() => _ServiceProviderManageRequestScreenState();
}

class _ServiceProviderManageRequestScreenState extends State<ServiceProviderManageRequestScreen> {
  late ManageRequestAppointmentsController controller;
  void initState() {
    controller = Get.put(ManageRequestAppointmentsController());
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.manageRequestTitleText),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppPaddingWidget(
              child: Text(StringManager.appointmentRequestsText),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: controller.getAppointments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return   SliverToBoxAdapter(child:  ConstantsWidgets.circularProgress());
                } else if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasError) {
                    return  SliverToBoxAdapter(child: Text('Error'));
                  } else if (snapshot.hasData) {
                    SliverToBoxAdapter(child:  ConstantsWidgets.circularProgress());
                    controller.appointments.items.clear();
                    if (snapshot.data!.docs.length > 0) {

                      controller.appointments.items =
                          Appointments.fromJson(snapshot.data?.docs).items;
                    }
                    controller.filter(term: "");
                   return
                      GetBuilder<ManageRequestAppointmentsController>(
                          builder: (ManageRequestAppointmentsController manageRequestAppointmentsController)=>
                          (manageRequestAppointmentsController.appointments.items.isEmpty ?? true)
                              ?
                          SliverToBoxAdapter(
                            child: Center(
                              child: NoDataFoundWidget(
                                // text: tr(LocaleKeys.home_no_faces_available))
                                // text: StringManager.infoNotFacesYet
                              ),
                            ),
                          )
                              :

                          buildAppointments(context, controller.appointments.items ?? []));
                  } else {
                    return SliverToBoxAdapter(child: const Text('Empty data'));
                  }
                } else {
                  return SliverToBoxAdapter(child: Text('State: ${snapshot.connectionState}'));
                }
              }),

          // SliverList.separated(
          //     itemBuilder: (context,index)=>ServiceProviderRequestManagementWidget(),
          //     separatorBuilder: (_,__)=> verticalSpace(20.h)
          // )
        ],
      ),
    );

  }
  Widget buildAppointments(BuildContext context,List<Appointment> items){
    return

      SliverList.separated(
        itemBuilder: (context, index) =>
            ServiceProviderRequestManagementWidget(
                appointment:items[index]
            ),
        //     EmergencyContentWidget(
        //     emergencyServices:items[index]
        // ),
        separatorBuilder: (_, __) => verticalSpace(20.h),
        itemCount: items.length,
      );

  }
}
