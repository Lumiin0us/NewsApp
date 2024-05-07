class Category
{
  String name;
  List articles; 
  Category({required this.name, required this.articles});
  factory Category.fromJson(Map<dynamic, dynamic> json) => Category(name: json['name'], articles: json['articles']);
}

