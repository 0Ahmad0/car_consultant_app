import 'dart:developer';

import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:car_consultant/core/widgets/app_textfield.dart';
import 'package:car_consultant/core/widgets/custome_back_button.dart';
import 'package:car_consultant/core/widgets/no_data_found_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/color_manager.dart';

var _borderTextFiled = ({Color color = ColorManager.primaryColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: color));

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          context.pushNamed(Routes.aiBotRoute);
        },
        child: Padding(
          padding:  EdgeInsets.all(8.sp),
          child: Image.asset(
            AssetsManager.aiBotIMG,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          StringManager.messageText,
        ),
      ),
      body: true
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppPaddingWidget(
                  child: TextField(
                    onSubmitted: (value) {
                      log('${value}');
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorManager.grayColor,
                        border: _borderTextFiled(),
                        focusedBorder:
                            _borderTextFiled(color: ColorManager.primaryColor),
                        enabledBorder:
                            _borderTextFiled(color: ColorManager.hintTextColor),
                        hintText: StringManager.searchMessageText,
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        )),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (_, __) => Divider(
                      height: 0.0,
                      thickness: .5,
                    ),
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        context.pushNamed(Routes.chatRoute);
                      },
                      isThreeLine: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.h, vertical: 4.h),
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.account_circle_outlined,
                        ),
                      ),
                      trailing: Text(
                        DateFormat().add_jm().format(DateTime.now()),
                        style: StyleManager.font10Regular(
                            color: ColorManager.blackColor),
                      ),
                      title: Text('Consultant ${index + 1}'),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Text(
                          'Yes, the work is all done',
                          style: StyleManager.font12Regular(
                              color: ColorManager.hintTextColor),
                        ),
                      ),
                    ),
                    itemCount: 10,
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsManager.noMessagesIMG,
                  width: 140.w,
                  height: 140.h,
                ),
                verticalSpace(30.h),
                Text(
                  StringManager.noMessageYetText,
                  textAlign: TextAlign.center,
                  style: StyleManager.font18Medium(
                      color: ColorManager.primaryColor),
                ),
                verticalSpace(20.h),
                Text(
                  StringManager.startChatText,
                  textAlign: TextAlign.center,
                  style: StyleManager.font12Regular(
                      color: ColorManager.hintTextColor),
                ),
              ],
            ),
    );
  }
}
