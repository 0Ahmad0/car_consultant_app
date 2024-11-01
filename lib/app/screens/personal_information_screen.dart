import 'dart:io';

import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../core/dialogs/picker_dialog.dart';
import '../../core/widgets/app_textfield_with_edit.dart';
import '../controllers/profile_controller.dart';
import '../widgets/image_user_provider.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dateBirthController = TextEditingController();

  late  ProfileController profileController;
  @override
  void initState() {
    profileController = Get.put(ProfileController());
    profileController.refresh();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateBirthController.dispose(); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.personalInformationText),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child:
              profileController.profileImage== null|| (profileController.profileImage?.path.isEmpty??true)?
              ImageUserProvider(
                url: profileController.imagePath,
                // url: profileController.currentUser.value?.photoUrl,
                radius: 44.sp,
              ):
              ClipOval(
                child: CircleAvatar(
                  radius: 44.sp,
                  child: Image.file(
                    File(profileController.profileImage!.path!),
                    // width: 44.sp,
                    // height: 44.sp,
                    fit: BoxFit.cover,
                  ),
                ),
              )
              // CircleAvatar(
              //   radius: 44.sp,
              //   child: Icon(Icons.person),
              // ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  {
                    showModalBottomSheet(
                      backgroundColor: ColorManager.whiteColor,
                      isScrollControlled: true,
                      enableDrag: true,
                      context: context,
                      isDismissible: false,
                      builder: (context) => PickerDialog(
                        deletePicker:
                        profileController.profileImage==null&&(profileController.imagePath?.isEmpty??true)?null:
                            () async {

                           profileController.deletePhoto();
                          setState(() {});

                          // onChange?.call();

                        },
                        galleryPicker: () async {
                          await profileController.pickPhoto(ImageSource.gallery);
                          // print('result ${profileController.profileImage}');
                          setState(() {

                          });
                          // onChange?.call();

                        },
                        cameraPicker: () async {
                          await profileController.pickPhoto(ImageSource.camera);
                          setState(() {

                          });
                        },
                      ),
                    );
                  }
                },
                child: Text(
                  StringManager.changeProfilePhotoText,
                  style: StyleManager.font12Regular(
                    color: ColorManager.blueColor,
                  ),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringManager.userNameText,
                    // StringManager.firstNameText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppTextFiledWithEdit(
                    hintText: StringManager.userNameText,
                    // hintText: StringManager.firstNameText,
                    icon: Icons.person,
                    controller: profileController.nameController,
                    // controller: firstNameController,
                    onEditTap: () {
                      print('object');
                    },
                  ),
                  verticalSpace(10.h),

                  ///
                  if(false)...[
                    Text(
                      StringManager.lastNameText,
                      style: StyleManager.font14SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppTextFiledWithEdit(
                      hintText: StringManager.lastNameText,
                      icon: Icons.person,
                      controller: lastNameController,
                      onEditTap: () {
                        print('object');
                      },
                    ),
                    verticalSpace(10.h),
                  ],



                  ///
                  Text(
                    StringManager.name,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppTextFiledWithEdit(
                    readOnly: true,
                    hintText: StringManager.emailAddressText,
                    icon: Icons.email,
                    controller: profileController.emailController,
                    // controller: emailController,
                    onEditTap: () {
                      print('object');
                    },
                  ),
                  verticalSpace(10.h),

                  ///
                  Text(
                    StringManager.phoneNumberText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppTextFiledWithEdit(
                    hintText: StringManager.phoneNumberText,
                    icon: Icons.phone_android,
                    controller: profileController.phoneController,
                    // controller: phoneController,
                    onEditTap: () {
                      print('object');
                    },
                  ),
                  verticalSpace(10.h),

                  ///
                  Text(
                    StringManager.dateOfBirthText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  StatefulBuilder(builder: (context, dateSetState) {
                    return AppTextFiledWithEdit(
                      hintText: StringManager.dateOfBirthText,
                      icon: Icons.date_range_outlined,
                      controller: profileController.dateBirthController,
                      // controller: dateBirthController,
                      onEditTap: () {
                        print('object');
                      },
                      readOnly: true,
                      onTap: () async {
                        final datePicker = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2050));
                        if (datePicker != null) {
                          dateBirthController.text = DateFormat.yMd().format(datePicker);
                          profileController.dateBirthController.text = DateFormat.yMd().format(datePicker);
                        }
                      },
                    );
                  }),
                  verticalSpace(10.h),
                  Row(
                    children: [
                      Flexible(
                          flex: 3,
                          child: AppButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                profileController.updateUser();
                              }
                            },
                            text: StringManager.saveChangesText,
                          )),
                      horizontalSpace(20.w),
                      Flexible(
                          flex: 2,
                          child: AppOutlinedButton(
                            onPressed: () {
                              context.pop();
                            },
                            text: StringManager.cancelText,
                          )),
                    ],
                  )

                  ///
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
