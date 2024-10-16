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
import 'package:intl/intl.dart';

import '../../core/widgets/app_textfield_with_edit.dart';

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
              child: CircleAvatar(
                radius: 54.sp,
                child: Icon(Icons.person),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  StringManager.changeProfilePhotoText,
                  style: StyleManager.font12Regular(
                      color: ColorManager.primaryColor),
                ),
              ),
            ),
            verticalSpace(20.h),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringManager.firstNameText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppTextFiledWithEdit(
                    hintText: StringManager.firstNameText,
                    icon: Icons.person,
                    controller: firstNameController,
                    onEditTap: () {
                      print('object');
                    },
                  ),
                  verticalSpace(20.h),

                  ///
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
                  verticalSpace(20.h),

                  ///
                  Text(
                    StringManager.name,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppTextFiledWithEdit(
                    hintText: StringManager.emailAddressText,
                    icon: Icons.email,
                    controller: emailController,
                    onEditTap: () {
                      print('object');
                    },
                  ),
                  verticalSpace(20.h),

                  ///
                  Text(
                    StringManager.phoneNumberText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppTextFiledWithEdit(
                    hintText: StringManager.phoneNumberText,
                    icon: Icons.phone_android,
                    controller: phoneController,
                    onEditTap: () {
                      print('object');
                    },
                  ),
                  verticalSpace(20.h),

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
                      controller: dateBirthController,
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
                          dateBirthController.text =
                              DateFormat.yMd().format(datePicker);
                        }
                      },
                    );
                  }),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      Flexible(
                          flex: 3,
                          child: AppButton(
                            onPressed: () {
                              if(formKey.currentState!.validate()){

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
