import 'package:flutter/material.dart';
import 'package:news_app/Providers/PageSliderProvider.dart';
import 'package:news_app/Providers/ThemeProvider.dart';
import 'package:news_app/Screens/SavedArticles.dart';
import 'package:news_app/util/Utilities.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> titleList = [
    "Username",
    "Email",
    "Night Mode",
    "Saved Articles"
  ];
  List<Icon> iconList = [
    const Icon(Icons.person),
    const Icon(Icons.email),
    const Icon(Icons.nightlife),
    const Icon(Icons.save),
  ];
  List<String> subtitleList = [
    "Abdurrehman",
    "abd@gmail.com",
    "Enable Night Mode",
    "Your Saved Articles"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<PageSliderProvider>(builder: (context, value, child) {
      return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              color: AppColorsLight.categoryCards,
              borderRadius: const BorderRadius.only(
                bottomLeft:
                    Radius.circular(15), // Adjust the radius value as needed
                bottomRight:
                    Radius.circular(15), // Adjust the radius value as needed
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 170,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const ListTile(
            title: Text("Username"),
            subtitle: Text("Abdurrehman"),
            leading: Icon(Icons.person_2_rounded),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),

          const ListTile(
            title: Text("Email"),
            subtitle: Text("abd@gmail.com"),
            leading: Icon(Icons.email),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          Consumer<ThemeProvider>(builder: (context, themeValue, child) {
            return ListTile(
                title: const Text("Night Mode"),
                subtitle: const Text("Enable Night Mode"),
                leading: themeValue.lightMode
                    ? const Icon(Icons.wb_sunny_outlined)
                    : const Icon(Icons.dark_mode),
                trailing: Switch(
                  value: themeValue.lightMode,
                  onChanged: (value) {
                    themeValue.setTheme();
                  },
                ));
          }),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SavedArticles()));
            },
            child: const ListTile(
              title: Text("Saved Articles"),
              subtitle: Text("Your Saved Articles"),
              leading: Icon(Icons.archive),
            ),
          ),

          // Expanded(
          //     child: ListView.separated(
          //   itemCount: 4,
          //   separatorBuilder: (context, index) => const Divider(
          //     indent: 30,
          //     endIndent: 30,
          //   ), // Add divider
          //   itemBuilder: (context, index) {
          //     return SizedBox(
          //       height: 100,
          //       child: ListTile(
          //         leading: iconList[index],
          //         title: Text(titleList[index].toString()),
          //         subtitle: Text(subtitleList[index]),
          //         trailing: index == 2
          //             ? Consumer<ThemeProvider>(
          //                 builder: (context, themeValue, child) {
          //                 return Switch(
          //                   value: themeValue.lightMode,
          //                   onChanged: (value) {
          //                     themeValue.setTheme();
          //                   },
          //                 );
          //               })
          //             : const Text(""),
          //         // Other properties
          //       ),
          //     );
          //   },
          // ))
        ],
      );
    }));
  }
}
