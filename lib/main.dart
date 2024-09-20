import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:san_travel/firebase_options.dart';
import 'package:san_travel/widgets/bottom_navigation_bar.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
