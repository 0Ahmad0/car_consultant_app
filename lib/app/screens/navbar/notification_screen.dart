import 'package:car_consultant/core/widgets/custome_back_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/models/notification_model.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/string_manager.dart';
import '../../../core/utils/style_manager.dart';
import '../../../core/widgets/constants_widgets.dart';
import '../../controllers/notifications_controller.dart';
import '../../controllers/profile_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationsController controller;
  void initState() {
    controller = Get.put(NotificationsController());
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.notificationText),
      ),
      body:
      StreamBuilder<QuerySnapshot>(
          stream: controller.getNotifications,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return    ConstantsWidgets.circularProgress();
            } else if (snapshot.connectionState ==
                ConnectionState.active) {
              if (snapshot.hasError) {
                return  Text('Error');
              } else if (snapshot.hasData) {
                ConstantsWidgets.circularProgress();
                controller.notifications.items.clear();
                if (snapshot.data!.docs.length > 0) {

                  controller.notifications.items =
                      Notifications.fromJson(snapshot.data?.docs).items;
                }
               return
                  GetBuilder<NotificationsController>(
                      builder: (NotificationsController notificationsController)=>
                      (notificationsController.notifications.items.isEmpty ?? true)
                          ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetsManager.noNotificationIMG,
                            width: 140.w,
                            height: 140.h,
                          ),
                          verticalSpace(30.h),
                          Text(
                            StringManager.noNotificationText,
                            textAlign: TextAlign.center,
                            style:
                            StyleManager.font14Regular(color: ColorManager.hintTextColor),
                          ),
                        ],
                      )
                          :

                      buildNotification(context, controller.notifications.items ?? []));
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          })


    );
  }

  Widget buildNotification(BuildContext context,List<NotificationModel> items){
    return
      ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) {
            bool isSameDate = true;
            final DateTime? date = items[index]
                .dateTime; //DateTime.parse(dateString);
            final item = items[index];
            if (index == 0) {
              isSameDate = false;
            } else {
              //final String prevDateString = list[index - 1]['time'];
              final DateTime? prevDate = items[
              index - 1]
                  .dateTime; //DateTime.parse(prevDateString);
              isSameDate = date?.isSameDate(prevDate??DateTime.now())??false;
            }
            if (index == 0 || !(isSameDate)) {
              return NotificationWidget(
                date: date??DateTime.now(),
                index: index,
                notificationModel: item,
              );
            } else {
              return NotificationItem(
                index: index,
                notificationModel: item,
              );
            }
          });
  }


}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.index,
    required this.notificationModel,
  });

  final int index;
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        notificationModel.checkRec = true;
        Get.put(NotificationsController())
            .updateNotification(context, notification: notificationModel);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 14.sp, vertical: 14.sp),
        decoration: BoxDecoration(
          color: !notificationModel.checkRec
              ? ColorManager.primaryColor.withOpacity(0.2)
              : ColorManager.grayColor,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: ListTile(
          title: Text(
            notificationModel.title + ' $index',
            style: StyleManager.font14Bold(
                // size: 20.sp,
                color: notificationModel.checkRec
                    ? ColorManager.primaryColor
                    : ColorManager.primaryColor),
          ),
          subtitle: Text(
            notificationModel.subtitle??'',
            style: StyleManager.font14Regular().copyWith(

                color: !notificationModel.checkRec
                    ? ColorManager.blackColor
                    : ColorManager.blackColor),
          ),
          trailing: Icon(!notificationModel.checkRec ? null : Icons.check),
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.date,
    required this.index,
    required this.notificationModel,
  });

  final DateTime date;
  final int index;
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(
                    left: 8.sp,
                    top:10.sp,
                    bottom:8.sp),
                child: Text(
                  date.formatDate(),
                  style: StyleManager.font16Regular(
                    // size: 16.sp,
                    // color: ColorManager.appBarColor,
                  ),
                ),
              ),
              Expanded(
                  child: Divider(
                    color: ColorManager.grayColor,
                  ))
            ],
          ),
          NotificationItem(
            index: index,
            notificationModel: notificationModel,
          )
        ]);
  }
}
const String dateFormatter = 'MMMM dd, y';
extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}