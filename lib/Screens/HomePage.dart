import 'package:flutter/material.dart';
import 'package:news_app/CustomWidgets/PageSlider.dart';
import 'package:news_app/Providers/PageSliderProvider.dart';
import 'package:news_app/Providers/SwitchBottomNav.dart';
import 'package:news_app/Screens/Categories.dart';
import 'package:news_app/Screens/Profile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> widgets = [
    const Categories(),
    const PageSlider(),
    const Profile(),
  ];
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.category), label: "Category"),
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];
  @override
  Widget build(BuildContext context) {
    print("Main Build");
    return Consumer<SwitchBottomNav>(builder: (context, value, child) {
      return Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: IndexedStack(
              index: value.selectedIndex,
              children: widgets,
            ),
          ),
          bottomNavigationBar: Consumer<PageSliderProvider>(
              builder: (context, visibilityValue, child) {
            return Visibility(
              visible: visibilityValue.visibility,
              child: BottomNavigationBar(
                iconSize: 20,
                items: items,
                onTap: (index) {
                  value.switchNav(index);
                },
                currentIndex: value.selectedIndex,
                selectedFontSize: 12.0, // Font size of the selected item
                unselectedFontSize: 10.0, // Font size of unselected items
                elevation: 4.0, // Elevation of the bottom navigation bar
                type: BottomNavigationBarType
                    .fixed, // Display mode of the bottom navigation bar (fixed or shifting)
              ),
            );
          }));
    });
  }
}
