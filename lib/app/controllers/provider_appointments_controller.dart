

import 'package:car_consultant/app/controllers/profile_controller.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/models/education_resource.dart';
import 'package:car_consultant/core/models/user_model.dart';
import 'package:car_consultant/core/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/helpers/get_color_status_appointments.dart';
import '../../core/models/appointment.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/string_manager.dart';
import '../../core/widgets/constants_widgets.dart';
import '../widgets/select_time_widget.dart';
import 'chat_controller.dart';
import 'chat_room_controller.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';
import 'package:get/get_core/src/get_main.dart';

class ProviderAppointmentsController extends GetxController{

  final searchController = TextEditingController();
  Appointments appointments=Appointments(items: []);
  Appointments upAppointments=Appointments(items: []);
  Appointments currAppointments=Appointments(items: []);
  Appointments prevAppointments=Appointments(items: []);
  String? idProvider;
  var getAppointments;

  @override
  void onInit() {
   searchController.clear();
   // ProfileController profileController=Get.put(ProfileController());
   // uid= profileController.currentUser.value?.uid;
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
        .where('idProvider',isEqualTo: idProvider)
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
      switch(element.getState){
        case 1:
          upAppointments.items.add(element);
        case 0:
          currAppointments.items.add(element);
        case -1:
          prevAppointments.items.add(element);
        default:
          upAppointments.items.add(element);
      }
      // switch(element.state){
      //   case ColorAppointments.Confirmed:
      //   case ColorAppointments.Rescheduled:
      //   case ColorAppointments.Pending:
      //   case null:
      //     if()
      //     upAppointments.items.add(element);
      //   case ColorAppointments.Ongoing:
      //   case ColorAppointments.StartingSoon:
      //     currAppointments.items.add(element);
      //   case ColorAppointments.Concluded:
      //   case ColorAppointments.Canceled:
      //     prevAppointments.items.add(element);
      //   default:
      //     upAppointments.items.add(element);
      // }
    });
    update();
  }

  List<TimeHourModel> getTimeSlots(
      DateTime selectedDate, DateTime? fromHour, DateTime? toHour, List<Appointment> appointments) {
    List<TimeHourModel> timeSlots = [];

    // تحديد القيم الافتراضية عند الحاجة
    if (fromHour == null && toHour == null) {
      fromHour = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 12, 0);
      toHour = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 20, 0);
    } else if (fromHour != null && toHour == null) {
      toHour = fromHour.add(Duration(hours: 8));
    } else if (fromHour == null && toHour != null) {
      fromHour = toHour.subtract(Duration(hours: 8));
    }

    // استخدام القيم بعد ضبطها لضمان عدم وجود null
    DateTime currentTime = fromHour!;

    while (currentTime.isBefore(toHour!)) {
      DateTime nextHour = currentTime.add(Duration(hours: 1));

      // تحقق إذا كانت الفترة محجوزة في قائمة المواعيد
      bool isBooked = appointments.any((appointment) {
        return
      appointment.selectDate?.toLocal().year == selectedDate.year &&
          appointment.selectDate?.toLocal().month == selectedDate.month &&
          appointment.selectDate?.toLocal().day == selectedDate.day &&
          appointment.fromHour?.isAtSameMomentAs(currentTime) == true &&
          appointment.toHour?.isAtSameMomentAs(nextHour) == true;
      }
      );

      // إنشاء كائن TimeHourModel بالحالة المناسبة
      timeSlots.add(TimeHourModel(
        status: isBooked ? SelectTimeOrderStatus.book : SelectTimeOrderStatus.empty,
        fromTime: currentTime,
        toTime: nextHour,
      ));

      // الانتقال إلى الساعة التالية
      currentTime = nextHour;
    }


    return timeSlots;
  }

  connectionPerson(BuildContext context ,String? idUser) async {
    var result;
    ConstantsWidgets.showLoading();
        {

      result = await Get.put(ChatController()).createChat(
          listIdUser: [idUser??'',idProvider ?? '']);

      //TODO dd notification
      // if(result['status'])
      //   context.read<NotificationProvider>().addNotification(context, notification: models.Notification(idUser: users[index].uid, subtitle: AppConstants.notificationSubTitleNewChat+' '+(profileProvider?.user?.firstName??''), dateTime: DateTime.now(), title: AppConstants.notificationTitleNewChat, message: ''));

      result =  await Get.put(ChatController()).fetchChatByListIdUser(
          listIdUser: [idUser??'', idProvider ?? '']);

      if(result['status']){
        ConstantsWidgets.closeDialog();
        // if(result['status'])
        //    Get.to(ChatPage(), arguments: {'chat': controller.chat});
        Get.put(ChatRoomController()).chat=Get.put(ChatController()).chat;
        context.pushNamed(Routes.chatRoute, arguments: {
          'chat':Get.put(ChatController()).chat
        });
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
