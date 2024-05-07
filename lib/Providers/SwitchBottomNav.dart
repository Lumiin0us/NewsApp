import 'package:flutter/material.dart';

class SwitchBottomNav with ChangeNotifier {
  int _selectedIndex = 2;
  int get selectedIndex => _selectedIndex;

  switchNav(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }
}
