import 'dart:ffi';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
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
import 'package:intl/intl.dart';

import '../../../core/enums/enums.dart';
import '../../../core/helpers/operation_file.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/app_container_with_shadow.dart';
import '../../controllers/admin/manage_requests_provider_controller.dart';
import 'widgets/request_info_list_tile_widget.dart';

class RequestInfoScreen extends StatelessWidget {
   RequestInfoScreen({super.key});
  UserModel? provider;
  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    provider=args['user'];
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.requestsInfoText),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringManager.userInformationText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              AppContainerWithShadow(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32.sp,
                    ),
                    horizontalSpace(10.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              RequestInfoListTileWidget(
                                title: StringManager.name,
                                subTitle:provider?.name?? 'User 18',
                              ),
                              RequestInfoListTileWidget(
                                title: StringManager.phoneText,
                                subTitle:provider?.phoneNumber?? '0501234567',
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              RequestInfoListTileWidget(
                                title: StringManager.dateOfBirthText,
                                subTitle: DateFormat.d()
                                    .add_yMMM()
                                    .format(
                                    provider?.birthDate??
                                    DateTime.now()),
                              ),
                              RequestInfoListTileWidget(
                                title: StringManager.emailText,
                                subTitle:provider?.email?? 'user18@mail.com',
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              verticalSpace(20.h),
              Text(
                StringManager.applicantInformationText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              AppContainerWithShadow(
                child:

                Text(
                  provider?.additionalInfo?.workShopName?? "",
                  textAlign: TextAlign.start,
                  style: StyleManager.font12Regular(
                    color: ColorManager.hintTextColor,
                  ).copyWith(height: 1.6),
                ),
              ),
              verticalSpace(20.h),
              Text(
                StringManager.personalBioText,
                style: StyleManager.font16SemiBold(),
              ),
              verticalSpace(10.h),
              AppContainerWithShadow(
                child:

                Text(
                  provider?.additionalInfo?.about??
                  """User 18 is an experienced automotive consultant with over 8 years of expertise in car maintenance, diagnostics, and repair consultations. He has worked with various brands and models, providing clients with insights on improving vehicle performance and resolving complex issues. His goal is to assist car owners in making informed decisions about vehicle care, ensuring long-term reliability and cost-efficiency.""",
                  textAlign: TextAlign.start,
                  style: StyleManager.font12Regular(
                    color: ColorManager.hintTextColor,
                  ).copyWith(height: 1.6),
                ),
              ),
              verticalSpace(20.h),
              Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(

                      StringManager.uploadedFilesText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppContainerWithShadow(
                      child: Wrap(
                        spacing: 20.w,
                        children:
                        (provider?.additionalInfo?.files??[])
                        // [File('1'), File('2'), File('3')]
                            .map((e) => FadeInUp(
                                key: UniqueKey(),
                                child: Column(
                                  children: [
                                    ("pdf"==e.subType)?
                                    Image.asset(
                                      AssetsManager.pdfIcon,
                                      width: 60.w,
                                      height: 60.w,
                                    ):
                                    Icon(
                                      size: 60.w,
                                      getFileIcon(
                                getFileType(e.subType).name),),

                                    verticalSpace(2.h),
                                    SizedBox(
                                      width: 70.w,
                                      child: Text(
                                        e.name??
                                        'name_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_filename_file',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: StyleManager.font10Regular(),
                                      ),
                                    )
                                  ],
                                )))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(20.h),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: AppButton(
                      onPressed: (){

                        Get.put(ManageRequestsProviderController()).acceptOrRejectedRequest(context, AccountRequestStatus.Accepted, provider);

                      },
                      text: StringManager.acceptText,
                    ),
                  ),
                  horizontalSpace(10.w),
                  Flexible(
                    child: AppOutlinedButton(
                      onPressed: (){
                        Get.put(ManageRequestsProviderController()).acceptOrRejectedRequest(context, AccountRequestStatus.Rejected, provider);

                      },
                      text: StringManager.rejectText,
                      color: ColorManager.errorColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
