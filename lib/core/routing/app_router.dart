

import 'package:car_consultant/core/routing/routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => Scaffold(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Scaffold(),
          ),
        );
    }
  }
}
