import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ui/Services/auth.dart';
import 'package:ui/pages/edit_profile_page.dart';
import 'package:ui/pages/home_screen.dart';
import 'package:ui/pages/settings_page.dart';

import '../Services/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    HomeScreen(),
    EditProfilePage(),
    SettingsPage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
              gap: 20.0,
              backgroundColor: Colors.blue,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.white24,
              padding: EdgeInsets.all(16),
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.person,
                  text: "Edit Profile",
                ),
                GButton(
                  icon: Icons.settings,
                  text: "Settings",
                )
              ]),
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
