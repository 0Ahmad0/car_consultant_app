import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/service_provider_request_managment_widget.dart';

class ServiceProviderManageRequestScreen extends StatelessWidget {
  const ServiceProviderManageRequestScreen({super.key});

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
              itemBuilder: (context,index)=>ServiceProviderRequestManagementWidget(),
              separatorBuilder: (_,__)=> verticalSpace(20.h)
          )
        ],
      ),
    );

  }
}
