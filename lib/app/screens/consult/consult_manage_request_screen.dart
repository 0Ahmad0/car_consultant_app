import 'package:car_consultant/app/screens/consult/widgets/consult_request_managment_widget.dart';
import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_container_with_shadow.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsultManageRequestScreen extends StatelessWidget {
  const ConsultManageRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.manageRequestTitleText),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppPaddingWidget(
              child: Text(StringManager.appointmentRequestsText),
            ),
          ),
          SliverList.separated(
              itemBuilder: (context,index)=>ConsultRequestManagementWidget(),
              separatorBuilder: (_,__)=> verticalSpace(20.h)
          )
        ],
      ),
    );
  }
}

