

import 'package:car_consultant/app/controllers/profile_controller.dart';
import 'package:car_consultant/core/models/education_resource.dart';
import 'package:car_consultant/core/models/user_model.dart';
import 'package:car_consultant/core/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/helpers/get_color_status_appointments.dart';
import '../../core/models/appointment.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';
import 'package:get/get_core/src/get_main.dart';

class UserAppointmentsController extends GetxController{

  final searchController = TextEditingController();
  Appointments appointments=Appointments(items: []);
  Appointments upAppointments=Appointments(items: []);
  Appointments currAppointments=Appointments(items: []);
  Appointments prevAppointments=Appointments(items: []);
  String? uid;
  var getAppointments;

  @override
  void onInit() {
   searchController.clear();
   ProfileController profileController=Get.put(ProfileController());
   uid= profileController.currentUser.value?.uid;
   getAppointmentsFun();
    super.onInit();
    }

  getAppointmentsFun() async {
    getAppointments =_fetchAppointmentsStream();
    return getAppointments;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  _fetchAppointmentsStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionAppointment)
        .where('idUser',isEqualTo: uid)
        .snapshots();
    return result;
  }
  filterProviders({required String term}) async {

    // providersWithFilter.items=[];
    // Appointments.items.forEach((element) {
    //
    //   if((element.name?.toLowerCase().contains(term.toLowerCase())??false))
    //     providersWithFilter.items.add(element);
    // });
     update();
  }
  classification() async {
    upAppointments.items.clear();
    currAppointments.items.clear();
    prevAppointments.items.clear();
    appointments.items.forEach((element) {
      switch(element.state){
        case ColorAppointments.Confirmed:
        case ColorAppointments.Rescheduled:
        case ColorAppointments.Pending:
        case null:
          upAppointments.items.add(element);
        case ColorAppointments.Ongoing:
        case ColorAppointments.StartingSoon:
          currAppointments.items.add(element);
        case ColorAppointments.Concluded:
        case ColorAppointments.Canceled:
          prevAppointments.items.add(element);
        default:
          upAppointments.items.add(element);
      }
      });
    update();
  }

}