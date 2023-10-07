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
    return MaterialApp(
      title: "Profile",
      routes: {
        '/': (context) => const ProfileList(),
        '/addprofile': (context) => const AddProfile(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
