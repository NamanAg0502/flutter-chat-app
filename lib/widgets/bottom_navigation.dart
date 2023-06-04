import 'package:chat/constants/index.dart';
import 'package:flutter/material.dart';

import '../screens/menu/home_screen.dart';
import '../screens/menu/profile_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: AppColors.appNav,
        elevation: 5,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: SizedBox(
                height: 30.0,
                width: 30.0,
                child: Image.asset(
                  _currentIndex != 0
                      ? 'assets/icons/home.png'
                      : 'assets/icons/home_white.png',
                  height: 24.0,
                ),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            GestureDetector(
              child: SizedBox(
                height: 30.0,
                width: 30.0,
                child: Image.asset(
                  _currentIndex != 1
                      ? 'assets/icons/profile.png'
                      : 'assets/icons/profile_white.png',
                  height: 24.0,
                ),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
