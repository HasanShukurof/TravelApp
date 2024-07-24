import 'package:flutter/material.dart';
import 'package:san_travel/screens/home_screen.dart';
import 'package:san_travel/screens/notification_screen.dart';
import 'package:san_travel/screens/profile_screen.dart';
import 'package:san_travel/screens/wish_list_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int myCurrentIndex = 0;
  List screens = const [
    HomeScreen(),
    WishListScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      myCurrentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[myCurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF0FA3E2),
        unselectedItemColor: Color.fromARGB(64, 0, 0, 0),
        currentIndex: myCurrentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Wishlist",
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: "Notifications",
            icon: Icon(Icons.notifications),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
