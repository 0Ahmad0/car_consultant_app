import 'dart:async';
import 'dart:io';

import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

import '../../core/enums/enums.dart';
import '../../core/helpers/launcher_helper.dart';
import '../../core/models/message_model.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/string_manager.dart';

class ShowFileWidget extends StatefulWidget {
  const ShowFileWidget({Key? key, required this.message}) : super(key: key);
  final Message message;
  @override
  State<ShowFileWidget> createState() => _ShowFileWidgetState();
}

class _ShowFileWidgetState extends State<ShowFileWidget> {

  @override
  Widget build(BuildContext context) {

    IconData iconData = _getFileIcon(widget.message.typeFile);
    return  ListTile(

        contentPadding:EdgeInsets.zero,
      onTap: (){
        if(widget.message.url?.isNotEmpty??false)
        LauncherHelper.launchWebsite(context,widget.message.url);
      },
      leading:
      (TypeFile.image.name==widget.message.typeFile&&(widget.message.localUrl?.isNotEmpty??false)&&File(widget.message.localUrl).existsSync())?
      // TypeFile.image.name==widget.message.typeFile&&(widget.message.localUrl?.isNotEmpty??false)?
      Image.file(
        File(
          widget.message.localUrl!,
        ),
        fit: BoxFit.cover,
      )
          :Icon(iconData, size: 40.sp),
      title: Text(widget.message.textMessage ?? "Unnamed File",
      style: StyleManager.font14Regular(),),
      // subtitle: Text(_formatFileSize(widget.message.sizeFile),  style: StyleManager.font14Regular(color: ColorManager.grayColor)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.0), // تعديل ارتفاع التباعد حسب الحاجة
          Text(
            _formatFileSize(widget.message.sizeFile),
            style: StyleManager.font14Regular(color: ColorManager.grayColor),
          ),
        ],
      )  );
  }
  IconData _getFileIcon(String? type) {
    switch (TypeFile.values.where((element) => element.name == type).firstOrNull) {
      case TypeFile.image:
        return Icons.image;
      case TypeFile.audio:
        return Icons.audiotrack;
      case TypeFile.file:
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatFileSize(int? size) {
    if (size == null) return "Undefined";
    if (size < 1024) return "$size Byte";
    if (size < 1024 * 1024) return "${(size / 1024).toStringAsFixed(2)} KB";
    if (size < 1024 * 1024 * 1024) return "${(size / (1024 * 1024)).toStringAsFixed(2)} MB";
    return "${(size / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB";
  }
}
