import 'dart:developer';

import 'package:car_consultant/core/enums/enums.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:car_consultant/core/widgets/custome_back_button.dart';
import 'package:car_consultant/core/widgets/no_data_found_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../core/models/chat_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/widgets/constants_widgets.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/chat_room_controller.dart';
import '../../controllers/process_controller.dart';
import '../../widgets/image_consultant_provider.dart';
import '../../widgets/image_service_provider.dart';
import '../../widgets/image_user_provider.dart';

var _borderTextFiled = ({Color color = ColorManager.primaryColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: color));

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late ChatController chatController;
  final ProcessController _processController = Get.put(ProcessController());

  @override
  void initState() {
    chatController = Get.put(ChatController());
    chatController.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          context.pushNamed(Routes.aiBotRoute);
        },
        child: Padding(
          padding:  EdgeInsets.all(8.sp),
          child: Image.asset(
            AssetsManager.aiBotIMG,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          StringManager.messageText,
        ),
      ),
      body: true
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppPaddingWidget(
                  child: TextField(
                    onSubmitted: (value) {
                      log('${value}');
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorManager.grayColor,
                        border: _borderTextFiled(),
                        focusedBorder:
                            _borderTextFiled(color: ColorManager.primaryColor),
                        enabledBorder:
                            _borderTextFiled(color: ColorManager.hintTextColor),
                        hintText: StringManager.searchMessageText,
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        )),
                  ),
                ),
                Expanded(
                  child:
                  StreamBuilder<QuerySnapshot>(
                      stream: chatController.getChats,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return    ConstantsWidgets.circularProgress();
                        } else if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasError) {
                            return  Text(StringManager.emptyData);
                            // return  Text(tr(LocaleKeys.empty_data));
                          } else if (snapshot.hasData) {
                            ConstantsWidgets.circularProgress();
                            chatController.chats.listChat.clear();
                            if (snapshot.data!.docs!.length > 0) {
                              chatController.chats = Chats.fromJson(snapshot.data!.docs!);
                            }
                            return

                              (chatController.chats.listChat.isEmpty)
                                  ?  Center(
                                    child: NoDataFoundWidget(
                                                                    // text: tr(LocaleKeys.home_no_faces_available))
                                                                    // text: StringManager.infoNotFacesYet
                                    // text: tr(LocaleKeys.chat_no_chats_yet))
                                                                  text: "No Chats Yet!"),
                                  )
                                  :

                              buildChats(context, chatController.chats.listChat ?? []);
                          } else {
                            return  Text(StringManager.emptyData);
                            // return  Text(tr(LocaleKeys.empty_data));
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}');
                        }
                      })

                  // ListView.separated(
                  //   separatorBuilder: (_, __) => Divider(
                  //     height: 0.0,
                  //     thickness: .5,
                  //   ),
                  //   itemBuilder: (context, index) => ListTile(
                  //     onTap: () {
                  //       context.pushNamed(Routes.chatRoute);
                  //     },
                  //     isThreeLine: true,
                  //     contentPadding:
                  //         EdgeInsets.symmetric(horizontal: 20.h, vertical: 4.h),
                  //     leading: CircleAvatar(
                  //       child: Icon(
                  //         Icons.account_circle_outlined,
                  //       ),
                  //     ),
                  //     trailing: Text(
                  //       DateFormat().add_jm().format(DateTime.now()),
                  //       style: StyleManager.font10Regular(
                  //           color: ColorManager.blackColor),
                  //     ),
                  //     title: Text('Consultant ${index + 1}'),
                  //     subtitle: Padding(
                  //       padding: EdgeInsets.only(top: 8.h),
                  //       child: Text(
                  //         'Yes, the work is all done',
                  //         style: StyleManager.font12Regular(
                  //             color: ColorManager.hintTextColor),
                  //       ),
                  //     ),
                  //   ),
                  //   itemCount: 10,
                  // ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsManager.noMessagesIMG,
                  width: 140.w,
                  height: 140.h,
                ),
                verticalSpace(30.h),
                Text(
                  StringManager.noMessageYetText,
                  textAlign: TextAlign.center,
                  style: StyleManager.font18Medium(
                      color: ColorManager.primaryColor),
                ),
                verticalSpace(20.h),
                Text(
                  StringManager.startChatText,
                  textAlign: TextAlign.center,
                  style: StyleManager.font12Regular(
                      color: ColorManager.hintTextColor),
                ),
              ],
            ),
    );
  }
  Widget buildChats(BuildContext context,List<Chat> items){

    return
      GetBuilder<ChatController>(
          builder: (ChatController controller)=>

              ListView.separated(
                separatorBuilder: (_, __) => Divider(
                  height: 0.0,
                  thickness: .5,
                ),
                itemBuilder: (context, index) {
                  String? idUser=(controller.currentUserId.contains(controller.chats.listChat[index].listIdUser[0]))
                      ?controller.chats.listChat[index].listIdUser[1]
                      :controller.chats.listChat[index].listIdUser[0];

                  return  ListTile(
                  onTap: () {
                    Get.put(ChatRoomController()).chat=controller.chats.listChat[index];

                    context.pushNamed(Routes.chatRoute,arguments: {
                      'index':index.toString(),
                      'chat':controller.chats.listChat[index]
                    });
                    // context.pushNamed(Routes.chatRoute);
                  },
                  isThreeLine: true,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.h, vertical: 4.h),
                  leading:
                  GetBuilder<ProcessController>(
                      builder: (ProcessController processController) {
                        processController.fetchUserAsync(context, idUser: idUser);
                        UserModel? user = processController.fetchLocalUser(idUser: idUser);
                        return

                        user?.typeUser==AccountType.User.name?
                        ImageUserProvider(
                          url: user?.photoUrl,
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
                        )


                        ;
                  // CircleAvatar(
                  //   child: Icon(
                  //     Icons.account_circle_outlined,
                  //   ),
                  // );
                      }),
                  trailing:

                  fetchTimeLastMessage(context,controller.chats.listChat[index].id),
                  // Text(
                  //   DateFormat().add_jm().format(DateTime.now()),
                  //   style: StyleManager.font10Regular(
                  //       color: ColorManager.blackColor),
                  // ),
                  title:
                  fetchName(context,  idUser  ),
                  // Text( 'Consultant ${index + 1}' ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child:
                    fetchLastMessage(context,controller.chats.listChat[index].id),
                    // Text('Yes, the work is all done',
                    //   style: StyleManager.font12Regular(
                    //       color: ColorManager.hintTextColor),
                    // ),
                  ),
                );},
                itemCount: items.length,
              )

      );

  }

  fetchName(BuildContext context,String idUser){
    return _processController.widgetNameUser(context, idUser: idUser);
  }
  fetchLocalUser(BuildContext context,String idUser){
    return _processController.fetchUser(context, idUser: idUser);
  }
  fetchLastMessage(BuildContext context,String idChat){
    return Get.put(ChatController()).widgetLastMessage(context, idChat: idChat);
  }
  fetchTimeLastMessage(BuildContext context,String idChat){
    return Get.put(ChatController()).widgetTimeLastMessage(context, idChat: idChat);
  }
}
