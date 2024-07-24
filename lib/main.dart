import 'package:flutter/material.dart';
import 'package:san_travel/widgets/bottom_navigation_bar.dart';

void main() {
  runApp(const SanTravel());
}

class SanTravel extends StatelessWidget {
  const SanTravel({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}
