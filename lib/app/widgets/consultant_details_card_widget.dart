import 'package:car_consultant/app/widgets/image_consultant_provider.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/models/user_model.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';
import 'image_service_provider.dart';

class ConsultantDetailsCardWidget extends StatelessWidget {
  const ConsultantDetailsCardWidget({
    super.key, required this.tag, this.provider,
  });
  final String tag;
  final UserModel? provider;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration:
      BoxDecoration(color: ColorManager.whiteColor, boxShadow: [
        BoxShadow(
          color: ColorManager.shadowColor.withOpacity(.9),
          blurRadius: 10.sp,
          spreadRadius: 2.sp,
          offset: Offset(2.sp, 2.sp),
        )
      ]),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: tag,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child:
                    AppConstants.collectionServiceProvider==provider?.typeUser?
                ImageServiceProvider(
                  url: provider?.photoUrl,
                  width: 100.w,
                ):
                ImageConsultantProvider(
                  url: provider?.photoUrl,
                  width: 100.w,
                )
                // Image.asset(
                //   AssetsManager.consultantServiceIMG,
                //   width: 100.w,
                // ),
              ),
            ),
            horizontalSpace(10.w),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      provider?.name??
                      'Consultant1',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font16SemiBold(),
                    ),
                    verticalSpace(10.h),
                    Text(
                      provider?.additionalInfo?.workShopName??
                      '3 years in service',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font12Regular(
                          color: ColorManager.hintTextColor),
                    ),
                  ],
                )),
            Visibility(
              visible: false,
              child: IconButton(
                onPressed: () {
                  context.pushNamed(Routes.messagesRoute);
                },
                icon: Icon(Icons.chat),
              ),
            )
          ],
        ),
      ),
    );
  }
}
