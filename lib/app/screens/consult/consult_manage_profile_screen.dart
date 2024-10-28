import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:car_consultant/core/widgets/app_textfield_with_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/string_manager.dart';

class ConsultManageProfile extends StatelessWidget {
  const ConsultManageProfile({super.key});

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
                isMultiLine: true,
                hintText: StringManager.editYourBioText,
                minLine: 4,
                maxLine: 8,
              ),
              verticalSpace(20.h),
              Text(StringManager.availabilityText,style: StyleManager.font16SemiBold(),),
              verticalSpace(10.h),
              AppTextFiledWithEdit(
                readOnly: true,
                isMultiLine: true,
                onTap: (){
                  final picker = showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now()
                  );
                },

                hintText: StringManager.availabilityHintText,
              ),
              verticalSpace(30.h),
              Row(
                children: [
                  Flexible(
                      child: AppButton(
                    onPressed: (){},
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
