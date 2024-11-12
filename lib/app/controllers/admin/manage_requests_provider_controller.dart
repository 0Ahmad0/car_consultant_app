


import 'package:car_consultant/app/controllers/profile_controller.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/models/education_resource.dart';
import 'package:car_consultant/core/models/user_model.dart';
import 'package:car_consultant/core/utils/app_constant.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/enums/enums.dart';
import '../../../core/helpers/get_color_status_appointments.dart';
import '../../../core/models/notification_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/widgets/constants_widgets.dart';
import '../firebase/firebase_constants.dart';
import '../firebase/firebase_fun.dart';
import '../notifications_controller.dart';

class ManageRequestsProviderController extends GetxController{

  final searchController = TextEditingController();
  Users requestsProvider=Users(items: []);
  Users requestsWithFilter=Users(items: []);
  var getRequestsProvider;

  @override
  void onInit() {
   searchController.clear();
   getRequestsProviderFun();
    super.onInit();
    }

  getRequestsProviderFun() async {
    getRequestsProvider =_fetchRequestsProviderStream();
    return getRequestsProvider;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  _fetchRequestsProviderStream() {
    final result = FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionRequestProvider)
        .snapshots();

    return result;
  }
  filter({required String term}) async {
    requestsWithFilter.items=[];
    requestsProvider.items.forEach((element) {
      if(element.additionalInfo?.status?.isEmpty??true)
      if((element.name?.toLowerCase().contains(term.toLowerCase())??false)||
          (element.email?.toLowerCase().contains(term.toLowerCase())??false)||
          (element.additionalInfo?.workShopName?.toLowerCase().contains(term.toLowerCase())??false)||
          (element.typeUser?.toLowerCase().contains(term.toLowerCase())??false)
      ){
        requestsWithFilter.items.add(element);
      }
    });
     update();
  }


  acceptOrRejectedRequest(BuildContext context ,AccountRequestStatus? state,UserModel? provider) async {
    var result;
    provider?.additionalInfo?.status=state?.name;

    ConstantsWidgets.showLoading();

   try {

      result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionUser)
      .doc(provider?.uid??'').update(
          AccountRequestStatus.Accepted==state?
          {
        "additionalInfo": provider?.additionalInfo?.toJson()??{},
        "typeUser":provider?.typeUser
      }:{"typeUser":provider?.typeUser}).then((value) async {
        result=await FirebaseFun.updateRequestProvider(provider:provider!);

        if(result['status']){

          state==AccountRequestStatus.Accepted?
          Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: provider?.uid, subtitle: StringManager.notificationSubTitleAcceptRequestProvider+' '+(provider.typeUser??''), dateTime: DateTime.now(), title: StringManager.notificationTitleAcceptRequestProvider, message: ''))
              :Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: provider?.uid, subtitle: StringManager.notificationSubTitleCanceledRequestProvider+' '+(provider.typeUser??''), dateTime: DateTime.now(), title: StringManager.notificationTitleRejectedRequestProvider, message: ''));
          ConstantsWidgets.closeDialog();
          ConstantsWidgets.closeDialog();
        } else{
          ConstantsWidgets.closeDialog();
          ConstantsWidgets.TOAST(null,
              textToast: StringManager.errorTryAgainLater
              // textToast:  tr(LocaleKeys.message_error_try_again_later)
              , state: false);
        }
      });
      }catch (e) {
     ConstantsWidgets.closeDialog();
     String errorMessage;
     // errorMessage = "An unexpected error occurred. Please try again later.";
     errorMessage = "An unexpected error occurred. Please try again later.";
     Get.snackbar(
         StringManager.message_failure,
         errorMessage,
         backgroundColor: ColorManager.errorColor
     );
   }
  }


}
