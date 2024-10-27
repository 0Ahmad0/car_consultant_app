import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.orderDetailsText),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderDetailsSectionWidget(),
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
                            });
                          },
                          borderRadius: BorderRadius.circular(12.r),
                          child: SelectDateListWidget(
                            index: index,
                            currentIndex: _currentDateIndex,
                          ),
                        ),
                    separatorBuilder: (_, __) => horizontalSpace(10.w),
                    itemCount: ConstValueManager.dateList.length),
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
            StatefulBuilder(builder: (context, timeSetState) {
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
                        onTap: ConstValueManager.timeList[index].status ==
                                SelectTimeOrderStatus.book
                            ? null
                            : () {
                                timeSetState(() {
                                  _currentTimeIndex = index;
                                });
                              },
                        borderRadius: BorderRadius.circular(10.r),
                        child: SelectTimeListWidget(
                          index: index,
                          currentIndex: _currentTimeIndex,
                        ),
                      ),
                  itemCount: ConstValueManager.timeList.length);
            }),
            AppPaddingWidget(child: AppButton(onPressed: (){
              context.pushNamed(Routes.paymentOptionRoute);
            }, text: StringManager.continueToPaymentText ))
          ],
        ),
      ),
    );
  }
}
