

import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:car_consultant/app/controllers/profile_controller.dart';
import 'package:car_consultant/core/models/location_model.dart';
import 'package:car_consultant/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


import '../../../../core/widgets/constants_widgets.dart';

import '../../core/models/appointment.dart';
import '../../core/models/file_model.dart';
import '../../core/models/review_model.dart';
import '../../core/routing/routes.dart';
import '../widgets/select_time_widget.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';


class RequestOrderController extends GetxController{


  String? uid;
  UserModel? provider;
  Appointment? appointment;

  @override
  void onInit() {
    // provider=null;
    ProfileController profileController=Get.put(ProfileController());
    uid= profileController.currentUser.value?.uid;

    super.onInit();
    }


  addAppointment(BuildContext context) async {
    ConstantsWidgets.showLoading();

    // String description=descriptionController.value.text;
    String id= '${provider?.name}00000'.substring(0,5)+'${Timestamp.now().microsecondsSinceEpoch}';
    appointment??=Appointment();
    appointment?.idUser=uid;
    appointment?.idProvider=provider?.uid;
    appointment?.id=id;
    var result=await FirebaseFun.addRequestAppointment(appointment:appointment!);

    ConstantsWidgets.closeDialog();
    if(result['status']){
      context.pushNamed(
          Routes.paymentSuccessfulRoute
      );
      // provider=userModel;
      // Get.back();
      // Get.back();
    }else
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    return result;
  }



  // updatePerson(context,{ XFile? image}) async {
  //   ConstantsWidgets.showLoading();
  //
  //   String name=nameController.value.text;
  //
  //   String? imagePath;
  //   if(image!=null){
  //     imagePath=await FirebaseFun.uploadImage(image:image,folder: FirebaseConstants.collectionPerson+'/$name');
  //   }
  //
  //   person?.name=name;
  //   person?.description= descriptionController.value.text;
  //  person?.imagePath=imagePath??person?.imagePath;
  //   person?.phoneNumber=phoneNumberController.value.text;
  //   person?.email=emailController.value.text;
  //   var
  //   result=await FirebaseFun.updatePerson(person:person!);
  //   ConstantsWidgets.closeDialog();
  //   // if(result['status'])
  //   //   Get.back();
  //   ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
  //   return result;
  // }
  //


  addReview(context,{required int rate,String? text}) async {
    ConstantsWidgets.showLoading();
    ReviewModel review=ReviewModel(
      idUser: uid,
        professionalReview:rate.toDouble(),
      timeScaleReview:rate.toDouble(),
      punctualityReview:rate.toDouble(),
        text:text
    );
    appointment?.review=review;
    var result1=await FirebaseFun.rateProvider(idProvider: appointment!.idProvider??"",review:review!);
    var result2=await FirebaseFun.updateAppointment(appointment:appointment!);
    Get.back();
    Get.back();
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result1['message'].toString()),state: result1['status']);
    return result1;
  }




  @override
  void dispose() {
    super.dispose();
  }


}
