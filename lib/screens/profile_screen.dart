import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tripaz/screens/login_screen.dart';
import 'package:tripaz/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.userId});

  final String? userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<String?> getUserImage(String? uid) async {
    if (uid == null) return null;
    try {
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userData.exists) {
        return userData['userImage'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FutureBuilder<String?>(
                    future: getUserImage(widget.userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Yüklenme göstergesi olarak placeholder kullanıyoruz.
                        return ClipOval(
                          child: Container(
                            width: 90,
                            height: 90,
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        // Profil resmi gösteriliyor.
                        return ClipOval(
                          child: Image.network(
                            snapshot.data!,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        // Profil resmi yoksa varsayılan bir resim veya simge gösterebilirsiniz.
                        return ClipOval(
                          child: Container(
                            width: 90,
                            height: 90,
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    'Hasan Shukurov',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset('assets/images/divider.png'),
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Booking'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Wishlist'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset('assets/images/divider.png'),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Derleng Legal',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(Icons.edit_document),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Terms and Condition'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.policy_rounded),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text('Privacy policy'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              GestureDetector(
                onTap: () {
                  AuthService().signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogInScreen(),
                      ),
                      (Route<dynamic> route) => false);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(11)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Log Out',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
