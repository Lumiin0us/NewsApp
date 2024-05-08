import 'package:flutter/material.dart';
import 'package:news_app/Logging/Logs.dart';

// Logs logger = Logs();

class SwitchBottomNav with ChangeNotifier {
  int _selectedIndex = 1;
  int get selectedIndex => _selectedIndex;

  switchNav(int newIndex) {
    _selectedIndex = newIndex;
    Logs.switchTimer(newIndex);
    print("Logger working");
    notifyListeners();
  }
}
