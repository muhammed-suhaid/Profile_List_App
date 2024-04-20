import 'package:flutter/material.dart';
import 'add_profile.dart';
import 'list_profiles.dart';

Future<void> main() async {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var kDarkColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 125, 87, 5),
    );
    return MaterialApp(
      title: "Profile",
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
      ),
      routes: {
        '/': (context) => const ProfileList(),
        '/addprofile': (context) => const AddProfile(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
