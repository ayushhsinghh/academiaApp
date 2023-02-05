import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/AcadControllers.dart';

BottomNavyBar BottomNavBar(AcadDataController controller) {
  return BottomNavyBar(
    selectedIndex: controller.tabIndex.value,
    backgroundColor: controller.bottomNavColor.value,
    showElevation: true, // use this to remove appBar's elevation
    onItemSelected: controller.changeTabIndex,
    items: [
      BottomNavyBarItem(
          icon: const Icon(Icons.menu_book),
          title: const Text('Attendance'),
          activeColor: Colors.green),
      BottomNavyBarItem(
          icon: const Icon(Icons.dataset),
          title: const Text('Marks'),
          activeColor: Colors.purple.shade100,
          inactiveColor: Colors.purple.shade300),
      BottomNavyBarItem(
        icon: const Icon(Icons.calendar_today),
        title: const Text('Calender'),
        activeColor: const Color.fromARGB(237, 2, 79, 8),
        inactiveColor: const Color.fromARGB(236, 10, 52, 2),
      ),
      BottomNavyBarItem(
          icon: const Icon(Icons.person),
          title: const Text('Profile'),
          activeColor: Colors.blue.shade600),
    ],
  );
}
