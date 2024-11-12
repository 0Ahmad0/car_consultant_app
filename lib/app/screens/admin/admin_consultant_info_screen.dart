import 'package:car_consultant/core/helpers/get_color_status_appointments.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

import '../../../core/dialogs/delete_user_dialog.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/models/appointment.dart';
import '../../../core/models/user_model.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/color_manager.dart';
import '../../../core/utils/style_manager.dart';
import '../../../core/widgets/app_container_with_shadow.dart';
import '../../../core/widgets/constants_widgets.dart';
import '../../../core/widgets/no_appointments_widget.dart';
import '../../controllers/firebase/firebase_constants.dart';
import '../../controllers/process_controller.dart';

class AdminConsultantInfoScreen extends StatefulWidget {
   AdminConsultantInfoScreen({super.key});

  @override
  State<AdminConsultantInfoScreen> createState() => _AdminConsultantInfoScreenState();
}

class _AdminConsultantInfoScreenState extends State<AdminConsultantInfoScreen> {
  UserModel? provider;
  Appointments appointments=Appointments(items: []);
  var getAppointments;
  getAppointmentsFun() async {
    getAppointments =_fetchAppointmentsStream();
    return getAppointments;
  }
  _fetchAppointmentsStream() {
    final result = FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionAppointment).
    where("idProvider",isEqualTo: provider?.uid).
    where("state",isEqualTo: ColorAppointments.Confirmed.name)
        .limit(5)
        .snapshots();

