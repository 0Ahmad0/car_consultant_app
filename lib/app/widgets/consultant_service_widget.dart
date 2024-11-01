import 'package:car_consultant/app/widgets/image_consultant_provider.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/models/user_model.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';

class ConsultantServiceWidget extends StatelessWidget {
  const ConsultantServiceWidget({
    super.key,
    required this.index, this.consultantService,
  });

  final int index;
  final UserModel? consultantService;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        context.pushNamed(Routes.detailsConsultantServiceRoute,
            arguments: {'index': index.toString(),'provider':consultantService});
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            Hero(
              tag: index.toString(),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: BorderRadius.circular(8.r)),
                child:
                ImageConsultantProvider(
                  url: consultantService?.photoUrl,
                  width: 100.w,
                )
                // Image.asset(
                //   AssetsManager.consultantServiceIMG,
                //   width: 100.w,
                // ),
              ),
            ),
            horizontalSpace(14.w),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.grade,
                      color: ColorManager.rateStarColor,
                      size: 20.sp,
                    ),
                    horizontalSpace(10.w),
                    Flexible(
                      child: Text(
                        '${consultantService?.additionalInfo?.getRate.toStringAsFixed(1)??4.5}  ( ${consultantService?.additionalInfo?.reviews?.length??'-'} )',

                        // '${4.5}  ( ${84} )',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font12Regular(
                            color: ColorManager.hintTextColor),
                      ),
                    )
                  ],
                ),
                verticalSpace(10.h),
                Flexible(
                  child: Text(
                    consultantService?.name??
                    'Consultant ${index + 1}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font14Bold(),
                  ),
                ),
                verticalSpace(10.h),
                Text(
                  consultantService?.additionalInfo?.workShopName??
                  'Starts From',
                  style: StyleManager.font12Regular(
                    color: ColorManager.hintTextColor,
                  ),
                ),
                verticalSpace(10.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(
                      color: ColorManager.primaryColor,
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Text(
                    '${consultantService?.additionalInfo?.fee??'-'} \$',
                    // '20 \$',
                    style: StyleManager.font12Regular(
                        color: ColorManager.whiteColor),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
