import 'package:car_consultant/app/screens/admin/widgets/admin_home_appbar.dart';
import 'package:car_consultant/app/screens/admin/widgets/admin_home_types_button_widget.dart';
import 'package:car_consultant/core/helpers/sizer.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/const_value_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_button.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_search_text_filed.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:car_consultant/core/widgets/app_textfield_with_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'widgets/admin_container_dash_board_widget.dart';
import 'widgets/admin_home_user_ype_container_widget.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  String typeText = '';
  int countText = 350;
  int _currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AdminHomeAppBarWidget(
              text: StringManager.appName,
            ),
            Expanded(
              child: StatefulBuilder(builder: (context, typesSetState) {
                return SingleChildScrollView(
                  child: AppPaddingWidget(
                    verticalPadding: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(10.h),
                        Column(
                          children: [
                            AppSearchTextFiled(),
                            verticalSpace(30.h),
                            AdminContainerDashBoardWidget(
                              typeText: typeText,
                              countText: countText,
                            ),
                            verticalSpace(10.h),
                            Row(
                              children: [
                                AdminHomeTypesButtonWidget(
                                  onTap: () {
                                    typesSetState(() {
                                      _currentIndex = 0;
                                      typeText = ConstValueManager
                                          .adminHomeDashBoardTypes[0];
                                    });
                                  },
                                  text: ConstValueManager
                                      .adminHomeDashBoardTypes[0],
                                  isSelected: _currentIndex == 0,
                                ),
                                AdminHomeTypesButtonWidget(
                                  onTap: () {
                                    typesSetState(() {
                                      _currentIndex = 1;
                                      typeText = ConstValueManager
                                          .adminHomeDashBoardTypes[1];
                                    });
                                  },
                                  text: ConstValueManager
                                      .adminHomeDashBoardTypes[1],
                                  isSelected: _currentIndex == 1,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                AdminHomeTypesButtonWidget(
                                  onTap: () {
                                    typesSetState(() {
                                      _currentIndex = 2;
                                      typeText = ConstValueManager
                                          .adminHomeDashBoardTypes[2];
                                    });
                                  },
                                  text: ConstValueManager
                                      .adminHomeDashBoardTypes[2],
                                  isSelected: _currentIndex == 2,
                                ),
                                AdminHomeTypesButtonWidget(
                                  onTap: () {
                                    typesSetState(() {
                                      _currentIndex = 3;
                                      typeText = ConstValueManager
                                          .adminHomeDashBoardTypes[3];
                                    });
                                  },
                                  text: ConstValueManager
                                      .adminHomeDashBoardTypes[3],
                                  isSelected: _currentIndex == 3,
                                )
                              ],
                            ),
                          ],
                        ),
                        verticalSpace(10.h),
                        ListTile(
                          onTap: () {},
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            StringManager.newAppointmentRequestsText,
                            style: StyleManager.font18SemiBold(),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Text(
                              '${5} ' + StringManager.newRequestText,
                              style: StyleManager.font12Regular(
                                  color: ColorManager.primaryColor),
                            ),
                          ),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            size: 30.sp,
                          ),
                        ),
                        verticalSpace(10.h),
                        Text(
                          StringManager.newText +
                              ' ' +
                              typeText +
                              ' ' +
                              StringManager.requestsText,
                          style: StyleManager.font16SemiBold(),
                        ),
                        verticalSpace(10.h),
                        Column(
                          children: List.generate(
                              6,
                              (index) => AdminHomeUserTypeContainerWidget(
                                    typeText: typeText,
                                  )),
                        ),
                        verticalSpace(10.h),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
