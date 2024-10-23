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
  // User? _user;
  // bool _isLoading = true;
  final _authStateChanges = FirebaseAuth.instance.authStateChanges();

  // @override
  // void initState() {
  //   super.initState();
  //   _loadUser();
  // }

  // Future<void> _loadUser() async {
  //   FirebaseAuth.instance.authStateChanges().listen(
  //     (User? user) {
  //       setState(
  //         () {
  //           _user = user;
  //           _isLoading = false; // Yükleme bittiğinde bayrağı false yap
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: _authStateChanges,
        builder: (context, snapshot) {
          // Bağlantı bekleniyorsa loading göster
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Kullanıcı oturum açmışsa ana sayfaya, açmamışsa login sayfasına yönlendir
          if (snapshot.hasData) {
            return const BottomNavBar();
          }
          return const LogInScreen();
        },
      ),
    );
  }
}
