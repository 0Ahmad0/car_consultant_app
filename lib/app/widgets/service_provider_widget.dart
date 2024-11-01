import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/sizer.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/models/user_model.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';
import 'image_service_provider.dart';

class ServiceProviderWidget extends StatelessWidget {
  const ServiceProviderWidget({
    super.key,
    required this.index, this.serviceProvider,
  });

  final int index;
  final UserModel? serviceProvider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        context.pushNamed(Routes.detailsConsultantServiceRoute,
            arguments: {'index': index.toString(),'provider':serviceProvider});
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
                ImageServiceProvider(
                  url: serviceProvider?.photoUrl,
                  width: 100.w,
                )
                // Image.asset(
                //   AssetsManager.providerIMG,
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
                        '${serviceProvider?.additionalInfo?.getRate.toStringAsFixed(1)??4.5}  ( ${serviceProvider?.additionalInfo?.reviews?.length??'-'} )',
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
                    serviceProvider?.name??
                    'Service Provider ${index + 1}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font14Bold(),
                  ),
                ),
                verticalSpace(10.h),
                Text(
                  serviceProvider?.additionalInfo?.workShopName??
                  'Starts From',
                  style: StyleManager.font12Regular(
                    color: ColorManager.hintTextColor,
                  ),
                ),
                verticalSpace(10.h),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                        decoration: BoxDecoration(
                            color: ColorManager.primaryColor,
                            borderRadius: BorderRadius.circular(4.r)),
                        child: Text(
                          '${serviceProvider?.additionalInfo?.fee??'-'} \$',
                          // '20 \$',
                          style: StyleManager.font12Regular(
                              color: ColorManager.whiteColor),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 18.sp,
                            color: ColorManager.primaryColor,
                          ),
                          SizedBox(
                            width: getWidth(context) / 2.75 ,
                            child: Text(
                              '${3.8} ' + StringManager.kmFromLocation,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: StyleManager.font12Regular(),
                            ),
                          )
                        ],
                      )
                    ],
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
