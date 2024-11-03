


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
import '../../core/helpers/get_color_status_appointments.dart';
import '../../core/models/appointment.dart';
import '../../core/models/notification_model.dart';
import '../../core/routing/routes.dart';
import '../../core/widgets/constants_widgets.dart';
import 'chat_controller.dart';
import 'chat_room_controller.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';
import 'package:get/get_core/src/get_main.dart';

import 'notifications_controller.dart';

class ManageRequestAppointmentsController extends GetxController{

  final searchController = TextEditingController();
  Appointments appointments=Appointments(items: []);
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
    final result = FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionAppointment)
        .where('idProvider', isEqualTo: uid)
        .snapshots();

    return result;
  }
  filter({required String term}) async {
    appointments.items=appointments.items.where((element)=>
    [null,"", ColorAppointments.Pending.name].contains(element.state)
    ).toList();
    // providersWithFilter.items=[];
    // Appointments.items.forEach((element) {
    //
    //   if((element.name?.toLowerCase().contains(term.toLowerCase())??false))
    //     providersWithFilter.items.add(element);
    // });
     update();
  }


  acceptOrRejectedRequest(BuildContext context ,ColorAppointments? state,Appointment? appointment) async {
    var result;
    appointment?.state=state?.name;
    ConstantsWidgets.showLoading();
    {
      result=await FirebaseFun.updateAppointment(appointment:appointment!);


        //TODO dd notification
        // if(result['status'])
        //   context.read<NotificationProvider>().addNotification(context, notification: models.Notification(idUser: users[index].uid, subtitle: AppConstants.notificationSubTitleNewChat+' '+(profileProvider?.user?.firstName??''), dateTime: DateTime.now(), title: AppConstants.notificationTitleNewChat, message: ''));

        if(result['status']){
          state==ColorAppointments.Confirmed?
          Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: appointment?.idUser, subtitle: StringManager.notificationSubTitleAcceptAppointment+' '+(Get.put(ProfileController())?.currentUser.value?.name??''), dateTime: DateTime.now(), title: StringManager.notificationTitleAcceptAppointment, message: ''))
          :Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: appointment?.idUser, subtitle: StringManager.notificationSubTitleCanceledAppointment+' '+(Get.put(ProfileController())?.currentUser.value?.name??''), dateTime: DateTime.now(), title: StringManager.notificationTitleCanceledAppointment, message: ''));

          ConstantsWidgets.closeDialog();
          // if(result['status'])
          //    Get.to(ChatPage(), arguments: {'chat': controller.chat});
        }else{
          ConstantsWidgets.closeDialog();
          ConstantsWidgets.TOAST(null,
              textToast: StringManager.errorTryAgainLater
              // textToast:  tr(LocaleKeys.message_error_try_again_later)
              , state: false);
        }
      }
      // else{
      //   await LauncherHelper.launchWebsite(context,'https://wa.me/+966${person.phoneNumber?.replaceAll('+966', '')}');
      //   ConstantsWidgets.closeDialog();
      // }

    // }

  }


}
