

import 'package:car_consultant/core/models/education_resource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';
import 'package:get/get_core/src/get_main.dart';

class EmergencyServicesController extends GetxController{

  final searchController = TextEditingController();
  EducationResources emergencyServices=EducationResources(items: []);
  EducationResources emergenciesWithFilter=EducationResources(items: []);
  var getEmergencyServices;

  @override
  void onInit() {
   searchController.clear();
   getEmergencyServicesFun();
    super.onInit();
    }

  getEmergencyServicesFun() async {
    getEmergencyServices =_fetchEducationResourcesStream();
    return getEmergencyServices;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // deleteLesson(context,{required String? idLesson}) async{
  //   var result;
  //    Get.dialog(DialogWidget(
  //        title: 'حذف الدرس',
  //    text: 'هل أنت متأكد أنك تريد حذف الدرس؟',
  //        onPressed:() async {
  //          Get.back();
  //          ConstantsWidgets.showLoading();
  //          result=await FirebaseFun
  //              .deleteLesson(idLesson: idLesson??'',);
  //          Get.back();
  //          ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
  //
  //          update();
  //        }
  //    ));
  //
  //   return result;
  //
  // }
  _fetchEducationResourcesStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionEducationResource)
        .snapshots();
    return result;
  }
  filter({required String term}) async {

    emergenciesWithFilter.items=[];
    emergencyServices.items.forEach((element) {

      if((element.title?.toLowerCase().contains(term.toLowerCase())??false))
        emergenciesWithFilter.items.add(element);
    });
     update();
  }

}
