import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Logging/Logs.dart';
import 'package:news_app/Models/HiveModels/ArticlesHive.dart';
import 'package:news_app/Providers/PageSliderProvider.dart';
import 'package:news_app/Providers/ThemeProvider.dart';
import 'package:news_app/Screens/PageWebView.dart';
import 'package:news_app/util/Utilities.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class PageSlider extends StatefulWidget {
  const PageSlider({super.key});
  @override
  State<PageSlider> createState() => _PageSliderState();
}

class _PageSliderState extends State<PageSlider> {
  late Logs logger;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logger = Logs();
    logger.startTimer();
    Provider.of<PageSliderProvider>(context, listen: false).getArticlesAPI();
  }

  void pageUpdate(value) {}
  @override
  Widget build(BuildContext context) {
    return Consumer<PageSliderProvider>(
      builder: (context, value, child) {
        if (value.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Container(
                  height: 80,
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: TextField(
                    controller: value.searchBarController,
                    onChanged: (text) {
                      value.onSearchText(text);
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            color: Colors.transparent), // Border color
                      ),
                      hintText: 'Search', // Hint text
                      hintStyle: const TextStyle(
                          color: Colors.grey), // Hint text color
                      fillColor: Colors.white, // Fill color
                      filled: true, // Enable fill color
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            color: Colors
                                .transparent), // Border color when enabled
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            color: Colors
                                .transparent), // Border color when focused
                      ),
                      // You can add more styling properties as needed
                    ),
                  )),
              value.articlesFilter.isNotEmpty
                  ? Expanded(
                      child: PageView.builder(
                        scrollDirection: Axis.vertical,
                        controller: value.controller,
                        physics: value.allowVerticalScroll
                            ? const AlwaysScrollableScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        restorationId: "HomePageRestore",
                        onPageChanged: (pageIndex) {
                          print("TOTAL TIME:${logger.restartTimer()}");
                          print("TOTAL TIME!");
                        },
                        itemCount: value.articlesFilter.length,
                        itemBuilder: (context, index) {
                          return PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              onPageChanged: (pageIndex) {
                                value.allowScroll(pageIndex);
                              },
                              itemBuilder: (context, pageIndex) {
                                return pageIndex == 1
                                    ? const PageWebView()
                                    : Stack(
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          14, 0, 14, 20),
                                                  child: Text(
                                                    value.articlesFilter[index]
                                                        .title
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: GoogleFonts.getFont(
                                                      "Playfair Display",
                                                      fontSize: 30,
                                                      height: 1.2,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  height: 10,
                                                  indent: 100,
                                                  endIndent: 100,
                                                  thickness: 1,
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          14, 20, 14, 20),
                                                  child: Text(
                                                    value.articlesFilter[index]
                                                        .body
                                                        .toString()
                                                        .toUpperCase(),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.getFont(
                                                      "Playfair Display",
                                                      fontSize: 26,
                                                      height: 1,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                                Consumer2<PageSliderProvider,
                                                    ThemeProvider>(
                                                  builder: (context, value,
                                                      theme, child) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 6),
                                                      child: IconButton(
                                                        onPressed: () {
                                                          value.favorite(
                                                              index,
                                                              value
                                                                  .articles[
                                                                      index]
                                                                  .title,
                                                              value
                                                                  .articles[
                                                                      index]
                                                                  .body);
                                                        },
                                                        icon: const Icon(
                                                            Icons.favorite),
                                                        iconSize: 30,
                                                        color: value.favorites[
                                                                    index] ==
                                                                true
                                                            ? Colors.red
                                                            : theme.lightMode
                                                                ? AppColorsLight
                                                                    .textColor
                                                                : AppColorsDark
                                                                    .textColor,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 6),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        value.saveArticles(
                                                            ArticlesHive(
                                                                title: value
                                                                    .articles[
                                                                        index]
                                                                    .title,
                                                                description: value
                                                                    .articles[
                                                                        index]
                                                                    .body),
                                                            index,
                                                            value
                                                                .articles[index]
                                                                .title);
                                                      },
                                                      icon: Icon(
                                                        value.saves[index]
                                                            ? Icons
                                                                .turned_in_rounded
                                                            : Icons
                                                                .turned_in_not_rounded,
                                                        size: 30,
                                                      )),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      await Share.share(
                                                          "${value.articles[index].title} \n \n"
                                                          "https://www.google.com");
                                                    },
                                                    icon: const Icon(
                                                      Icons.share,
                                                      size: 30,
                                                    )),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           bottom: 10),
                                                // child: IconButton(
                                                //     onPressed: () {
                                                //       value.controller.animateToPage(
                                                //           1,
                                                //           duration:
                                                //               const Duration(
                                                //                   milliseconds:
                                                //                       300),
                                                //           curve: Curves.ease);
                                                //     },
                                                //     icon: const Icon(
                                                //         Icons.arrow_upward,
                                                //         size: 30)),
                                                // ),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           bottom: 10),
                                                //   child: IconButton(
                                                //       onPressed: () {
                                                //         showModalBottomSheet(
                                                //             context: context,
                                                //             builder: (context) {
                                                //               return SizedBox(
                                                //                 height: MediaQuery.of(
                                                //                             context)
                                                //                         .size
                                                //                         .height *
                                                //                     0.2,
                                                //                 child: Padding(
                                                //                   padding:
                                                //                       const EdgeInsets
                                                //                           .all(
                                                //                           16.0),
                                                //                   child: Row(
                                                //                     crossAxisAlignment:
                                                //                         CrossAxisAlignment
                                                //                             .start,
                                                //                     mainAxisAlignment:
                                                //                         MainAxisAlignment
                                                //                             .spaceBetween,
                                                //                     children: [
                                                //                       IconButton(
                                                //                           onPressed:
                                                //                               () {
                                                //                             value.saveArticles(ArticlesHive(
                                                //                                 title: value.articles[index].title,
                                                //                                 description: value.articles[index].body));
                                                //                           },
                                                //                           icon:
                                                //                               const Icon(
                                                //                             Icons.archive,
                                                //                             size:
                                                //                                 40,
                                                //                           )),
                                                //                       Consumer<ThemeProvider>(builder: (context,
                                                //                           colorValue,
                                                //                           child) {
                                                //                         return IconButton(
                                                //                             onPressed:
                                                //                                 () {
                                                //                               colorValue.setTheme();
                                                //                             },
                                                //                             icon: colorValue.lightMode
                                                //                                 ? const Icon(
                                                //                                     Icons.wb_sunny_outlined,
                                                //                                     size: 40,
                                                //                                   )
                                                //                                 : const Icon(Icons.dark_mode, size: 40));
                                                //                       }),
                                                //                       IconButton(
                                                //                           onPressed:
                                                //                               () {
                                                //                             Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SavedArticles()));
                                                //                           },
                                                //                           icon:
                                                //                               const Icon(
                                                //                             Icons.article_outlined,
                                                //                             size:
                                                //                                 40,
                                                //                           ))
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //               );
                                                //             });
                                                //       },
                                                //       icon: const Icon(
                                                //           Icons.more_vert,
                                                //           size: 30)),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                              });
                        },
                      ),
                    )
                  : const Expanded(
                      child: Center(
                          child: Text(
                      "No Search Results Found",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    )))
            ],
          );
        }
      },
    );
  }
}