    return result;
  }
  @override
  void initState() {
    getAppointmentsFun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    provider=args['provider'];
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.consultantInfoText),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppPaddingWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppContainerWithShadow(
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => DeleteUserDialog(),
                              );
                            },
                            child: Icon(Icons.delete_outline),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorManager.whiteColor,
                              radius: 30.sp,
                              child: Image.asset(AssetsManager.consultIMG),
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
                                          provider?.name??'User 14',
                                          style: StyleManager.font12Regular(
                                              color:
                                                  ColorManager.hintTextColor),
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
                                              .format(
                                              provider?.birthDate??
                                              DateTime.now()),
                                          style: StyleManager.font12Regular(
                                              color:
                                                  ColorManager.hintTextColor),
                                        ),
                                        verticalSpace(10.h),
                                        Text(
                                          StringManager.phoneText,
                                          style: StyleManager.font14SemiBold(
                                              color: ColorManager.primaryColor),
                                        ),
                                        Text(
                                          provider?.phoneNumber?? '0501882888',
                                          style: StyleManager.font12Regular(
                                              color:
                                                  ColorManager.hintTextColor),
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
                                          provider?.email?? 'user14@mail.com',
                                          style: StyleManager.font12Regular(
                                              color:
                                                  ColorManager.hintTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(20.h),
                  Text(
                    StringManager.aboutText,
                    style: StyleManager.font16SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppContainerWithShadow(
                    child: Text(
                      provider?.additionalInfo?.about??
                      'Senior Automotive Consultant with over 15 years of experience in the automotive industry.',
                      style: StyleManager.font12Regular(
                          color: ColorManager.hintTextColor),
                    ),
                  ),
                  verticalSpace(20.h),
                  Text(
                    StringManager.expertiseText,
                    style: StyleManager.font16SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppContainerWithShadow(
                    child: Text(
                      provider?.additionalInfo?.expertise??
                      """. Engine diagnostics
. Brake systems
. Electrical and electronic systems""",
                      style: StyleManager.font12Regular(
                          color: ColorManager.hintTextColor),
                    ),
                  ),
                  verticalSpace(20.h),
                  Text(
                    StringManager.latestAppointmentsText,
                    style: StyleManager.font16SemiBold(),
                  ),
                  verticalSpace(10.h),
                ],
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: getAppointments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return   SliverFillRemaining(child:  ConstantsWidgets.circularProgress());
                } else if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasError) {
                    return  SliverFillRemaining(child:SizedBox.shrink()??  Text('Error'));
                  } else if (snapshot.hasData) {
                    SliverFillRemaining(child:   ConstantsWidgets.circularProgress());
                    appointments.items.clear();
                    if (snapshot.data!.docs.length > 0) {

                      appointments.items =
                          Appointments.fromJson(snapshot.data?.docs).items;
                    }
                    return

                      (appointments.items.isEmpty ?? true)
                          ?
                      SliverFillRemaining(child: NoAppointmentsWidget(text: ""))
                          :

                      buildAppointments(context, appointments.items ?? []);
                  } else {
                    return SliverToBoxAdapter(child: const Text('Empty data'));
                  }
                } else {
                  return SliverToBoxAdapter(child: Text('State: ${snapshot.connectionState}'));
                }
              }),
          // SliverList.separated(
          //     itemCount: 4,
          //     itemBuilder: (context, index) => AppPaddingWidget(
          //           verticalPadding: 4,
          //           child: AppContainerWithShadow(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 ListTile(
          //                   dense: true,
          //                   contentPadding: EdgeInsets.zero,
          //                   leading: Icon(Icons.account_circle,size: 60.sp),
          //                   title: Text(
          //                     'User 7',
          //                     style: StyleManager.font14SemiBold(),
          //                   ),
          //                 ),
          //                 verticalSpace(10.h),
          //                 const Divider(
          //                   thickness: .5,
          //                 ),
          //                 Row(
          //                   children: [
          //                     Text(
          //                       StringManager.statusText,
          //                       style: StyleManager.font14SemiBold(
          //                           color: ColorManager.hintTextColor),
          //                     ),
          //                     const Spacer(),
          //                     Container(
          //                       padding: EdgeInsets.symmetric(
          //                           horizontal: 8.w, vertical: 6.h),
          //                       decoration: BoxDecoration(
          //                           color: getColorStatusAppointments(
          //                                   ColorAppointments.Concluded)
          //                               .withOpacity(.15),
          //                           borderRadius: BorderRadius.circular(6.r)),
          //                       child: Text(
          //                         ColorAppointments.Confirmed.name,
          //                         style: StyleManager.font10Regular(
          //                             color: getColorStatusAppointments(
          //                                 ColorAppointments.Confirmed)),
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //                 ListTile(
          //                   contentPadding: EdgeInsets.zero,
          //                   dense: true,
          //                   title: Text(
          //                     StringManager.scheduleText,
          //                     style: StyleManager.font12SemiBold(),
          //                   ),
          //                   subtitle: Text(
          //                     '9:00-9:30 AM ,  ${DateFormat.d().add_yMMM().format(DateTime.now())}',
          //                     style: StyleManager.font12Regular(
          //                         color: ColorManager.hintTextColor),
          //                   ),
          //                   leading: Container(
          //                     padding: EdgeInsets.all(8.sp),
          //                     decoration: BoxDecoration(
          //                         shape: BoxShape.circle,
          //                         border: Border.all(
          //                             color: ColorManager.hintTextColor)),
          //                     child: Icon(Icons.date_range_outlined),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //     separatorBuilder: (_, __) => verticalSpace(10.h))
        ],
      ),
    );
  }
  Widget buildAppointments(BuildContext context,List<Appointment> items){
    return

      SliverList.separated(
          itemCount: items.length,
          itemBuilder: (context, index) => AppPaddingWidget(
            verticalPadding: 4,
            child: AppContainerWithShadow(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.account_circle,size: 60.sp),
                    title:
                    GetBuilder<ProcessController>(
                        builder: (ProcessController processController) {
                          processController.fetchUserAsync(context, idUser: items[index]?.idUser??"");
                          UserModel? provider = processController.fetchLocalUser(idUser: items[index]?.idUser??"");
                          return
                            Text(
                              provider?.name??"Loading ..."??'Consultation',
                              style: StyleManager.font14SemiBold(),
                            );}),

                  ),
                  const Divider(
                    thickness: .5,
                  ),
                  Row(
                    children: [
                      Text(
                        StringManager.statusText,
                        style: StyleManager.font14SemiBold(
                            color: ColorManager.hintTextColor),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 6.h),
                        decoration: BoxDecoration(
                            color: getColorStatusAppointments(
                                ColorAppointments.values.where((_element)=>
                                items[index].state?.toLowerCase().contains(_element.name.toLowerCase())??false)
                                    .firstOrNull?? ColorAppointments.Pending)
                                .withOpacity(.15),
                            borderRadius: BorderRadius.circular(6.r)),
                        child: Text(
                          items[index].state??
                              ColorAppointments.Pending.name,
                          style: StyleManager.font10Regular(
                              color: getColorStatusAppointments(
                                ColorAppointments.values.where((_element)=>
                                items[index].state?.toLowerCase().contains(_element.name.toLowerCase())??false)
                                    .firstOrNull?? ColorAppointments.Pending,
                              )),
                        ),
                      )
                    ],
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      StringManager.scheduleText,
                      style: StyleManager.font12SemiBold(),
                    ),
                    subtitle: Text(
                      '${DateFormat('h:mm').format(
                          items[index]?.fromHour??DateTime.now())}'
                          ' - '
                          '${DateFormat().add_jm().format(
                          items[index]?.toHour??DateTime.now())}, ${DateFormat.d().add_yMMM().format(items[index].selectDate??DateTime.now())}'
                      ,
                      style: StyleManager.font12Regular(
                          color: ColorManager.hintTextColor),
                    ),
                    leading: Container(
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: ColorManager.hintTextColor
                          )
                      ),
                      child: Icon(Icons.date_range_outlined),
                    ),
                  )
                ],
              ),
            ),
          ),
          separatorBuilder: (_, __) => verticalSpace(10.h));

  }
  fetchLocalUser(BuildContext context,String idUser){
    return Get.put(ProcessController()).fetchUser(context, idUser: idUser);
  }
}
