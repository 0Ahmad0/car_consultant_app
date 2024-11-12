import 'package:car_consultant/car_consultant_app.dart';
import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/routing/app_router.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'core/routing/routes.dart';
import 'core/utils/const_value_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// To Init Firebase
  await Firebase.initializeApp();
  Gemini.init(apiKey: ConstValueManager.geminiApi);

  /// To Fix Bug In Text Showing In Release Mode
  await ScreenUtil.ensureScreenSize();

  await GetStorage.init();
  runApp(CarConsultantApp(
    appRouter: AppRouter(),
  ),);
}

