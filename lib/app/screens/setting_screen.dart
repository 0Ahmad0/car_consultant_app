import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool pushNotificationValue = true;
  bool locationEnableValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.settingText,),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatefulBuilder(
              builder: (context,pushNotificationSetState) {
                return SwitchListTile(
                    dense: true,
                    title: Text(StringManager.pushNotificationText),
                    value: pushNotificationValue,
                    onChanged: (value){
                      pushNotificationSetState((){
                        pushNotificationValue = value;
                      });
                    }
                );
              }
            ),
            StatefulBuilder(
              builder: (context,locationSetState) {
                return SwitchListTile(
                    dense: true,
                    title: Text(StringManager.locationText),
                    value: locationEnableValue
                    ,
                    onChanged: (value){
                      locationSetState((){
                        locationEnableValue = value;
                      });
                    }
                );
              }
            ),
            ListTile(
              onTap: (){
                context.pushNamed(Routes.changePasswordRoute);
              },
              dense: true,
              title: Text(StringManager.changePasswordText),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: (){
                context.pushNamed(Routes.languageRoute);
              },
              dense: true,
              title: Text(StringManager.languageText),
              trailing: Icon(Icons.keyboard_arrow_right),
            )

          ],
        ),
      ),
    );
  }
}
