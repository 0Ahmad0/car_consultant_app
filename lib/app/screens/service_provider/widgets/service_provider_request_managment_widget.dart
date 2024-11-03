import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/helpers/get_color_status_appointments.dart';
import '../../../../core/models/appointment.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/app_container_with_shadow.dart';
import '../../../../core/widgets/app_padding.dart';
import '../../../controllers/manage_request_appointments_controller.dart';
import '../../../controllers/process_controller.dart';
import '../../../widgets/image_user_provider.dart';

class ServiceProviderRequestManagementWidget extends StatelessWidget {
  const ServiceProviderRequestManagementWidget({
    super.key, this.appointment,
  });
  final Appointment?  appointment;

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      verticalPadding: 0,
      child: AppContainerWithShadow(
        child: Column(
          children: [
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading:
              GetBuilder<ProcessController>(
                  builder: (ProcessController processController) {
                    processController.fetchUserAsync(context, idUser: appointment?.idProvider??'');
                    UserModel? user = processController.fetchLocalUser(idUser: appointment?.idProvider??'');
                    return

                      user?.photoUrl!=null?
                      ImageUserProvider(
                        url: user?.photoUrl,
                        errorBuilder:  Icon(

                          Icons.account_circle_outlined,
                        ),
                      ):
                      CircleAvatar(
                        backgroundColor: ColorManager.whiteColor,
                        child: Icon(
                          Icons.account_circle,
                          size: 44.sp,
                        ),
                      )
                    ;

                  })

             ,
              title:
              fetchName(context,appointment?.idProvider??''),
              // Text(
              //   'User 10',
              //   style: StyleManager.font14SemiBold(),
              // ),
              subtitle: Text(
                'Scheduled a New Appointment',
                style: StyleManager.font12Regular(
                    color: ColorManager.hintTextColor),
              ),
            ),
            const Divider(
              thickness: .5,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              isThreeLine: true,
              leading: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: ColorManager.hintTextColor, width: .5),
                ),
                child: Icon(
                  Icons.date_range_outlined,
                  color: ColorManager.hintTextColor,
                ),
              ),
              subtitle: Text(
                "${DateFormat().add_Hm().format(
                  appointment?.fromHour??DateTime.now(),

                    )} "
                "-"
                " ${DateFormat().add_jm().format(
                  appointment?.toHour??DateTime.now(),
                    )} ,"
                " ${DateFormat.MMMd().format(
                  appointment?.selectDate??DateTime.now(),
                )}",
                style: StyleManager.font12SemiBold(),
              ),
              title: Text(
                StringManager.scheduleAtText,
                style: StyleManager.font12Medium(
                    color: ColorManager.hintTextColor),
              ),
            ),
            const Divider(
              thickness: .5,
            ),
            Row(
              children: [
                Flexible(
                    child: AppButton(
                        onPressed: () {
                          Get.put(ManageRequestAppointmentsController()).acceptOrRejectedRequest(context, ColorAppointments.Confirmed, appointment);
                        }, text: StringManager.acceptText)),
                horizontalSpace(10.w),
                Flexible(
                    child: AppOutlinedButton(
                  onPressed: () {
                    Get.put(ManageRequestAppointmentsController()).acceptOrRejectedRequest(context, ColorAppointments.Canceled, appointment);

                  },
                  text: StringManager.cancelText,
                      color: ColorManager.errorColor,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
  fetchName(BuildContext context,String idUser){
    return Get.put(ProcessController()).widgetNameUser(context, idUser: idUser,style:  StyleManager.font14SemiBold());
  }
}
