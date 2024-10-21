import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AdminNotificationSettingsScreen extends StatefulWidget {
  const AdminNotificationSettingsScreen({super.key});

  @override
  State<AdminNotificationSettingsScreen> createState() => _AdminNotificationSettingsScreenState();
}

class _AdminNotificationSettingsScreenState extends State<AdminNotificationSettingsScreen> {

  bool appointmentReminders = false;
  bool systemAlerts = false;
  bool paymentNotify = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.notificationSettingsText),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringManager.appointmentRemindersText,
                style: StyleManager.font16SemiBold(),
              ),
              StatefulBuilder(builder:
              (context,appointmentSetState){
                return SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(StringManager.sendAppointmentRemindersText),
                    value: appointmentReminders,
                    onChanged: (value){
                      appointmentSetState((){
                        appointmentReminders = value;
                      });
                    }
                );
              }
              ),
              Text(
                StringManager.systemAlertsText,
                style: StyleManager.font16SemiBold(),
              ),
              StatefulBuilder(builder:
                  (context,systemSetState){
                return SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(StringManager.enableSystemIssueAlertsText),
                    value: systemAlerts,
                    onChanged: (value){
                      systemSetState((){
                        systemAlerts = value;
                      });
                    }
                );
              }
              ),

              Text(
                StringManager.paymentNotificationsText,
                style: StyleManager.font16SemiBold(),
              ),
              StatefulBuilder(builder:
                  (context,paymentSetState){
                return SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(StringManager.notifyUsersPaymentStatusText),
                    value: paymentNotify,
                    onChanged: (value){
                      paymentSetState((){
                        paymentNotify = value;
                      });
                    }
                );
              }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
