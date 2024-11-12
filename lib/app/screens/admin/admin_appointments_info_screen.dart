import 'package:car_consultant/core/helpers/get_color_status_appointments.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/models/appointment.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_container_with_shadow.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../core/models/user_model.dart';
import '../../../core/widgets/constants_widgets.dart';
import '../../controllers/process_controller.dart';

class AdminAppointmentsInfoScreen extends StatelessWidget {
   AdminAppointmentsInfoScreen({super.key});
  Appointment? appointment;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    appointment=args["appointment"];
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.appointmentInfoText),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: AppPaddingWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringManager.appointmentInformationText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppContainerWithShadow(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringManager.dateText,
                                  style: StyleManager.font14SemiBold(
                                      color: ColorManager.primaryColor),
                                ),
                                Text(
                                  DateFormat.d()
                                      .add_yMMM()
                                      .format(appointment?.selectDate??DateTime.now()),
                                  style: StyleManager.font12Regular(
                                      color: ColorManager.hintTextColor),
                                ),
                                verticalSpace(10.h),
                                Text(
                                  StringManager.timeText,
                                  style: StyleManager.font14SemiBold(
                                      color: ColorManager.primaryColor),
                                ),
                                Text(
                                  '${DateFormat('h:mm').format(
                                     appointment?.fromHour??DateTime.now())}'
                                  // ConstValueManager.timeList[index].fromTime)}'
                                      ' - '
                                      '${DateFormat().add_jm().format(
                                      appointment?.toHour??DateTime.now())}',
                                  // '9:00-9:30 AM',
                                  style: StyleManager.font12Regular(
                                      color: ColorManager.hintTextColor),
                                ),
                                verticalSpace(10.h),
                                Text(
                                  StringManager.paymentText,
                                  style: StyleManager.font14SemiBold(
                                      color: ColorManager.primaryColor),
                                ),
                                Text(
                                  'Done',
                                  style: StyleManager.font12Regular(
                                      color: ColorManager.hintTextColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringManager.typeText,
                                  style: StyleManager.font14SemiBold(
                                      color: ColorManager.primaryColor),
                                ),
                                GetBuilder<ProcessController>(
                                    builder: (ProcessController processController) {
                                      processController.fetchUserAsync(context, idUser: appointment?.idProvider??"");
                                      UserModel? provider = processController.fetchLocalUser(idUser: appointment?.idProvider??"");
                                      return
                                        Text(
                                          provider?.typeUser?.replaceFirst("Provider", "")??"Loading ..."??'Consultation',
                                          style: StyleManager.font12Regular(
                                              color: ColorManager.hintTextColor),
                                        );}),
                                verticalSpace(10.h),
                                Text(
                                  StringManager.statusText,
                                  style: StyleManager.font14SemiBold(
                                      color: ColorManager.primaryColor),
                                ),
                                Text(
                                  args['status'],
                                  style: StyleManager.font12Regular(
                                      color: ColorManager.hintTextColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(20.h),
                    Text(
                      StringManager.appointmentSetByText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppContainerWithShadow(
                      child:
                      GetBuilder<ProcessController>(
                          builder: (ProcessController processController) {
                            processController.fetchUserAsync(context, idUser: appointment?.idUser??"");
                            UserModel? user = processController.fetchLocalUser(idUser: appointment?.idUser??"");
                            return
                              (user==null)?
                              ConstantsWidgets.circularProgress()
                                  :
                              Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: ColorManager.whiteColor,
                                  radius: 30.sp,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 60.sp,
                                  ),
                                ),
                                horizontalSpace(20.w),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              StringManager.nameText,
                                              style: StyleManager.font14SemiBold(
                                                  color: ColorManager.primaryColor),
                                            ),
                                            Text(
                                              user?.name?? 'User 14',
                                              style: StyleManager.font12Regular(
                                                  color: ColorManager.hintTextColor),
                                            ),
                                            verticalSpace(10.h),
                                            Text(
                                              StringManager.dateOfBirthText,
                                              style: StyleManager.font14SemiBold(
                                                  color: ColorManager.primaryColor),
                                            ),
                                            Text(
                                              DateFormat.d()
                                                  .add_yMMM()
                                                  .format( user?.birthDate??DateTime.now()),
                                              style: StyleManager.font12Regular(
                                                  color: ColorManager.hintTextColor),
                                            ),
                                            verticalSpace(10.h),
                                            Text(
                                              StringManager.phoneText,
                                              style: StyleManager.font14SemiBold(
                                                  color: ColorManager.primaryColor),
                                            ),
                                            Text(
                                              user?.phoneNumber?? '0501882888',
                                              style: StyleManager.font12Regular(
                                                  color: ColorManager.hintTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              StringManager.emailText,
                                              style: StyleManager.font14SemiBold(
                                                  color: ColorManager.primaryColor),
                                            ),
                                            Text(
                                              user?.email??'user14@mail.com',
                                              style: StyleManager.font12Regular(
                                                  color: ColorManager.hintTextColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );}),
                    ),
                    verticalSpace(20.h),
                    Text(
                      StringManager.appointmentSetWithText,
                      style: StyleManager.font16SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppContainerWithShadow(
                      child:
                      GetBuilder<ProcessController>(
                      builder: (ProcessController processController) {
      processController.fetchUserAsync(context, idUser: appointment?.idProvider??"");
      UserModel? provider = processController.fetchLocalUser(idUser: appointment?.idProvider??"");
      return
        (provider==null)?
        ConstantsWidgets.circularProgress()
            :
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: ColorManager.whiteColor,
                            radius: 30.sp,
                            child: Image.asset(
                              AssetsManager.consultIMG,
                            ),
                          ),
                          horizontalSpace(20.w),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringManager.nameText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        provider.name??'User 14',
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                      verticalSpace(10.h),
                                      Text(
                                        StringManager.dateOfBirthText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        DateFormat.d()
                                            .add_yMMM()
                                            .format(provider.birthDate??DateTime.now()),
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                      verticalSpace(10.h),
                                      Text(
                                        StringManager.phoneText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        provider.phoneNumber??'0501882888',
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringManager.emailText,
                                        style: StyleManager.font14SemiBold(
                                            color: ColorManager.primaryColor),
                                      ),
                                      Text(
                                        provider.email??'user14@mail.com',
                                        style: StyleManager.font12Regular(
                                            color: ColorManager.hintTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );}),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible:false&& args['status'] == ColorAppointments.Pending.name,
            child: AppPaddingWidget(
                child: AppButton(
                    onPressed: () {}, text: StringManager.confirmPaymentText)),
          )
        ],
      ),
    );
  }
   fetchLocalUser(BuildContext context,String idUser){
     return Get.put(ProcessController()).fetchUser(context, idUser: idUser);
   }
}
