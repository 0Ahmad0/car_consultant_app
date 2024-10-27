import 'package:car_consultant/core/helpers/spacing.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:car_consultant/core/widgets/app_container_with_shadow.dart';
import 'package:car_consultant/core/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/educational_content_widget.dart';
import '../widgets/emergency_content_widget.dart';

class EmergencyServicesScreen extends StatelessWidget {
  const EmergencyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.emergencyServicesText),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppPaddingWidget(
              child: Text(
                StringManager.emergencyServicesContentText,
                style: StyleManager.font16Regular(),
              ),
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) => EmergencyContentWidget(),
            separatorBuilder: (_, __) => verticalSpace(20.h),
            itemCount: 2,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppPaddingWidget(
                  child: Text(
                    StringManager.urgentServicesText,
                    style: StyleManager.font16Regular(),
                  ),
                ),
                AppPaddingWidget(
                  verticalPadding: 0,
                  child: AppContainerWithShadow(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius: BorderRadius.circular(8.r)
                        ),
                        child: Image.asset(
                          AssetsManager.supportIMG,
                        ),
                      ),
                      title: Text(StringManager.urgentSupportTeamText,style: StyleManager.font14SemiBold(),),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Text(StringManager.getHelpSupportTeamText,style: StyleManager.font12Regular(
                          color: ColorManager.hintTextColor
                        ),),
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: ColorManager.primaryColor,
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.call,color: ColorManager.whiteColor,),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
