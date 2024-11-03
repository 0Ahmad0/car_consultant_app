import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:car_consultant/core/widgets/app_textfield_with_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/string_manager.dart';
import '../../controllers/profile_controller.dart';

class ServiceProviderManageProfile extends StatefulWidget {
  const ServiceProviderManageProfile({super.key});

  @override
  State<ServiceProviderManageProfile> createState() => _ServiceProviderManageProfileState();
}

class _ServiceProviderManageProfileState extends State<ServiceProviderManageProfile> {
  late  ProfileController profileController;
  final aboutController = TextEditingController();
  DateTime? availabilityFrom;
  DateTime? availabilityTo;
  @override
  void initState() {
    profileController = Get.put(ProfileController());
    profileController.refresh();
    availabilityFrom=profileController.currentUser.value?.additionalInfo?.availabilityFrom;
    availabilityTo=profileController.currentUser.value?.additionalInfo?.availabilityTo;
    aboutController.text=profileController.currentUser.value?.additionalInfo?.about??'';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.manageProfileTitleText),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringManager.aboutMeText,style: StyleManager.font16SemiBold(),),
              verticalSpace(10.h),
              AppTextFiledWithEdit(
                controller: aboutController,
                isMultiLine: true,
                hintText: StringManager.editYourBioText,
                minLine: 4,
                maxLine: 8,
              ),
              verticalSpace(20.h),
              Text(StringManager.availabilityText,style: StyleManager.font16SemiBold(),),
              verticalSpace(10.h),
              Row(
                children: [
                  Flexible(
                    child: AppTextFiledWithEdit(
                      readOnly: true,
                      isMultiLine: true,
                      controller: TextEditingController(text: availabilityFrom==null?null:TimeOfDay.fromDateTime(availabilityFrom!).format(context)),
                      onTap: () async {
                        final picker =await showTimePicker(
                            context: context,
                            initialTime: availabilityFrom!=null?TimeOfDay.fromDateTime(availabilityFrom!):TimeOfDay.now()
                        );

                        if(picker!=null)
                          setState(() {
                            availabilityFrom=DateTime.now().copyWith(hour:picker!.hour ,minute:picker!.minute );
                            if(availabilityTo!=null&& (availabilityFrom?.isAfter(availabilityTo!)??false))
                              availabilityTo=null;
                          });
                      },
                      hintText: StringManager.availabilityHintFromText,
                    ),
                  ),
                  horizontalSpace(10.w),
                  Text(StringManager.to+" ➟",style: StyleManager.font16SemiBold(),),
                  horizontalSpace(10.w),
                  Flexible(
                    child: AppTextFiledWithEdit(
                      readOnly: true,
                      isMultiLine: true,
                      controller: TextEditingController(text: availabilityTo==null?null:TimeOfDay.fromDateTime(availabilityTo!).format(context)),
                      onTap: () async {
                        final picker =await showTimePicker(
                            context: context,
                            initialTime: availabilityTo!=null?TimeOfDay.fromDateTime(availabilityTo!):TimeOfDay.now()
                        );

                        if(picker!=null)
                          setState(() {
                            availabilityTo=DateTime.now().copyWith(hour:picker!.hour ,minute:picker!.minute );
                            if(availabilityFrom!=null&& (availabilityTo?.isBefore(availabilityFrom!)??false))
                              availabilityFrom=null;
                          });
                      },
                      hintText: StringManager.availabilityHintToText,
                    ),
                  ),
                ],
              ),
              verticalSpace(30.h),
              Row(
                children: [
                  Flexible(
                      child: AppButton(
                        onPressed: (){
                          profileController.updateAdditionalInfo(
                            about: aboutController.value.text,
                            availabilityFrom: availabilityFrom,
                            availabilityTo: availabilityTo
                          );
                        },
                        text: StringManager.saveChangesText,
                      )),
                  horizontalSpace(10.w),
                  Flexible(
                      child: AppOutlinedButton(
                        onPressed: (){
                          context.pop();
                        },
                        text: StringManager.cancelText,
                      )),
                ],
              )

            ],
          ),
        ),
      ),
    );

  }
}
