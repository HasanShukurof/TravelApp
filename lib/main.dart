import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:san_travel/firebase_options.dart';
import 'package:san_travel/screens/login_screen.dart';
import 'package:san_travel/widgets/bottom_navigation_bar.dart';
import 'package:san_travel/services/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SanTravel());
}

class SanTravel extends StatefulWidget {
  const SanTravel({super.key});

  @override
  State<SanTravel> createState() => _SanTravelState();
}

class _SanTravelState extends State<SanTravel> {
  final _authStateChanges = FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: _authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return const BottomNavBar();
          }
          return const LogInScreen();
        },
      ),
    );
  }
}
