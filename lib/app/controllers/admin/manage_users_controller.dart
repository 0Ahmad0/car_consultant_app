


import 'package:car_consultant/app/controllers/profile_controller.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
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

class ManageUsersController extends GetxController{

  final searchController = TextEditingController();
  Users accounts=Users(items: []);
  Users users=Users(items: []);
  Users providers=Users(items: []);
  var getUsers;

  @override
  void onInit() {
   searchController.clear();
   getUsersFun();
    super.onInit();
    }

  getUsersFun() async {
    getUsers =_fetchUsersStream();
    return getUsers;
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
  filter({required String term}) async {
    users.items=[];
    providers.items=[];
    accounts.items.forEach((element) {

      if((element.name?.toLowerCase().contains(term.toLowerCase())??false)||
          (element.email?.toLowerCase().contains(term.toLowerCase())??false)
      ){
        if(element.typeUser==AppConstants.collectionUser){
          users.items.add(element);
        }else if ([AppConstants.collectionConsultantProvider,AppConstants.collectionServiceProvider].contains(element.typeUser)){
          providers.items.add(element);
        }
      }

    });
     update();
  }


  Future<void> deleteAccount(BuildContext context,UserModel? user) async {
    if(user==null){
      ConstantsWidgets.closeDialog();
      return;
    }
    try {
      ConstantsWidgets.showLoading();
      // await FirebaseAuth.instance
      //     .currentUser?.delete()
      //     .timeout(FirebaseFun.timeOut);
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.collectionUser)
          .doc(await AppStorage.storageRead(key: AppConstants.uidKEY))
          .delete();
      ConstantsWidgets.closeDialog();
      ConstantsWidgets.closeDialog();
      ConstantsWidgets.closeDialog();
      ConstantsWidgets.TOAST(null, textToast: "Successful Deleted", state: false);


    } on FirebaseAuthException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      ConstantsWidgets.closeDialog();
      ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);

    }
  }
  
  // acceptOrRejectedRequest(BuildContext context ,ColorAppointments? state,Appointment? appointment) async {
  //   var result;
  //   appointment?.state=state?.name;
  //   ConstantsWidgets.showLoading();
  //   {
  //     result=await FirebaseFun.updateAppointment(appointment:appointment!);
  //
  //
  //       //TODO dd notification
  //       // if(result['status'])
  //       //   context.read<NotificationProvider>().addNotification(context, notification: models.Notification(idUser: users[index].uid, subtitle: AppConstants.notificationSubTitleNewChat+' '+(profileProvider?.user?.firstName??''), dateTime: DateTime.now(), title: AppConstants.notificationTitleNewChat, message: ''));
  //
  //       if(result['status']){
  //         state==ColorAppointments.Confirmed?
  //         Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: appointment?.idUser, subtitle: StringManager.notificationSubTitleAcceptAppointment+' '+(Get.put(ProfileController())?.currentUser.value?.name??''), dateTime: DateTime.now(), title: StringManager.notificationTitleAcceptAppointment, message: ''))
  //         :Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: appointment?.idUser, subtitle: StringManager.notificationSubTitleCanceledAppointment+' '+(Get.put(ProfileController())?.currentUser.value?.name??''), dateTime: DateTime.now(), title: StringManager.notificationTitleCanceledAppointment, message: ''));
  //
  //         ConstantsWidgets.closeDialog();
  //         // if(result['status'])
  //         //    Get.to(ChatPage(), arguments: {'chat': controller.chat});
  //       }else{
  //         ConstantsWidgets.closeDialog();
  //         ConstantsWidgets.TOAST(null,
  //             textToast: StringManager.errorTryAgainLater
  //             // textToast:  tr(LocaleKeys.message_error_try_again_later)
  //             , state: false);
  //       }
  //     }
  //     // else{
  //     //   await LauncherHelper.launchWebsite(context,'https://wa.me/+966${person.phoneNumber?.replaceAll('+966', '')}');
  //     //   ConstantsWidgets.closeDialog();
  //     // }
  //
  //   // }
  //
  // }
  //

}
