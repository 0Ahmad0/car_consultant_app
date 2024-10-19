import 'package:flutter/material.dart';

import '../../../core/utils/color_manager.dart';
import '../../../core/utils/const_value_manager.dart';

class AdminNavBarScreen extends StatefulWidget {
  const AdminNavBarScreen({super.key});

  @override
  State<AdminNavBarScreen> createState() => _AdminNavBarScreenState();
}

class _AdminNavBarScreenState extends State<AdminNavBarScreen> {
  int _currentIndex = 0;

  _onTap(index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstValueManager.adminNavBarList[_currentIndex].route,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap:  _onTap,
        fixedColor: ColorManager.primaryColor,
        elevation: 0.0,
        unselectedItemColor: ColorManager.unselectedItemColor,
        type: BottomNavigationBarType.shifting,
        items: ConstValueManager.adminNavBarList
            .map(
              (e) => BottomNavigationBarItem(
            icon: Icon(e.icon),
            label: e.label,
            tooltip: e.label,
          ),
        )
            .toList(),
      ),
    );
  }
}
