import 'package:car_consultant/app/screens/admin/admin_appointments_info_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_appointments_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_consultant_info_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_home_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_navbar_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_provider_info_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_user_info_screen.dart';
import 'package:car_consultant/app/screens/admin/admin_users_screen.dart';
import 'package:car_consultant/app/screens/become_service_provider_screen.dart';
import 'package:car_consultant/app/screens/consult/consult_control_panel_screen.dart';
import 'package:car_consultant/app/screens/consultant_service_screen.dart';
import 'package:car_consultant/app/screens/details_consultant_service_screen.dart';
import 'package:car_consultant/app/screens/emergency_services_screen.dart';
import 'package:car_consultant/app/screens/navbar/appointments_screen.dart';
import 'package:car_consultant/app/screens/navbar/home_screen.dart';
import 'package:car_consultant/app/screens/navbar/messages_screen.dart';
import 'package:car_consultant/app/screens/navbar/navbar_screen.dart';
import 'package:car_consultant/app/screens/navbar/profile_screen.dart';
import 'package:car_consultant/app/screens/opportunities_screen.dart';
import 'package:car_consultant/app/screens/order_details_screen.dart';
import 'package:car_consultant/app/screens/payment_invoice_screen.dart';
import 'package:car_consultant/app/screens/payment_option_screen.dart';
import 'package:car_consultant/app/screens/personal_information_screen.dart';
import 'package:car_consultant/app/screens/review_screen.dart';
import 'package:car_consultant/app/screens/service_provider_screen.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:car_consultant/core/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/controllers/profile_controller.dart';
import 'app/screens/service_provider/service_provider_manage_appointments_screen.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/utils/color_manager.dart';
import 'core/utils/const_value_manager.dart';

class CarConsultantApp extends StatelessWidget {
  const CarConsultantApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(
          ConstValueManager.widthSize,
          ConstValueManager.heightSize,
        ),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringManager.appName,
            theme: ThemeData(
              dividerColor: ColorManager.hintTextColor,
              primaryColor: ColorManager.primaryColor,
              primarySwatch: ColorManager.primaryColor.toMaterialColor(),
              colorScheme: ColorScheme.fromSeed(
                seedColor: ColorManager.primaryColor,
              ),
              appBarTheme: AppBarTheme(
                centerTitle: true,
                titleTextStyle: StyleManager.font18Medium(),
                backgroundColor: ColorManager.whiteColor,
                elevation: 0.0,
              ),
              tabBarTheme: TabBarTheme(
                labelColor: ColorManager.whiteColor,
                indicatorSize: TabBarIndicatorSize.tab,
                overlayColor: MaterialStateProperty.all(
                    ColorManager.primaryColor.withOpacity(.1)),
                unselectedLabelColor: ColorManager.primaryColor,
                indicator: BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              inputDecorationTheme: InputDecorationTheme(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                suffixIconColor: ColorManager.primaryColor,
              ),
              scaffoldBackgroundColor: ColorManager.whiteColor,
              fontFamily: GoogleFonts.poppins().fontFamily,
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    double.maxFinite,
                    ConstValueManager.heightButtonSize,
                  ),
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: ColorManager.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),

                )
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                double.maxFinite,
                ConstValueManager.heightButtonSize,
              ))),
            ),
            // home: MessagesScreen(),
            initialRoute: Routes.initialRoute,
            onGenerateRoute: appRouter.generateRoute,
            routes: {
              Routes.consultantServiceRoute: (_) => ConsultantServiceScreen(),
              Routes.detailsConsultantServiceRoute: (_) =>
                  DetailsConsultantServiceScreen(),
              Routes.paymentOptionRoute: (_) => PaymentOptionScreen(),
              Routes.paymentInvoiceRoute: (_) => PaymentInvoiceScreen(),
              Routes.adminAppointmentsRoute: (_) => AdminAppointmentsScreen(),
              Routes.adminAppointmentsInfoRoute: (_) => AdminAppointmentsInfoScreen(),
              Routes.adminUsersRoute: (_) => AdminUsersScreen(),
              Routes.adminUserInfoRoute: (_) => AdminUserInfoScreen(),
              Routes.adminConsultantInfoRoute: (_) => AdminConsultantInfoScreen(),
              Routes.adminProviderInfoRoute: (_) => AdminProviderInfoScreen(),
              Routes.opportunitiesRoute: (_) => OpportunitiesScreen(),
              Routes.orderDetailsRoute: (_) => OrderDetailsScreen(),
              Routes.serviceProviderManageAppointmentsRoute: (_) => ServiceProviderManageAppointmentsScreen(),

            },
          );
        });
  }
}
