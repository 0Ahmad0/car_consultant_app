import 'package:car_consultant/app/screens/navbar/notification_screen.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../core/models/appointment.dart';
import '../../core/widgets/constants_widgets.dart';
import '../controllers/provider_appointments_controller.dart';
import '../controllers/request_order_controller.dart';
import '../widgets/order_details_section_widget.dart';
import '../widgets/select_date_widget.dart';
import '../widgets/select_time_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int _currentDateIndex = 0;
  int _currentTimeIndex = 0;

  List<TimeHourModel> timeSlots=[];
  List<DateTime> dateSlots=[];
  int? fee;
  late RequestOrderController controller;
  late ProviderAppointmentsController providerController;
  @override
  void initState() {
    controller = Get.put(RequestOrderController());
    controller.onInit();

    fee=int.tryParse(controller.provider?.additionalInfo?.fee??'');
    providerController = Get.put(ProviderAppointmentsController());
    providerController.idProvider=controller.provider?.uid;
    providerController.onInit();
    dateSlots=   providerController.getDateSlots();

    super.initState();
  }
  initData(){

    if(fee==null){
      if(controller.appointment!=null){

        fee= controller.appointment?.fee;
        TimeHourModel? time=   timeSlots.where((_element){

          return   _element.fromTime.hour==controller.appointment?.fromHour?.hour
              &&_element.toTime.hour==(controller.appointment?.toHour?.hour);
        }).firstOrNull;
        _currentTimeIndex=time==null?_currentTimeIndex:timeSlots.indexOf(time);


        DateTime? dateTime=   dateSlots.where((_element){

          return   DateFormat.yMd().tryParse(_element.toString())?.isSameDate(
              DateFormat.yMd().parse(( controller.appointment?.selectDate??DateTime.now()).toString())
             )??false;
        }).firstOrNull;
        _currentDateIndex=dateTime==null?_currentDateIndex:  dateSlots.indexOf(dateTime);

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    // ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // controller.provider=args['provider'];

    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.orderDetailsText),
      ),
      body: SingleChildScrollView(
        child:
        StreamBuilder<QuerySnapshot>(
            stream: providerController.getAppointments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return    ConstantsWidgets.circularProgress();
              } else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return  Text('Error');
                } else if (snapshot.hasData) {
                  ConstantsWidgets.circularProgress();
                  providerController.appointments.items.clear();
                  if (snapshot.data!.docs.length > 0) {

                    providerController.appointments.items =
                        Appointments.fromJson(snapshot.data?.docs).items;
                  }
                  timeSlots=   providerController.getTimeSlots(dateSlots[_currentDateIndex], null, null, providerController.appointments.items);

                  initData();
                  return
                    GetBuilder<ProviderAppointmentsController>(
                        builder: (ProviderAppointmentsController providerAppointmentsController)=>

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OrderDetailsSectionWidget(
                                  fee:fee ,
                                  typeUser: controller.provider?.typeUser,
                                ),
                                verticalSpace(10.h),
                                AppPaddingWidget(
                                  verticalPadding: 0.0,
                                  child: Text(
                                    StringManager.whenDoYouWantServiceText,
                                    style:
                                    StyleManager.font14Bold(color: ColorManager.primaryColor),
                                  ),
                                ),
                                verticalSpace(20.h),
                                AppPaddingWidget(
                                  verticalPadding: 0.0,
                                  child: Text(
                                    StringManager.selectDateText,
                                    style: StyleManager.font16Regular(),
                                  ),
                                ),
                                StatefulBuilder(builder: (context, dateSetState) {

                                  return SizedBox(
                                    height: 100.h,
                                    child: ListView.separated(
                                        padding:
                                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            dateSetState(() {
                                              _currentDateIndex = index;

                                              // timeSlots=   providerController.getTimeSlots(ConstValueManager.dateList[_currentDateIndex], null, null, providerController.appointments.items);
                                              setState(() {
                                              });
                                            });
                                          },
                                          borderRadius: BorderRadius.circular(12.r),
                                          child: SelectDateListWidget(
                                            index: index,
                                            currentIndex: _currentDateIndex,
                                          ),
                                        ),
                                        separatorBuilder: (_, __) => horizontalSpace(10.w),
                                        itemCount: dateSlots.length),
                                  );
                                }),
                                verticalSpace(20.h),
                                AppPaddingWidget(
                                  verticalPadding: 0.0,
                                  child: Text(
                                    StringManager.selectTimeText,
                                    style: StyleManager.font16Regular(),
                                  ),
                                ),
                                buildDates(context),
                                Visibility(
                                  visible: timeSlots[_currentTimeIndex].status!=SelectTimeOrderStatus.book,
                                  child: AppPaddingWidget(child: AppButton(onPressed: (){
                                    if(controller.appointment==null){
                                      controller.appointment=Appointment(
                                        fee: fee,
                                        // selectDate: ConstValueManager.dateList[_currentDateIndex],
                                        selectDate: dateSlots[_currentDateIndex],
                                        fromHour: timeSlots[_currentTimeIndex].fromTime,
                                        toHour: timeSlots[_currentTimeIndex].toTime,
                                      );
                                      context.pushNamed(Routes.paymentOptionRoute);
                                    }else{
                                      controller.appointment?.fee=fee??controller.appointment?.fee;
                                      controller.appointment?.selectDate=_currentDateIndex==null?controller.appointment?.selectDate:dateSlots[_currentDateIndex];
                                      controller.appointment?.fromHour=_currentTimeIndex==null?controller.appointment?.fromHour:timeSlots[_currentTimeIndex].fromTime;
                                      controller.appointment?.toHour=_currentTimeIndex==null?controller.appointment?.toHour:timeSlots[_currentTimeIndex].toTime;
                                      controller.updateAppointment(context);
                                    }

                                  }, text:
                                  controller.appointment!=null?
                                  StringManager.updateAppointmentText:
                                  StringManager.continueToPaymentText

                                  )),
                                )
                              ],
                            ),
                    );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            })



      ),
    );
  }
  Widget buildDates(BuildContext context ){
    return   StatefulBuilder(builder: (context, timeSetState) {
      return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 14.h),
          padding:
          EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          itemBuilder: (context, index) => InkWell(
            onTap: timeSlots[index].status ==
                SelectTimeOrderStatus.book
                ? null
                : () {
              timeSetState(() {
                _currentTimeIndex = index;

                setState(() {});
              });
            },
            borderRadius: BorderRadius.circular(10.r),
            child: SelectTimeListWidget(
              index: index,
              timeHour: timeSlots[index],
              currentIndex: _currentTimeIndex,
            ),
          ),
          itemCount:timeSlots.length
          // itemCount: ConstValueManager.timeList.length
      );
    });

  }

}
