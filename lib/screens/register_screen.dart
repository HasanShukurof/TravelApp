import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripaz/screens/login_screen.dart';
import 'package:tripaz/services/auth_service.dart';
import 'package:tripaz/services/user_preferences.dart';
import 'package:tripaz/widgets/bottom_navigation_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  final auth = FirebaseAuth.instance;
  bool _isPasswordVisible =
      false; // Şifrenin görünürlüğünü kontrol eden değişken

  // final _firestore = FirebaseFirestore.instance;

  // Future<void> signUp() async {
  //   if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Lütfen tüm alanları doldurun')),
  //     );
  //     return;
  //   }

  //   try {
  //     UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //             email: _emailController.text, password: _passwordController.text);

  //     await _firestore.collection('users').doc(userCredential.user!.uid).set({
  //       'uid': userCredential.user!.uid,
  //       'email': _emailController.text,
  //     });

  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const HomeScreen(),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Kayıt sırasında bir hata oluştu: $e')),
  //     );
  //   }
  // }

  bool _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            const Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 30),
                            TextField(
                              keyboardType: TextInputType.name,
                              controller: _fullNameController,
                              decoration: InputDecoration(
                                labelText: 'Full name',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF94A3B8)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF94A3B8)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                hintText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF94A3B8)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF94A3B8)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              obscureText:
                                  !_isPasswordVisible, // Şifre gizli mi, değil mi?,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                hintText: 'Password',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF94A3B8)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF94A3B8)),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible =
                                          !_isPasswordVisible; // Değeri tersine çevirir
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0XFFF39C4FF),
                                ),
                                onPressed: () async {
                                  // signUp();
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    final user = await _auth.registerWithEmail(
                                        _fullNameController.text,
                                        _emailController.text,
                                        _passwordController.text);
                                    // await _auth.saveUserToFirestore(
                                    //     auth.currentUser!, 'with email and paswword');
                                    if (user != null && mounted) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BottomNavBar(),
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    if (mounted) {
                                      setState(() {
                                        _showErrorDialog(e.toString());
                                      });
                                    }
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  }
                                },
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LogInScreen(),
                                    ));
                              },
                              child: const Text(
                                'Already have an account',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      const Text(
                        'Or continue',
                        style: TextStyle(
                          color: Color.fromARGB(255, 139, 139, 139),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              final user = await _auth.signInWithGoogle();
                              if (user != null && mounted) {
                                final userId = user.uid;
                                // Kullanıcı bilgilerini SharedPreferences'e kaydet
                                await UserPreferences.saveUserData(
                                    userId, user.displayName ?? 'User');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavBar(userId: userId),
                                  ),
                                );
                              } else {
                                if (mounted) {
                                  _showErrorDialog(
                                      'Google ile giriş başarısız oldu. Lütfen tekrar deneyin.');
                                }
                              }
                            } catch (e) {
                              if (mounted) {
                                _showErrorDialog(
                                    'Giriş hatası: ${e.toString()}');
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/google_icon.png',
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Login with Google',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
