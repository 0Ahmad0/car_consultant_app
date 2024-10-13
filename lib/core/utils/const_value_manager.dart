import 'package:car_consultant/app/screens/navbar/appointments_screen.dart';
import 'package:car_consultant/app/screens/navbar/home_screen.dart';
import 'package:car_consultant/app/screens/navbar/messages_screen.dart';
import 'package:car_consultant/app/screens/navbar/profile_screen.dart';
import 'package:car_consultant/app/screens/navbar/notification_screen.dart';
import 'package:car_consultant/core/routing/routes.dart';
import 'package:car_consultant/core/utils/assets_manager.dart';
import 'package:car_consultant/core/utils/string_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/widgets/select_time_widget.dart';

class ConstValueManager {
  /// Design Size
  static const double widthSize = 393.0;
  static const double heightSize = 852.0;

  static const int animationDuration = 600;

  /// Duration Delayed Second
  static const int delayedSplash = 3;

  /// Button Size
  static const double heightButtonSize = 56;

  /// Length  Appointments TabBar
  static const int lengthAppointmentsTabBar = 3;

  /// Locale Language Code

  static const String arLanguageCode = 'ar';
  static const String enLanguageCode = 'en';

  static const Map aboutUsMapText = {
    "text":"Car Consultant is your go-to solution for all car-related needs. We connect car owners with automotive consultants to diagnose vehicle issues and schedule appointments with trusted service providers for repairs and maintenance. Our platform offers expert advice and easy booking, ensuring a seamless, transparent, and reliable car care experience. We're here to simplify car ownership and keep your vehicle running smoothly."
  };


  static const List<String> tabs = ['Upcoming', 'Current', 'Previous'];
  static List<NavbarItem> navBarList = [
    NavbarItem(route: HomeScreen(), icon: Icons.home_outlined, label: 'Home'),
    NavbarItem(
        route: MessagesScreen(),
        icon: Icons.messenger_outline,
        label: 'Messages'),
    NavbarItem(
        route: AppointmentsScreen(),
        icon: Icons.date_range_outlined,
        label: 'Appointments'),
    NavbarItem(
        route: NotificationScreen(),
        icon: Icons.notifications_none,
        label: 'Notifications'),
    NavbarItem(route: ProfileScreen(), icon: Icons.person, label: 'Profile'),
  ];

  static List<DateTime> dateList = [
    DateTime.now(),
    DateTime(2024, 10, 19),
    DateTime(2024, 12, 10),
    DateTime(2024, 12, 25),
    DateTime(2024, 12, 26),
  ];

  static List<TimeHourModel> timeList = [
    TimeHourModel(
        status: SelectTimeOrderStatus.empty,
        fromTime: DateTime(7, 3, 1),
        toTime: DateTime.now()),
    TimeHourModel(
        status: SelectTimeOrderStatus.book,
        fromTime: DateTime(6, 5, 5),
        toTime: DateTime.now()),
    TimeHourModel(
        status: SelectTimeOrderStatus.selected,
        fromTime: DateTime(1, 12, 2),
        toTime: DateTime.now()),
    TimeHourModel(
        status: SelectTimeOrderStatus.empty,
        fromTime: DateTime(8, 9, 2),
        toTime: DateTime.now()),
    TimeHourModel(
        status: SelectTimeOrderStatus.book,
        fromTime: DateTime(11, 3, 5),
        toTime: DateTime.now()),
    TimeHourModel(
        status: SelectTimeOrderStatus.empty,
        fromTime: DateTime(2, 5, 1),
        toTime: DateTime.now()),
  ];

  static List<PaymentOption> paymentList = [
    PaymentOption(text: StringManager.visaText, icon: AssetsManager.visaIcon),
    PaymentOption(
        text: StringManager.masterCardText, icon: AssetsManager.masterCardIcon),
    PaymentOption(text: StringManager.sadadText, icon: AssetsManager.sadadIcon),
  ];

  static List<ConditionPasswordItem> conditionPasswordList = [
    ConditionPasswordItem(text: StringManager.condition1Text),
    ConditionPasswordItem(text: StringManager.condition2Text),
    ConditionPasswordItem(text: StringManager.condition3Text),
    ConditionPasswordItem(text: StringManager.condition4Text),
  ];
}

class ConditionPasswordItem {
  final String text;
  bool isValidate;

  ConditionPasswordItem({required this.text, this.isValidate = false});
}

class PaymentOption {
  final String text;
  final String icon;

  PaymentOption({required this.text, required this.icon});
}

class NavbarItem {
  final Widget route;
  final String label;
  final IconData icon;

  NavbarItem({required this.route, required this.icon, required this.label});
}
