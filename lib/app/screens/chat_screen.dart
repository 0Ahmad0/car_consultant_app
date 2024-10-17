import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/string_manager.dart';
import '../../core/widgets/app_padding.dart';
import '../../core/widgets/app_textfield.dart';
import '../widgets/ai_bot_welcome_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
        title: Text('Consult Service1'),
        actions: [
          CircleAvatar(
            backgroundColor: ColorManager.primaryColor,
            child: Padding(
              padding: EdgeInsets.all(4.sp),
              child: Image.asset(
                AssetsManager.consultantServiceIMG,
              ),
            ),
          ),
          horizontalSpace(10.w),
        ],
      ),
      body: Column(
        children: [
          const Spacer(),
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
                    visible: messageController.text.isNotEmpty,
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
