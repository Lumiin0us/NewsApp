import 'package:flutter/material.dart';
import 'package:news_app/APIs/API.dart';

class CategoriesProvider extends ChangeNotifier {
  List categories = [];

  getCategories() async {
    categories = await APIs.getCategories();
    notifyListeners();
  }
}
