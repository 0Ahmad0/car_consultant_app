

import 'package:car_consultant/app/controllers/profile_controller.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/models/education_resource.dart';
import 'package:car_consultant/core/models/user_model.dart';
import 'package:car_consultant/core/utils/app_constant.dart';
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

class NotificationsController extends GetxController{

  Notifications notifications=Notifications(items: []);
  String? uid;
  var getNotifications;

  @override
  void onInit() {
   ProfileController profileController=Get.put(ProfileController());
   uid= profileController.currentUser.value?.uid;
   getNotificationsFun();
    super.onInit();
    }

  getNotificationsFun() async {
    getNotifications =_fetchNotificationsStream();
    return getNotifications;
  }
  @override
  void dispose() {
    super.dispose();
  }


  _fetchNotificationsStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionNotification)
        .where('idUser',isEqualTo: uid)
        .snapshots();
    return result;
  }


  addNotification(BuildContext context ,{ required NotificationModel notification}) async {
    var result;
    // ConstantsWidgets.showLoading();
    // notification.idUser??=uid??Get.put(ProfileController()).currentUser.value?.uid;
    result =await FirebaseFun.addNotification(notification: notification);
    //print(result);
    //   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    // ConstantsWidgets.closeDialog();
  }

  updateNotification(context,{ required NotificationModel notification}) async {
    var result;
    result =await FirebaseFun.updateNotification(notification: notification);

    // Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

}
