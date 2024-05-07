import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Providers/PageSliderProvider.dart';
import 'package:provider/provider.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({super.key});

  @override
  State<SavedArticles> createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageSliderProvider>(builder: (context, value, child) {
      value.loadArticles();
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: value.savedArticlesList.isEmpty
            ? const Center(
                child: Text(
                "No Saved Articles",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ))
            : GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    crossAxisCount: 2),
                itemCount: value.savedArticlesList.length,
                itemBuilder: ((context, index) {
                  return Card(
                    elevation: 5,
                    child: Stack(
                      children: [
                        Positioned(
                          right: -8,
                          top: -8,
                          child: IconButton(
                              onPressed: () {
                                value.deleteArticle(
                                    index, value.articles[index].title);
                              },
                              icon: const Icon(
                                Icons.delete,
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 9.0, right: 15.0, bottom: 9.0),
                          child: Center(
                              child: Text(
                            value.savedArticlesList[index].title.toUpperCase(),
                            style: GoogleFonts.getFont("Playfair Display",
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                height: 1),
                            maxLines: 5,
                            overflow: TextOverflow.visible,
                          )),
                        ),
                      ],
                    ),
                  );
                })),
      );
    });
  }
}
