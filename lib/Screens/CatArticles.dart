import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Providers/PageSliderProvider.dart';
import 'package:news_app/Screens/SavedArticles.dart';
import 'package:provider/provider.dart';

class CatArticles extends StatefulWidget {
  final List articles;
  const CatArticles({required this.articles, super.key});

  @override
  State<CatArticles> createState() => _CatArticlesState();
}

class _CatArticlesState extends State<CatArticles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        body: widget.articles.isEmpty
            ? const Center(
                child: Text(
                "No Articles",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ))
            : PageView.builder(
                scrollDirection: Axis.vertical,
                onPageChanged: (pageIndex) {},
                itemCount: widget.articles.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        // color: AppColors.appBackground,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.fromLTRB(14, 20, 14, 20),
                              child: Text(
                                widget.articles[index]["title"]
                                    .toString()
                                    .toUpperCase(),
                                style: GoogleFonts.getFont(
                                  "Playfair Display",
                                  fontSize: 30,
                                  height: 1.2,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const Divider(
                              height: 10,
                              indent: 100,
                              endIndent: 100,
                              thickness: 1,
                              // color: AppColors.textColor,
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(14, 20, 14, 20),
                              child: Text(
                                widget.articles[index]["body"]
                                    .toString()
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  "Playfair Display",
                                  fontSize: 26,
                                  height: 1,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        right: 10,
                        child: Column(
                          children: [
                            Consumer<PageSliderProvider>(
                              builder: (context, value, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: IconButton(
                                    onPressed: () {
                                      value.favorite(
                                          index,
                                          value.articles[index].title,
                                          value.articles[index].body);
                                    },
                                    icon: const Icon(Icons.favorite),
                                    iconSize: 30,
                                    color: value.favorites[index] == true
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                );
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Icon(Icons.comment, size: 30),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        // backgroundColor: AppColors.bottomNavBarColor,
                                        context: context,
                                        builder: (context) {
                                          return SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // IconButton(onPressed: (){
                                                  //   value.saveArticles(ArticlesHive(title: value.articles[index].title, description: value.articles[index].body));
                                                  // }, icon: const Icon(Icons.archive, size: 40,)),
                                                  Consumer<PageSliderProvider>(
                                                      builder: (context,
                                                          colorValue, child) {
                                                    return IconButton(
                                                        onPressed: () {
                                                          colorValue
                                                              .colorMode();
                                                        },
                                                        icon: PageSliderProvider
                                                                .lightmode
                                                            ? const Icon(
                                                                Icons
                                                                    .wb_sunny_outlined,
                                                                size: 40,
                                                              )
                                                            : const Icon(
                                                                Icons.dark_mode,
                                                                size: 40));
                                                  }),
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    const SavedArticles()));
                                                      },
                                                      icon: const Icon(
                                                        Icons.article_outlined,
                                                        size: 40,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.more_vert, size: 30)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )
        // PageView.builder(
        //   scrollDirection: Axis.vertical,
        //   itemCount: widget.articles.length,
        //   itemBuilder: (context, index) {
        //    return Column(
        //             children: [
        //               Text(widget.articles[index]["title"]),
        //               Text(widget.articles[index]["description"]),
        //             ],
        //    );
        //   },
        // ),
        );
  }
}
