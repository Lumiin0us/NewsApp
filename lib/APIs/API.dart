import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/Models/Category.dart';
import 'package:news_app/Models/Posts.dart';

class APIs
{
  static Future getCategories() async
  {
    final response = await http.get(Uri.parse("http://0.0.0.0:3000/categories"));
    if(response.statusCode == 200)
    {
      final data = jsonDecode(response.body)['Categories'];
      final categories = data.map((json) => Category.fromJson(json)).toList();
      // cat.forEach((val) => val["name"]);
      return categories;
    }
    else
    {
      print("Error: ${response.statusCode}");
    }
  }

  static Future getArticles() async
  {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if(response.statusCode == 200)
    {
      final data = jsonDecode(response.body);
      final posts = data.map((json) => Post.fromJson(json)).toList();
      return posts;
    }
    else
    {
     return response.statusCode;
    }
  }

  
}