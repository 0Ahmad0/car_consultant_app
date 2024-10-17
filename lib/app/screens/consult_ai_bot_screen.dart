import 'package:animate_do/animate_do.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/ai_bot_welcome_widget.dart';

class ConsultAiBotScreen extends StatefulWidget {
  const ConsultAiBotScreen({super.key});

  @override
  State<ConsultAiBotScreen> createState() => _ConsultAiBotScreenState();
}

class _ConsultAiBotScreenState extends State<ConsultAiBotScreen> {
  final messageController = TextEditingController();

  @override
  void initState() {
    messageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.appName),
        actions: [
          CircleAvatar(
            backgroundColor: ColorManager.primaryColor,
            child: Padding(
              padding: EdgeInsets.all(4.sp),
              child: Image.asset(
                AssetsManager.aiBotIMG,
              ),
            ),
          ),
          horizontalSpace(10.w),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            ///Implement Chat Service
            child: AiBotWelcomeWidget(),
          ),
          AppPaddingWidget(
            horizontalPadding: 10.w,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: ColorManager.primaryColor,
                  ),
                ),
                Flexible(
                  child: AppTextField(
                    hintText: StringManager.typeMessageText,
                  ),
                ),
                horizontalSpace(10.w),
                Visibility(
                    visible: messageController.text.isEmpty,
                    child: FadeIn(
                      key: UniqueKey(),
                      child: CircleAvatar(
                        backgroundColor: ColorManager.primaryColor,
                        child: Icon(
                          Icons.send,
                          color: ColorManager.whiteColor,
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
