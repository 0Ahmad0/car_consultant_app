import 'package:car_consultant/core/helpers/get_color_status_appointments.dart';
import 'package:car_consultant/core/models/appointment.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/models/user_model.dart';
import '../../../controllers/process_controller.dart';
import '../../../widgets/image_user_provider.dart';

class UpcomingItemWidget extends StatelessWidget {
  const UpcomingItemWidget({super.key, required this.status, required this.appointment});

  final ColorAppointments status;
  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title:

            fetchName(context,appointment?.idProvider??''),
            // Text(
            //   'Consultant 1',
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            //   style:
            //       StyleManager.font16SemiBold(color: ColorManager.blackColor),
            // ),
            leading: Container(
              width: 50.w,
              height: 50.w,
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child:    GetBuilder<ProcessController>(
                  builder: (ProcessController processController) {
                    processController.fetchUserAsync(context, idUser: appointment?.idProvider??'');
                    UserModel? user = processController.fetchLocalUser(idUser: appointment?.idProvider??'');
                    return

                      user?.typeUser==AccountType.User.name?
                      ImageUserProvider(
                        url: user?.photoUrl,
                        errorBuilder:  Icon(

                          Icons.account_circle_outlined,
                        ),
                      ):
                      Image.asset(AssetsManager.consultantServiceIMG)
                    ;

                  }),
            ),
            trailing: status == ColorAppointments.Pending
                ? IconButton(
                    onPressed: () {}, icon: Icon(Icons.location_on_outlined))
                : null,
          ),
          const Divider(
            thickness: .5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StringManager.statusText,
                style:
                    StyleManager.font14Bold(color: ColorManager.hintTextColor),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: getColorStatusAppointments(status).withOpacity(.175),
                ),
                child: Text(
                  status.name,
                  style: StyleManager.font14SemiBold(
                      color: getColorStatusAppointments(status)),
                ),
              )
            ],
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
            title: Text(
              "${

                  DateFormat('h:mm').format(
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
            subtitle: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                StringManager.scheduleText,
                style: StyleManager.font12Medium(
                    color: ColorManager.hintTextColor),
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.date_range,
                  ),
                  PositionedDirectional(
                    bottom: -6.h,
                    end: -6.w,
                    child: CircleAvatar(
                      backgroundColor: ColorManager.whiteColor,
                      radius: 8.sp,
                      child: Icon(
                        Icons.refresh,
                        size: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  fetchName(BuildContext context,String idUser){
    return Get.put(ProcessController()).widgetNameUser(context, idUser: idUser);
  }
}
