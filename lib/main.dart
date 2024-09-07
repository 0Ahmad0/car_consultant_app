import 'package:car_consultant/core/car_consultant_app.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/routing/app_router.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// To Fix Bug In Text Showing In Release Mode
  await ScreenUtil.ensureScreenSize();
  runApp(CarConsultantApp(
    appRouter: AppRouter(),
  ));
}

