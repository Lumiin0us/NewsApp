import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _lightMode = true;
  bool? colorChecker = true;

  bool get lightMode => _lightMode;

  void setTheme() {
    print(lightMode);
    _lightMode = !_lightMode;
    if (colorChecker != null) {
      colorChecker = !colorChecker!;
    }
    notifyListeners();
  }

  ThemeProvider({this.colorChecker});
}
