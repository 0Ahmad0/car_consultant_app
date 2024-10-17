import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final rateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringManager.reviewText,
        ),
      ),
      body: AppPaddingWidget(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringManager.rateYourExperienceText,
                        style: StyleManager.font16SemiBold(),
                      ),
                      verticalSpace(10.h),
                      verticalSpace(20.h),
                      Form(
                        key: formKey,
                        child: AppTextField(
                          controller: rateController,
                          minLine: 4,
                          maxLine: 8,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          isMultiLine: true,
                          hintText: StringManager.writeYourReviewText,
                        ),
                      ),
                      verticalSpace(20.h),
                      Text(
                        StringManager.pleaseEnsureYourReviewText,
                        textAlign: TextAlign.center,
                        style: StyleManager.font14Regular(
                            color: ColorManager.hintTextColor),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            verticalSpace(20.h),
            AppButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              },
              text: StringManager.submitText,
            )
          ],
        ),
      ),
    );
  }
}
