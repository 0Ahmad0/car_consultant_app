import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/request_order_controller.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final rateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int currentRating = 1;
  @override
  void dispose() {
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    currentRating=Get.put(RequestOrderController()).appointment?.review?.timeScaleReview?.toInt()??currentRating;
    rateController.text=Get.put(RequestOrderController()).appointment?.review?.text??  rateController.text;
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
                      verticalSpace(20.h),
                      StatefulBuilder(
                        builder: (context,rateSetState) {
                          return EmojiFeedback(
                            rating: currentRating,
                            animDuration: const Duration(milliseconds: 300),
                            curve: Curves.bounceIn
                            ,
                            inactiveElementScale: .75,
                            onChanged: (value) {
                              rateSetState((){
                              currentRating = value!;

                              });
                            },

                          );
                        }
                      ),
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
                if (formKey.currentState!.validate()) {
                  Get.put(RequestOrderController()).addReview(context, rate: currentRating,text:   rateController.value.text);
                }
              },
              text: StringManager.submitText,
            )
          ],
        ),
      ),
    );
  }
}
