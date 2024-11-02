import 'package:animate_do/animate_do.dart';
import 'package:car_consultant/core/helpers/operation_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../core/enums/enums.dart';
import '../../core/helpers/spacing.dart';
import '../../core/models/chat_model.dart';
import '../../core/models/message_model.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/string_manager.dart';
import '../../core/widgets/app_padding.dart';
import '../../core/widgets/app_textfield.dart';
import '../../core/widgets/constants_widgets.dart';
import '../controllers/chat_room_controller.dart';
import '../controllers/process_controller.dart';
import '../widgets/ai_bot_welcome_widget.dart';
import '../widgets/image_user_provider.dart';
import '../widgets/message_widget.dart';
import '../widgets/no_messages_yet_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  late ChatRoomController controller;
  var args;
  var initData;
  @override
  void initState() {
    controller = Get.put(ChatRoomController());
    // messageController.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // args=ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // controller.chat=(args['chat'] is Chat?)?args['chat']:null;
    controller.onInit();
    Get.lazyPut(() => ProcessController());
    ProcessController.instance.fetchUser(context,idUser: controller.recId??'');
    return Scaffold(
      appBar:

      AppBar(
        title:
      GetBuilder<ProcessController>(
      builder: (ProcessController processController) =>
        Text('${processController.fetchLocalUser(idUser: controller.recId ?? 'ALL Chat')?.name ?? ''}')),
        // Text('Consult Service1')),
        actions: [
      GetBuilder<ProcessController>(
      builder: (ProcessController processController) =>
                  processController.fetchLocalUser(idUser: controller.recId ?? '')?.typeUser==AccountType.User.name?
                  ImageUserProvider(
                    url:  '${processController.fetchLocalUser(idUser: controller.recId ?? '')?.photoUrl ?? ''}',
                    errorBuilder:  Icon(

                      Icons.account_circle_outlined,
                    ),
                  ):
                  CircleAvatar(
                    backgroundColor: ColorManager.primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(4.sp),
                      child: Image.asset(
                        AssetsManager.consultantServiceIMG,
                      ),
                    ),
                  )),
          // CircleAvatar(
          //   backgroundColor: ColorManager.primaryColor,
          //   child: Padding(
          //     padding: EdgeInsets.all(4.sp),
          //     child: Image.asset(
          //       AssetsManager.consultantServiceIMG,
          //     ),
          //   ),
          // ),
          horizontalSpace(10.w),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child:
            StreamBuilder<QuerySnapshot>(
                stream: controller.getChat,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return    ConstantsWidgets.circularProgress();
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    if (snapshot.hasError) {
                      return  Text(StringManager.emptyData);
                      // return  Text(tr(LocaleKeys.empty_data));
                    } else if (snapshot.hasData) {

                      // ConstantsWidgets.circularProgress();
                      controller.chat?.messages.clear();
                      if (snapshot.data!.docs!.length > 1) {
                        controller.chat?.messages =
                            Messages.fromJson(snapshot.data!.docs!).listMessage;
                      }

                      return GetBuilder<ChatRoomController>(
                          init: controller,
                          builder: (ChatRoomController chatRoomController){
                            Message? message=controller.waitMessage.lastOrNull;
                            message?.checkSend=false;
                            if(message!=null)
                              controller.chat?.messages.add( message);

                            return
                              buildChat(context,controller.chat?.messages ?? []);
                          });

                    } else {
                      return  Text(StringManager.emptyData);
                      // return  Text(tr(LocaleKeys.empty_data));
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                }),
            //
            // _messages.isEmpty
            //     ? NoMessagesYetWidget()
            //     : ListView.builder(
            //         itemCount: _messages.length,
            //         itemBuilder: (context, index) => index.isEven
            //             ? Align(
            //                 alignment: AlignmentDirectional.centerStart,
            //                 child: Container(
            //                   constraints: BoxConstraints(
            //                       maxWidth: getWidth(context) / 1.5),
            //                   padding: EdgeInsets.all(10.sp),
            //                   margin: EdgeInsets.symmetric(
            //                       horizontal: 10.w, vertical: 10.h),
            //                   decoration: BoxDecoration(
            //                     color:
            //                         ColorManager.primaryColor.withOpacity(.5),
            //                     borderRadius: BorderRadiusDirectional.only(
            //                         topStart: Radius.circular(12.r),
            //                         topEnd: Radius.circular(12.r),
            //                         bottomEnd: Radius.circular(12.r)),
            //                   ),
            //                   child: Text('${_messages[index]}'),
            //                 ),
            //               )
            //             : Align(
            //                 alignment: AlignmentDirectional.centerEnd,
            //                 child: Container(
            //                   constraints: BoxConstraints(
            //                     maxWidth: getWidth(context) / 1.5,
            //                   ),
            //                   padding: EdgeInsets.all(10.sp),
            //                   decoration: BoxDecoration(
            //                       color: ColorManager.grayColor,
            //                       borderRadius: BorderRadiusDirectional.only(
            //                           topStart: Radius.circular(12.r),
            //                           topEnd: Radius.circular(12.r),
            //                           bottomStart: Radius.circular(12.r))),
            //                   margin: EdgeInsets.symmetric(
            //                       horizontal: 10.w, vertical: 10.h),
            //                   child: Text('${_messages[index]}'),
            //                 ),
            //               ),
            //       ),
          ),
          // const Spacer(),
          GetBuilder<ChatRoomController>(
          init: controller,
          builder: (ChatRoomController chatRoomController){
              return AppPaddingWidget(
                horizontalPadding: 10.w,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        pickerFiles();
                      },
                      icon: Icon(
                        Icons.add,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                    Flexible(
                      child: AppTextField(
                        controller:controller.messageController ,
                        hintText: StringManager.typeMessageText,
                        onChanged: (_)=>controller.update(),
                      ),
                    ),
                    horizontalSpace(10.w),
                    Visibility(
                        visible: controller.messageController.text.isNotEmpty,
                        child:
                        InkWell(
                          onTap: ()=>sendText(),
                          child: CircleAvatar(
                            backgroundColor: ColorManager.primaryColor,
                            child: Icon(
                              Icons.send,
                              color: ColorManager.whiteColor,
                            ),
                          ),
                        )
                        // FadeIn(
                        //   key: UniqueKey(),
                        // )
                    )
                  ],
                ),
              );
            }
          )
        ],
      ),
    );
  }
  Widget buildChat(BuildContext context, List<Message> messages) {
    controller.chatList = messages;

    return controller.chatList.isEmpty
        ? NoMessagesYetWidget()
        : ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) =>
        // index.isEven


        MessageWidget(

          isCurrentUser:
          controller.chatList[index].senderId ==
              controller.currentUserId,
          index: index,
          message: '',)

    );

    //     : Expanded(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: List.generate(
    //           controller.chatList.length,
    //               (index) => MessageWidget(
    //
    //             isCurrentUser:
    //             controller.chatList[index].senderId ==
    //                 controller.currentUserId,
    //             index: index,
    //             message: '',)
    //
    //       ),
    //     ),
    //   ),
    // );
  }
  pickerFiles() async {
    final file = FilePicker.platform;
    FilePickerResult? filePickerResult= await file.pickFiles(allowMultiple:true);
    for(PlatformFile platformFile in filePickerResult?.files??[])
    {
      await controller.sendMessage(
        context,
        idChat: controller.chat?.id ?? '',
        message: Message(
          // textMessage: 'Audio message',
          textMessage: platformFile.name+'-${Timestamp.now().microsecondsSinceEpoch}',
          sizeFile: ( platformFile?.size)??0,
          typeMessage: TypeMessage.file.name,
          typeFile: getFileType(platformFile.path).name,
          senderId: controller.currentUserId,
          receiveId: controller.recId ?? '',
          sendingTime: DateTime.now(),
          localUrl: platformFile?.path??'',
        ),
      );
      controller.update();
      // Get.put(GuestProblemController()).addFile(platformFile.xFile,platformFile: platformFile,type: TypeFile.file.name);
    }
  }
  sendText() async {

    if (controller.messageController.value.text.trim().isNotEmpty) {
      String message = controller.messageController.value.text;
      controller.messageController.clear();
      await controller.sendMessage(
        context,
        idChat: controller.chat?.id ?? '',
        message: Message(
          textMessage: message,
          typeMessage: TypeMessage.text.name,
          senderId: controller.currentUserId,
          receiveId: controller.recId ?? '',
          sendingTime: DateTime.now(),
        ),
      );
      controller.update();
    }
  }
}
