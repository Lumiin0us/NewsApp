import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:news_app/Models/HiveModels/ArticlesHive.dart';
import '../APIs/API.dart';

final PageController _controller =
    PageController(keepPage: true, initialPage: 0);
final TextEditingController _searchBarController = TextEditingController();

class PageSliderProvider with ChangeNotifier {
  int length = 0;
  List articles = [];
  List articlesFilter = [];

  List favorites = [];
  List<ArticlesHive> savedArticlesList = [];
  List<FavoritesHolder> favoritesData = [];
  List urls = [];
  bool _allowVerticalScroll = true;
  bool _visibility = true;
  bool _loading = true;

  bool get loading => _loading;

  bool get visibility => _visibility;

  bool get allowVerticalScroll => _allowVerticalScroll;
  static bool lightmode = true;

  PageController get controller => _controller;

  TextEditingController get searchBarController => _searchBarController;

  onSearchText(String text) {
    articlesFilter =
        articles.where((element) => element.title.contains(text)).toList();
    notifyListeners();
  }

  allowScroll(int pageIndex) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageIndex == 1) {
        hideVisibility();
        _allowVerticalScroll = false;
      } else {
        hideVisibility();
        _allowVerticalScroll = true;
      }
      notifyListeners();
    });
  }

  hideVisibility() {
    _visibility = !_visibility;
  }

  generateFavorites(articleList) {
    length = articles.length;
    favorites = List.generate(length, (index) => false);
  }

  Future<List> getArticlesAPI() async {
    articles = await APIs.getArticles();
    articlesFilter = articles;
    generateFavorites(articles);
    _loading = false;
    notifyListeners();
    return articles;
  }

  void favorite(int index, String title, String description) {
    favorites[index] = !favorites[index];
    if (favorites[index] == true) {
      favoritesData.add(
          FavoritesHolder(id: index, title: title, description: description));
    } else {
      favoritesData.removeWhere((obj) => obj.id == index);
    }
    notifyListeners();
  }

  void saveArticles(ArticlesHive object) {
    if (urls.any((element) => element.contains(object.title))) {
    } else {
      urls.add(object.title);
      Hive.box<ArticlesHive>("SavedArticles").add(object);
      notifyListeners();
    }
  }

  void loadArticles() {
    savedArticlesList = Hive.box<ArticlesHive>("SavedArticles")
        .values
        .toList()
        .cast<ArticlesHive>();
    notifyListeners();
  }

  void deleteArticle(int index, String title) {
    urls.remove(title);

    Hive.box<ArticlesHive>("SavedArticles").deleteAt(index);
    notifyListeners();
  }

  void colorMode() {
    lightmode = !lightmode;
    notifyListeners();
  }
}

class FavoritesHolder {
  int id;
  String title;
  String description;

  FavoritesHolder(
      {required this.id, required this.title, required this.description});
}
