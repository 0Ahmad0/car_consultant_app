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
import 'dart:developer';

import 'dart:io';

import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ConsultAiBotScreen extends StatefulWidget {
  const ConsultAiBotScreen({super.key});

  @override
  State<ConsultAiBotScreen> createState() => _ConsultAiBotScreenState();
}

class _ConsultAiBotScreenState extends State<ConsultAiBotScreen> {
  Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "User",
  );
  ChatUser geminiUser = ChatUser(
      id: "1",
      firstName: "GeminiUser",
      profileImage: "assets/icons/app_icon.png");

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
          Visibility(
            visible: messages.isEmpty,
            child: Expanded(
              flex: 2,
              child: AiBotWelcomeWidget(),
            ),
          ),
          Expanded(
            child: DashChat(
              inputOptions: InputOptions(
                trailing: [
                  IconButton(
                      onPressed: sendMediaMsg,
                      icon: const Icon(
                        Icons.image,
                      )),
                ],
              ),
              currentUser: currentUser,
              onSend: _sendMessage,
              messages: messages,
              messageOptions: MessageOptions(showTime: true),
              messageListOptions: MessageListOptions(
                showDateSeparator: true,
                dateSeparatorFormat: DateFormat.yMMMd(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(ChatMessage msg) {
    setState(() {
      messages = [msg, ...messages];
    });
    try {
      String question = msg.text;
      List<Uint8List>? images;
      if (msg.medias?.isNotEmpty ?? false) {
        images = [
          File(msg.medias!.first.url).readAsBytesSync(),
        ];
      }
      gemini.streamGenerateContent(question, images: images).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts
                  ?.fold("", (prev, curr) => "$prev ${curr.text}") ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage chatMessage = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [chatMessage, ...messages];
          });
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void sendMediaMsg() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: 'Describe this picture?',
          medias: [
            ChatMedia(url: file.path, fileName: "", type: MediaType.image)
          ]);
      _sendMessage(chatMessage);
    }
  }
}
