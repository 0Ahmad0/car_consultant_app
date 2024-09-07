import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'routing/app_router.dart';
import 'routing/routes.dart';
import 'utils/color_manager.dart';
import 'utils/const_value_manager.dart';

class CarConsultantApp extends StatelessWidget {
  const CarConsultantApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(
            ConstValueManager.widthSize, ConstValueManager.heightSize),
        builder: (context, child) {
          return MaterialApp(
            title: StringManager.appName,
            theme: ThemeData(

                primaryColor: ColorManager.primaryColor,
                primarySwatch: ColorManager.primaryColor.toMaterialColor(),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: ColorManager.primaryColor,
                ),
                scaffoldBackgroundColor: ColorManager.whiteColor,
                fontFamily: GoogleFonts.poppins().fontFamily,
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                  double.maxFinite,
                  ConstValueManager.heightButtonSize,
                )))),
            initialRoute: Routes.initialRoute,
            onGenerateRoute: appRouter.generateRoute,
          );
        });
  }
}
