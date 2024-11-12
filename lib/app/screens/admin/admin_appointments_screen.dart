import 'package:car_consultant/core/enums/enums.dart';
import 'package:car_consultant/core/models/appointment.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../core/helpers/get_color_status_appointments.dart';
import '../../../core/models/user_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/style_manager.dart';
import '../../../core/widgets/constants_widgets.dart';
import '../../../core/widgets/no_appointments_widget.dart';
import '../../controllers/admin/admin_appointments_controller.dart';
import '../../controllers/process_controller.dart';
import 'widgets/admin_appointments_widget.dart';
import 'widgets/users_and_consultant_search_bar_widget.dart';

class AdminAppointmentsScreen extends StatefulWidget {
  const AdminAppointmentsScreen({super.key});

  @override
  State<AdminAppointmentsScreen> createState() => _AdminAppointmentsScreenState();
}

class _AdminAppointmentsScreenState extends State<AdminAppointmentsScreen> {
  late AdminAppointmentsController controller;
  void initState() {
    controller = Get.put(AdminAppointmentsController());
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.appointmentsText),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AdminAppointmentsSearchBarWithDate(
              onChanged: (value){
                controller.filter(term: value??'');
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: controller.getAppointments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return   SliverFillRemaining(child:  ConstantsWidgets.circularProgress());
                } else if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasError) {
                    return  SliverFillRemaining(child: Text('Error'));
                  } else if (snapshot.hasData) {
                    SliverFillRemaining(child:  ConstantsWidgets.circularProgress());
                    controller.appointments.items.clear();
                    if (snapshot.data!.docs.length > 0) {

                      controller.appointments.items =
                          Appointments.fromJson(snapshot.data?.docs).items;
                    }
                    controller.filter(term: controller.searchController.value.text);
                    return
                      GetBuilder<AdminAppointmentsController>(
                          builder: (AdminAppointmentsController adminAppointmentsController)=>

                          (adminAppointmentsController.appointmentsWithFilter.items.isEmpty ?? true)
                              ?
                          SliverFillRemaining(child: NoAppointmentsWidget(text: ""))
                              :

                          buildAppointments(context, controller.appointmentsWithFilter.items ?? []));
                  } else {
                    return SliverToBoxAdapter(child: const Text('Empty data'));
                  }
                } else {
                  return SliverToBoxAdapter(child: Text('State: ${snapshot.connectionState}'));
                }
              }),
          // SliverList.separated(
          //   itemBuilder: (context, index) => AppointmentsAdminWidget(
          //     title: 'User ${index+1}',
          //     subTitle: 'Type ${index/100}',
          //     date: DateFormat.d().add_yMMM().format(DateTime.now()),
          //     status: ConstValueManager.adminAppointmentsList[index],
          //   ),
          //   separatorBuilder: (_, __) => Divider(
          //     thickness: .5.sp,
          //     height: 0,
          //   ),
          //   itemCount: ConstValueManager.adminAppointmentsList.length,
          // )
        ],
      ),
    );
  }

  Widget buildAppointments(BuildContext context,List<Appointment> items){
    return

      SliverList.separated(
        itemBuilder: (context, index) =>
            GetBuilder<ProcessController>(
              init: Get.put(ProcessController()),
                builder: (ProcessController processController) {
                  processController.fetchUserAsync(context, idUser: items[index].idUser??"");
                  UserModel? user = processController.fetchLocalUser(idUser: items[index].idUser??"");
                  return
            AppointmentsAdminWidget(
          title:user?.name??"loading ..."?? 'User ${index+1}',
          subTitle:user?.typeUser?? 'Type ${index/100}',
          date: DateFormat.d().add_yMMM().format(items[index].selectDate??DateTime.now()),
          status:
          ColorAppointments.values.where((_element)=>
          items[index].state?.toLowerCase().contains(_element.name.toLowerCase())??false)
          .firstOrNull?? ColorAppointments.Pending,
              // ?? ConstValueManager.adminAppointmentsList[index],
              appointment: items[index],
        );}),
        separatorBuilder: (_, __) => Divider(
          thickness: .5.sp,
          height: 0,
        ),
        itemCount: items.length,
      );

  }
  fetchLocalUser(BuildContext context,String idUser){
    return Get.put(ProcessController()).fetchUser(context, idUser: idUser);
  }
}
