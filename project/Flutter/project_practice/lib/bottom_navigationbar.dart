import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_practice/colors.dart';
import 'package:project_practice/dashboard.dart';
import 'package:project_practice/home.dart';
import 'package:project_practice/profile_page.dart';
import 'package:project_practice/search.dart';
import 'package:project_practice/settings.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {

  // List of pages to show for each tab
  final List<Widget> _pages = [
    Dashboard(),
    Search(),
    HomePage(),
    ProfilePage(),
    SettingsPage()
  ];

  int _selectedIndex = 2;  // Tracks the current tab index

  // Update the selected tab and change page content accordingly
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> navItems = [
    const Icon(Icons.dashboard_customize_outlined),
    const Icon(Icons.search),
    const Icon(Icons.home),
    const Icon(Icons.person),
    const Icon(Icons.settings)
  ];

  Color bgColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      // _pages[_selectedIndex],
      // Container(
      //   // color: bgColor,
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        color: AppColors.secondary,
        backgroundColor: Colors.transparent,
        items: navItems,
        buttonBackgroundColor: AppColors.secondary,
        index: 2,
        animationDuration: Duration(milliseconds: 300),
        onTap: _onItemTapped,
      ),
    );
  }
}
