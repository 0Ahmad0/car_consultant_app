import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/models/user_model.dart';
import '../controllers/request_order_controller.dart';
import '../widgets/about_me_and_expertise_widget.dart';
import '../widgets/consultant_details_card_widget.dart';
import '../widgets/rate_consultant_widget.dart';
import '../widgets/starts_text_rate_widget.dart';
import '../widgets/text_rich_details_consultant_widget.dart';

class DetailsConsultantServiceScreen extends StatelessWidget {
   DetailsConsultantServiceScreen({
    super.key,
  });
   UserModel? provider;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    provider=args['provider'];
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.detailsText),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(10.h),
            ConsultantDetailsCardWidget(
              tag: args['index'],
              provider: provider,
            ),
            verticalSpace(10.h),
            RateConsultantWidget(
              provider: provider,
            ),
            verticalSpace(10.h),
            TextRichDetailsConsultant(
              number: provider?.additionalInfo?.reviews?.length??87,
              text: StringManager.reviewsText,
            ),
            verticalSpace(10.h),
            TextRichDetailsConsultant(
              number: 98,
              text: StringManager.ordersCompletedText,
            ),
            verticalSpace(10.h),
            AboutMeAndExpertiseWidget(
              title: StringManager.aboutUsText,
              description:
              provider?.additionalInfo?.about??
                  'Senior Automotive Consultant width over 15 years od experience in the automotive industry',
            ),
            AboutMeAndExpertiseWidget(
              isListFormat: true,
              title: StringManager.expertiseText,
              description:
              provider?.additionalInfo?.expertise??
              ''
                  '* Engin diagnostics and repair'
                  '* Brake Systems'
                  '* Electrical and electronic systems',
            ),
            if(provider?.isServiceProvider??false)...[
              verticalSpace(10.h),
              AboutMeAndExpertiseWidget(
                title: StringManager.locationText,
                description:
                provider?.additionalInfo?.location?.address??
                    '123, Main Street',
              ),
            ],

            AppPaddingWidget(
                child: AppButton(
                    onPressed: () {
                      Get.put(RequestOrderController()).provider=provider;
                      Get.put(RequestOrderController()).appointment=null;
                      context.pushNamed(Routes.orderDetailsRoute,
                          arguments: {'provider':provider});
                    }, text: StringManager.continueText))
          ],
        ),
      ),
    );
  }
}
