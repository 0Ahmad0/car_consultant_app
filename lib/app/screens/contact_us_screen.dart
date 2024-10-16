import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.contactUsText),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringManager.contactUsTitleText),
              verticalSpace(20.h),
              Row(
                children: [
                  ContactUsShapeWidget(
                    icon: Icons.phone,
                    title: StringManager.callusText,
                    subTitle: StringManager.callusSubTitleText,
                  ),
                  horizontalSpace(20.w),
                  ContactUsShapeWidget(
                    icon: Icons.email_outlined,
                    title: StringManager.emailUsText,
                    subTitle: StringManager.emailUsSubTitleText,
                  ),
                ],
              ),
              verticalSpace(20.h),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AppTextField(
                      hintText: StringManager.enterNameHintText,
                    ),
                    verticalSpace(10.h),
                    AppTextField(
                      hintText: StringManager.enterEmailHintText,
                    ),
                    verticalSpace(10.h),
                    AppTextField(
                      hintText: StringManager.enterPhoneHintText,
                      keyboardType: TextInputType.phone,
                    ),
                    verticalSpace(10.h),
                    AppTextField(
                      isMultiLine: true,
                      hintText: StringManager.messageText,
                      minLine: 4,
                      maxLine: 8,
                    ),
                  ],
                ),
              ),
              verticalSpace(20.h),
              AppButton(onPressed: (){
                if(formKey.currentState!.validate()){

                }
              }, text: StringManager.submitText)
            ],
          ),
        ),
      ),
    );
  }
}

class ContactUsShapeWidget extends StatelessWidget {
  const ContactUsShapeWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  final IconData icon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
                color: ColorManager.shadowColor,
                blurRadius: 10.sp,
                spreadRadius: 2.sp,
                offset: Offset(2.sp, 2.sp))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(10.h),
            CircleAvatar(
              backgroundColor: ColorManager.primaryColor,
              child: Icon(
                icon,
                color: ColorManager.whiteColor,
              ),
            ),
            verticalSpace(10.h),
            Text(
              title,
              style: StyleManager.font14Bold(),
            ),
            verticalSpace(20.h),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style:
                  StyleManager.font14Regular(color: ColorManager.hintTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
