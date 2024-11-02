
import 'package:car_consultant/app/widgets/show_file_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/enums/enums.dart';
import '../../core/helpers/operation_file.dart';
import '../../core/helpers/sizer.dart';
import '../../core/models/message_model.dart';
import '../../core/utils/color_manager.dart';
import '../controllers/chat_room_controller.dart';
import '../controllers/process_controller.dart';

class MessageWidget extends GetView<ChatRoomController> {
  const MessageWidget(
      {super.key,
      required this.index,
      required this.message,
      required this.isCurrentUser});

  final int index;
  final bool isCurrentUser;
  final String message;

  @override
  Widget build(BuildContext context) {
    if (isCurrentUser) {
      //id == firebaseId

      return SenderWidget(
        chatList: controller.chatList,
        index: index,
      );
    } else {
      return ReceiveWidget(
        chatList: controller.chatList,
        index: index,
      );
    }
  }
}
// buildMessageAudio(value, {required Message message, bool isReplay = false}) {
//   return  Column(
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Row(
//         children: [
//           CircleAvatarDownload(value,
//               message: message,
//               iconDownload: SvgPicture.asset(
//                 ImagesAssets.download_audio,
//                 color: ColorManager.whiteColor,
//               )),
//            SizedBox(
//             width: 10.w,
//           ),
//           Expanded(
//               child: Row(
//                 children: List.generate(
//                     25,
//                         (index) => Container(
//                       margin:
//                       EdgeInsets.symmetric(horizontal: 1.5.w),
//                       color: ColorManager.blackColor,
//                       width: 1.5.w,
//                       height: (index.isEven
//                           ? (index + 1) * .8
//                           : (index + 1) * .5),
//                     )),
//               )),
//         ],
//       ),
//       Padding(
//         padding:  EdgeInsets.all(4.sp),
//         child: Text(
//           formatFileSize(message.sizeFile),
//           style: StyleManager.font12Light(color: ColorManager.blackColor),
//         ),
//       )
//     ],
//   );
// }

class ReceiveWidget extends GetView<ChatRoomController> {
   ReceiveWidget({
    super.key,
    required this.chatList,
    required this.index,

  });
  final List<Message> chatList;
  final int index;
  final ProcessController _processController = Get.put(ProcessController());



  @override
  Widget build(BuildContext context) {
    final recId =
    controller.getIdUserOtherFromList(controller.chat?.listIdUser ?? []);

    return
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: getWidth(context) / 1.5,
          ),
          padding: EdgeInsets.all(6.sp),
          decoration: BoxDecoration(
              color: ColorManager.grayColor,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(12.r),
                  topEnd: Radius.circular(12.r),
                  bottomStart: Radius.circular(12.r))),
          margin: EdgeInsets.symmetric(
              horizontal: 10.w, vertical: 10.h),
          child:
          (TypeMessage.file.name==chatList[index].typeMessage)?
          ShowFileWidget(message: chatList[index],)
              :
          Text('${chatList[index].textMessage}'),
        ),
      )
  ;

  }
}

class SenderWidget extends GetView<ChatRoomController> {
  SenderWidget({
    super.key,
    required this.chatList,
    required this.index,
  });

  final List<Message> chatList;
  final int index;
  final ProcessController _processController = Get.put(ProcessController());

  @override
  Widget build(BuildContext context) {
    return     Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: getWidth(context) / 1.5),
        padding: EdgeInsets.all(6.sp),
        margin: EdgeInsets.symmetric(
            horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color:
          ColorManager.primaryColor.withOpacity(.5),
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(12.r),
              topEnd: Radius.circular(12.r),
              bottomEnd: Radius.circular(12.r)),
        ),
        child:
        (!chatList[index].checkSend)?
            Row(children: [
              CircularProgressIndicator()
             ,Spacer(),
        if(TypeMessage.file.name==chatList[index].typeMessage)
          Text(formatFileSize(chatList[index].sizeFile)+' ..')
              ,Spacer(),
              Text("Connecting"),
              Spacer()],):
        (TypeMessage.file.name==chatList[index].typeMessage)?
        ShowFileWidget(message: chatList[index],)
            :
        Text('${chatList[index].textMessage}'),
      ),
    );
  }
}
