import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
            SwitchListTile(
                dense: true,
                title: Text(StringManager.pushNotificationText),
                value: true,
                onChanged: (value){}
            ),
            SwitchListTile(
                dense: true,
                title: Text(StringManager.locationText),
                value: false
                ,
                onChanged: (value){}
            ),
            ListTile(
              onTap: (){},
              dense: true,
              title: Text(StringManager.changePasswordText),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: (){},
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
