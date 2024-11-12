


import 'package:car_consultant/app/controllers/profile_controller.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/get_color_status_appointments.dart';
import 'package:car_consultant/core/models/appointment.dart';
import 'package:car_consultant/core/models/education_resource.dart';
import 'package:car_consultant/core/models/user_model.dart';
import 'package:car_consultant/core/utils/app_constant.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/local/storage.dart';
import '../../../core/widgets/constants_widgets.dart';
import '../firebase/firebase_constants.dart';
import '../firebase/firebase_fun.dart';

class StaticsController extends GetxController{

  final searchController = TextEditingController();
  Users accounts=Users(items: []);
  Users accountsWithFilter=Users(items: []);
  Users users=Users(items: []);
  Users consultProviders=Users(items: []);
  Users serviceProviders=Users(items: []);
  Users requestsProviders=Users(items: []);
  Users requestsProvidersWithFilter=Users(items: []);
  Users requestsConsults=Users(items: []);
  Users requestsServices=Users(items: []);
  Appointments appointments=Appointments(items: []);
  Appointments appointmentsWithFilter=Appointments(items: []);
  Appointments requestAppointments=Appointments(items: []);
  var getUsers;
  var getRequestsProviders;
  var getAppointments;

  @override
  void onInit() {
   searchController.clear();
   getUsersFun();
   getRequestsProvidersFun();
   getAppointmentsFun();
    super.onInit();
    }

  getUsersFun() async {
    getUsers =_fetchUsersStream();
    return getUsers;
  }
  getRequestsProvidersFun() async {
    getRequestsProviders =_fetchRequestsProvidersStream();
    return getRequestsProviders;
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


  _fetchUsersStream() {
    final result = FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionUser)
        .snapshots();

    return result;
  }
  _fetchRequestsProvidersStream() {
    final result = FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionRequestProvider)
        .snapshots();

    return result;
  }
  _fetchAppointmentsStream() {
    final result = FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionAppointment)
        .snapshots();

    return result;
  }

  filterAccounts({required String term}) async {
    accountsWithFilter.items=[];
    users.items=[];
    consultProviders.items=[];
    serviceProviders.items=[];
    accounts.items.forEach((element) {

      if((element.name?.toLowerCase().contains(term.toLowerCase())??false)||
          (element.email?.toLowerCase().contains(term.toLowerCase())??false)
      ){
        accountsWithFilter.items.add(element);
        if(element.typeUser==AppConstants.collectionUser){
          users.items.add(element);
        }else if ([AppConstants.collectionConsultantProvider].contains(element.typeUser)){
          consultProviders.items.add(element);
        }
        else if ([AppConstants.collectionServiceProvider].contains(element.typeUser)){
          serviceProviders.items.add(element);
        }
      }

    });
     update();
  }
  filterRequestsProviders({required String term}) async {
    requestsProvidersWithFilter.items=[];
    requestsConsults.items=[];
    requestsServices.items=[];
    requestsProviders.items.forEach((element) {
      if(element.additionalInfo?.status?.isEmpty??true)
      if((element.name?.toLowerCase().contains(term.toLowerCase())??false)||
          (element.email?.toLowerCase().contains(term.toLowerCase())??false)||
          (element.additionalInfo?.workShopName?.toLowerCase().contains(term.toLowerCase())??false)||
          (element.typeUser?.toLowerCase().contains(term.toLowerCase())??false)
      ){
        requestsProvidersWithFilter.items.add(element);
        if ([AppConstants.collectionConsultantProvider].contains(element.typeUser)){
          requestsConsults.items.add(element);
        }
        else if ([AppConstants.collectionServiceProvider].contains(element.typeUser)){
          requestsServices.items.add(element);
        }
      }

    });
    update();
  }
  filterAppointments({required String term}) async {
    appointmentsWithFilter.items=[];
    requestAppointments.items=[];

    appointments.items.forEach((element) {

      if((element.idUser?.toLowerCase().contains(term.toLowerCase())??false)||
          (element.idProvider?.toLowerCase().contains(term.toLowerCase())??false)||
          ((element.state??"Pending").toLowerCase().contains(term.toLowerCase())??false)
      ){

        appointmentsWithFilter.items.add(element);
        if(element.state==null||element.state==ColorAppointments.Pending)
          requestAppointments.items.add(element);
      }


    });
    update();
  }
  getTotal(int? index){
    switch(index){
      case 0:
        return users.items.length;
      case 1:
        return consultProviders.items.length;
      case 2:
        return serviceProviders.items.length;
      case 3:
        return appointmentsWithFilter.items.length;
      default:
        return accountsWithFilter.items.length;
    }

  }
  List getList(int index){
    switch(index){
      case 0:
        return [];
        // return users.items;
      case 1:
        return requestsConsults.items;
      case 2:
        return requestsProviders.items;
      case 3:
        return requestAppointments.items;
      default:
        return requestAppointments.items;
    }

  }
}
