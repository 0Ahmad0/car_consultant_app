import 'package:car_consultant/core/helpers/extensions.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ColorManager.primaryColor,
        primarySwatch: ColorManager.primaryColor.toMaterialColor(),
        colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.primaryColor),
      ),
      home:  Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.add),
        ),
        body: Center(
          child: Image.asset(AssetsManager.logoIMG),
        ),
      ),
    );
  }
}


