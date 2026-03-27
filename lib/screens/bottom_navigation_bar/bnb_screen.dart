import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobile_assignment/screens/cart_screen/cart_screen.dart';
import 'package:mobile_assignment/screens/home_screen/home_screen.dart';
import 'package:mobile_assignment/screens/search_screen/search_screen.dart';
import 'package:mobile_assignment/screens/setting_screen/setting_screen.dart';

class BnbScreen extends StatefulWidget {
  const BnbScreen({super.key});

  @override
  State<BnbScreen> createState() => _BnbScreenState();
}

class _BnbScreenState extends State<BnbScreen> {
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    SettingScreen(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: GNav(
          
          onTabChange: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          
          tabMargin: EdgeInsets.only(top: 5, bottom: 5),
          selectedIndex: currentIndex,
          haptic: true, // haptic feedback
          tabBorderRadius: 30,
          tabActiveBorder: Border.all(
              color: Color(0xff5A9B73), width: 1), // tab button border
          // tabBorder:
          //     Border.all(color: Color(0xff5A9B73), width: 1), // tab button border
          tabShadow: [
            BoxShadow(color: Colors.white, blurRadius: 8)
          ], // tab button shadow
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 400), // tab animation duration
          gap: 9, // the tab button gap between icon and text
          color: Color(0xff5A9B73), // unselected icon color
          activeColor: Color(0xff5A9B73), // selected icon and text color
          iconSize: 26, // tab button icon sizeS
          tabBackgroundColor:
              Colors.transparent, // selected tab background color
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ), // navigation bar padding

          textStyle: TextStyle(
            color: Color(0xff5A9B73),
          ),

          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.shopping_cart,
              text: 'Cart',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            )
          ],
        ),
      ),
    );
  }
}
