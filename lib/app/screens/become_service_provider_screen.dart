import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/enums/enums.dart';
import '../../core/helpers/operation_file.dart';
import '../../core/utils/string_manager.dart';
import '../controllers/request_provider_controller.dart';

class BecomeServiceProviderScreen extends StatefulWidget {
  const BecomeServiceProviderScreen({super.key});

  @override
  State<BecomeServiceProviderScreen> createState() => _BecomeServiceProviderScreenState();
}

class _BecomeServiceProviderScreenState extends State<BecomeServiceProviderScreen> {
  final formKey = GlobalKey<FormState>();
  late RequestProviderController controller;
  @override
  void initState() {
    controller = Get.put(RequestProviderController());
    controller.onInit();
    super.initState();
  }
  _pickFiles() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      for(PlatformFile platformFile in result?.files??[])
      {
        controller.addFile(platformFile.xFile,platformFile: platformFile,type: TypeFile.file.name);
      }
      // files = result.paths.map((path) => File(path!)).toList();
      // setState(() {});
    } else {
     // User canceled the picker
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.becomeAServiceProviderText ),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringManager.name,
                  style: StyleManager.font16SemiBold(),
                ),
                verticalSpace(10.h),
                AppTextField(
                  controller:controller.nameController,
                  hintText: StringManager.enterNameHintText,
                ),
                verticalSpace(20.h),
                Text(
                  StringManager.workshopNameText,
                  style: StyleManager.font16SemiBold(),
                ),
                verticalSpace(10.h),
                AppTextField(
                  controller:controller.workshopNameController,
                  hintText: StringManager.workshopNameHintText,
                ),
                verticalSpace(20.h),
                Text(
                  StringManager.tellAboutYourWorkShopText,
                  style: StyleManager.font16SemiBold(),
                ),
                verticalSpace(10.h),
                TextFormField(
                    controller:controller.aboutController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                              color: ColorManager.grayColor, width: .5)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: ColorManager.hintTextColor,
                          )),
                      hintText: StringManager.tellUsHintText,
                      helperText: StringManager.tellUsHelperText),
                  minLines: 4,
                  maxLines: 8,
                  maxLength: 300,
                  textInputAction: TextInputAction.newline,
                ),
                verticalSpace(20.h),
                Text(
                  StringManager.uploadFilesText,
                  style: StyleManager.font16SemiBold(),
                ),
                verticalSpace(10.h),
                StatefulBuilder(builder: (context, uploadFilesSetState) {
                  return GetBuilder<RequestProviderController>(
                      init: controller,
                      builder: ( requestProviderController)=>
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(8.r),
                        onTap: () {
                          _pickFiles();
                        },
                        child: DottedBorder(
                          radius: Radius.circular(8.r),
                          dashPattern: [0, 3, 3],
                          strokeWidth: 2.sp,
                          color: ColorManager.hintTextColor,
                          borderType: BorderType.RRect,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Center(
                              child: Text(
                                StringManager.clickToUploadFilesText,
                                textAlign: TextAlign.center,
                                style: StyleManager.font14Regular(
                                    color: ColorManager.hintTextColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: requestProviderController.provider?.additionalInfo?.files?.isNotEmpty ?? false,
                        child: Column(
                          children: [
                            verticalSpace(10.h),
                            SizedBox(
                              width: double.maxFinite,
                              height: 70.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => FadeIn(
                                  key: UniqueKey(),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        // width: 50.w,
                                        // height: 50.h,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 4.w,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 8.h,
                                        ),
                                        decoration: BoxDecoration(
                                            color: ColorManager.primaryColor,
                                            borderRadius:
                                            BorderRadius.circular(4.r)),
                                        child:
                                        Column(
                                          children: [
                                            Icon(
                                              getFileIcon( requestProviderController.provider?.additionalInfo?.files?[index].type),

                                            ),
                                            Flexible(
                                              child: Text(
                                              formatFileSize( requestProviderController.provider?.additionalInfo?.files?[index].size),
                                                // index.toString(),
                                                style: StyleManager.font12Medium(
                                                    color: ColorManager.whiteColor),
                                              ),
                                            ),
                                          ],
                                        )
                                        // Text(
                                        // formatFileSize( requestProviderController.provider?.additionalInfo?.files?[index].size),
                                        //   // index.toString(),
                                        //   style: StyleManager.font12Medium(
                                        //       color: ColorManager.whiteColor),
                                        // ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: InkWell(
                                            onTap: () {
                                              uploadFilesSetState(() {
                                                requestProviderController.removeFile(
                                                    requestProviderController.provider?.additionalInfo?.files?[index]
                                                );
                                                // files!.removeAt(index);
                                              });
                                            },
                                            child: CircleAvatar(
                                              radius: 10.sp,
                                              backgroundColor:
                                              ColorManager.errorColor,
                                              child: Icon(
                                                Icons.close,
                                                color: ColorManager.whiteColor,
                                                size: 10.sp,
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                itemCount: requestProviderController.provider?.additionalInfo?.files?.length ?? 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20.h),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.grayColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringManager.categoryText,
                              style: StyleManager.font14SemiBold(),
                            ),
                            verticalSpace(10.h),
                            Row(
                              children: [
                                Checkbox(value: requestProviderController.repairServices, onChanged: (value) {
                                  requestProviderController.repairServices=value??false;
                                  requestProviderController.update();
                                }),
                                horizontalSpace(8.w),
                                Text(StringManager.categoryRepairServicesText)
                              ],
                            ),
                            verticalSpace(10.h),
                            Row(
                              children: [
                                Checkbox(value:requestProviderController.inspectionDiagnostics, onChanged: (value) {
                                  requestProviderController.inspectionDiagnostics=value??false;
                                  requestProviderController.update();
                                }),
                                horizontalSpace(8.w),
                                Text(StringManager.categoryInspectionAndDiagnosticsText)
                              ],
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20.h),
                      Text(
                        StringManager.locationText,
                        style: StyleManager.font16SemiBold(),
                      ),
                      verticalSpace(10.h),
                      AppTextField(
                        controller: controller.locationController,
                        hintText: StringManager.enterYourLocationText,
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                      verticalSpace(20.h),
                      AppButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                             controller.addRequestProvider(context);
                            }

                          }, text: StringManager.submitText)
                    ],
                  ));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
