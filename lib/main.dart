import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:san_travel/firebase_options.dart';
import 'package:san_travel/screens/login_screen.dart';
import 'package:san_travel/widgets/bottom_navigation_bar.dart';

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
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        setState(
          () {
            _user = user;
            _isLoading = false; // Yükleme bittiğinde bayrağı false yap
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Oturum durumu kontrol edilirken geçici bir yüklenme ekranı göster
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _user == null ? const LogInScreen() : const BottomNavBar(),
    );
  }
}
