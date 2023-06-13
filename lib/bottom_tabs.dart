import 'package:fit_plan/Screens/GymOwnerScreens/addEquipments.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/equipments.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/homePage.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Screens/GymOwnerScreens/loginPage.dart';
import 'Screens/GymOwnerScreens/members.dart';
import 'Screens/GymOwnerScreens/revenue&expenses.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({required this.page, required this.title, required this.icon});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        TabNavigationItem(
          page:  Equipments(),
          icon: Icon(Icons.search),
          title: Text("Search"),
        ),
        TabNavigationItem(
          page: Members(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
          TabNavigationItem(
          page: RevenueExpenses(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
      ];
}
