import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/Models/HiveModels/ArticlesHive.dart';
import 'package:news_app/Providers/CategoriesProvider.dart';
import 'package:news_app/Providers/ThemeProvider.dart';
import 'package:news_app/Providers/WebViewProvider.dart';
import 'package:news_app/Screens/HomePage.dart';
import 'package:news_app/Providers/PageSliderProvider.dart';
import 'package:news_app/Providers/SwitchBottomNav.dart';
import 'package:news_app/Screens/Authentication/Login.dart';
import 'package:news_app/Screens/Authentication/SignUp.dart';
import 'package:news_app/util/Utilities.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticlesHiveAdapter());
  await Hive.openBox<ArticlesHive>("SavedArticles");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageSliderProvider()),
        ChangeNotifierProvider(create: (_) => SwitchBottomNav()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => WebViewProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeValue, child) {
        return MaterialApp(
          theme: ThemeData(
              brightness:
                  themeValue.lightMode ? Brightness.light : Brightness.dark,
              appBarTheme: AppBarTheme(
                backgroundColor: themeValue.lightMode
                    ? AppColorsLight.appBackground
                    : AppColorsDark.appBackground,
              ),
              fontFamily: GoogleFonts.acme().fontFamily,
              scaffoldBackgroundColor: themeValue.lightMode
                  ? AppColorsLight.appBackground
                  : AppColorsDark.appBackground,
              cardTheme: CardTheme(
                color: themeValue.lightMode
                    ? AppColorsLight.categoryCards
                    : AppColorsDark.categoryCards,
                shadowColor: AppColorsLight.textColor,
                // shadowColor: themeValue.lightMode? AppColorsLight.textColor : AppColorsDark.textColor,
              ),
              dividerTheme: DividerThemeData(
                color: themeValue.lightMode
                    ? AppColorsLight.textColor
                    : AppColorsDark.textColor,
              ),
              iconTheme: IconThemeData(
                color: themeValue.lightMode
                    ? AppColorsLight.textColor
                    : AppColorsDark.textColor,
              ),
              progressIndicatorTheme: ProgressIndicatorThemeData(
                color: themeValue.lightMode
                    ? AppColorsLight.textColor
                    : AppColorsDark.textColor,
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(),
                bodyMedium: TextStyle(),
                bodySmall: TextStyle(),
              ).apply(
                bodyColor: themeValue.lightMode
                    ? AppColorsLight.textColor
                    : AppColorsDark.textColor,
                displayColor: themeValue.lightMode
                    ? AppColorsLight.textColor
                    : AppColorsDark.textColor,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: themeValue.lightMode
                    ? AppColorsLight.bottomNavBarColor
                    : AppColorsDark.bottomNavBarColor,
                unselectedItemColor: themeValue.lightMode
                    ? AppColorsLight.bottomNavUnselectedColor
                    : AppColorsDark.bottomNavUnselectedColor,
                selectedItemColor: themeValue.lightMode
                    ? AppColorsLight.bottomNavSelectedColor
                    : AppColorsDark.bottomNavSelectedColor,
              ),
              switchTheme: SwitchThemeData(thumbColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColorsLight
                      .textColor; // Color when the switch is ON
                }
                return AppColorsDark.textColor; // Color when the switch is OFF
              }), trackColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColorsLight
                      .categoryCards; // Color when the switch is ON
                }
                return AppColorsDark.categoryCards; //
              })),
              inputDecorationTheme: const InputDecorationTheme()),
          debugShowCheckedModeBanner: false,
          home: Container(
              color: themeValue.lightMode
                  ? AppColorsLight.appBackground
                  : AppColorsDark.appBackground,
              child: const SafeArea(top: false, child: HomePage())),
        );
      }),
    );
  }
}
