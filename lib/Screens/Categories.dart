import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Providers/CategoriesProvider.dart';
import 'package:news_app/Screens/CatArticles.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<CategoriesProvider>(builder: (context, value, child) {
      if (value.categories.isEmpty) {
        value.getCategories();
        return const Center(child: CircularProgressIndicator());
      } else {
        return Padding(
          padding: const EdgeInsets.only(
              top: 26.0, left: 8.0, right: 8.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 14.0),
                child: Text(
                  "CATEGORIES",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: value.categories.length,
                    itemBuilder: ((context, index) {
                      return SizedBox(
                        height: 90,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => CatArticles(
                                    articles:
                                        value.categories[index].articles)));
                          },
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.all(11.0),
                            child: Center(
                              child: Text(
                                  value.categories[index].name.toUpperCase(),
                                  style: GoogleFonts.getFont(
                                    'Acme',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                            ),
                          ),
                        ),
                      );
                    })),
              ),
            ],
          ),
        );
      }
    }));
  }
}
