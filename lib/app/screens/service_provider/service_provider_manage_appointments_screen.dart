import 'package:car_consultant/app/controllers/profile_controller.dart';
import 'package:car_consultant/app/screens/navbar/widgets/current_item_widget.dart';
import 'package:car_consultant/app/screens/navbar/widgets/list_view_previous_status_appointments_widget.dart';
import 'package:car_consultant/app/screens/navbar/widgets/previous_item_widget.dart';
import 'package:car_consultant/app/screens/navbar/widgets/upcoming_item_widget.dart';
import 'package:car_consultant/core/helpers/get_color_status_appointments.dart';
import 'package:car_consultant/core/models/appointment.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../core/widgets/constants_widgets.dart';
import '../../../core/widgets/no_appointments_widget.dart';
import '../../controllers/provider_appointments_controller.dart';
import '../../controllers/user_appointments_controller.dart';
import '../navbar/widgets/list_view_current_status_appointments_widget.dart';
import '../navbar/widgets/list_view_upcoming_status_appointments_widget.dart';


class ServiceProviderManageAppointmentsScreen extends StatefulWidget {
  const ServiceProviderManageAppointmentsScreen({super.key});

  @override
  State<ServiceProviderManageAppointmentsScreen> createState() => _ServiceProviderManageAppointmentsScreenState();
}

class _ServiceProviderManageAppointmentsScreenState extends State<ServiceProviderManageAppointmentsScreen> {
  late ProviderAppointmentsController controller;
  void initState() {
    controller = Get.put(ProviderAppointmentsController());
    controller.idProvider=Get.put(ProfileController()).currentUser.value?.uid;
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ConstValueManager.lengthAppointmentsTabBar,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.whiteColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorManager.whiteColor),
          ),
          elevation: 0.0,
          title: Text(StringManager.appointmentsText),
          bottom: TabBar(
            indicatorPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            splashBorderRadius: BorderRadius.circular(8.r),
            tabs: ConstValueManager.tabs
                .map(
                  (e) => Tab(
                    text: e,
                  ),
                )
                .toList(),
          ),
        ),
        body:
        StreamBuilder<QuerySnapshot>(
            stream: controller.getAppointments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return    ConstantsWidgets.circularProgress();
              } else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return  Text('Error');
                } else if (snapshot.hasData) {
                  ConstantsWidgets.circularProgress();
                  controller.appointments.items.clear();
                  if (snapshot.data!.docs.length > 0) {

                    controller.appointments.items =
                        Appointments.fromJson(snapshot.data?.docs).items;
                  }
                  controller.classification();
                  return
                    GetBuilder<ProviderAppointmentsController>(
                        builder: (ProviderAppointmentsController providerAppointmentsController)=>

                            buildAppointments(context, providerAppointmentsController));
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            })
        // TabBarView(
        //   children: [
        //     ListViewUpcomingStatusAppointmentsWidget(
        //       list: [
        //         ColorAppointments.Confirmed,
        //         ColorAppointments.Rescheduled,
        //         ColorAppointments.Pending,
        //       ],
        //       emptyListText: ConstValueManager.tabs[0],
        //     ),
        //     ListViewCurrentStatusAppointmentsWidget(
        //       list: [
        //         ColorAppointments.Ongoing,
        //         ColorAppointments.StartingSoon,
        //         ColorAppointments.StartingSoon,
        //       ],
        //       emptyListText: ConstValueManager.tabs[1],
        //     ),
        //     ListViewPreviousStatusAppointmentsWidget(
        //       list: [
        //         ColorAppointments.Concluded,
        //         ColorAppointments.Concluded,
        //         ColorAppointments.Canceled,
        //
        //       ],
        //       emptyListText: ConstValueManager.tabs[2],
        //     ),
        //   ],
        // )
        ,
      ),
    );
  }
  Widget buildAppointments(BuildContext context,ProviderAppointmentsController providerAppointmentsController){
    return
      TabBarView(
        children: [
          ListViewUpcomingStatusAppointmentsWidget(
            isProvider: true,
            list: [
              ColorAppointments.Confirmed,
              ColorAppointments.Rescheduled,
              ColorAppointments.Pending,
            ],
            emptyListText: ConstValueManager.tabs[0],
            items: providerAppointmentsController.upAppointments.items,
          ),
          ListViewCurrentStatusAppointmentsWidget(
            isProvider: true,
            list: [
              ColorAppointments.Ongoing,
              ColorAppointments.StartingSoon,
              ColorAppointments.StartingSoon,
            ],
            items: providerAppointmentsController.currAppointments.items,
            emptyListText: ConstValueManager.tabs[1],
          ),
          ListViewPreviousStatusAppointmentsWidget(
            isProvider: true,
            list: [
              ColorAppointments.Concluded,
              ColorAppointments.Concluded,
              ColorAppointments.Canceled,
            ],
            items: providerAppointmentsController.prevAppointments.items,
            emptyListText: ConstValueManager.tabs[2],
          ),
        ],
      );
  }

}
