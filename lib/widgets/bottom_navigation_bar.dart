import 'package:flutter/material.dart';
import 'package:tripaz/screens/home_screen.dart';
import 'package:tripaz/screens/notification_screen.dart';
import 'package:tripaz/screens/profile_screen.dart';
import 'package:tripaz/screens/wish_list_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, this.userId});

  final String? userId;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int myCurrentIndex = 0;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(userId: widget.userId),
      const WishListScreen(),
      const NotificationScreen(),
      ProfileScreen(userId: widget.userId),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      myCurrentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[myCurrentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white, // Burada istediğiniz rengi belirleyin.
        ),
        child: BottomNavigationBar(
          elevation: 0,
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
      ),
    );
  }
}
