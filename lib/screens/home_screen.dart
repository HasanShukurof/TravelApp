import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tripaz/screens/deatail_tour_screen.dart';
import 'package:tripaz/screens/login_screen.dart';
import 'package:tripaz/screens/widgets/heart_icon_widget.dart';
import 'package:tripaz/services/auth_service.dart';
import 'package:tripaz/services/user_preferences.dart';
import 'package:tripaz/widgets/search_text_widget.dart';

import '../model/tour_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.userId});

  final String? userId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance; // Firestore instance
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  List<Tour> tours = []; // Veri depolamak için
  String? currentUsername = '';

  @override
  void initState() {
    super.initState();
    fetchTours().then(
      (_) {
        if (mounted) {
          setState(() {});
          users();
        }
      },
    );
  }

  Future<void> users() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('users').get();
      final documents = querySnapshot.docs;

      for (var element in documents) {
        final username = print('Istifadeci Adlari:  ${element['userName']}');
      }
    } catch (e) {}
  }

  Future<void> fetchTours() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('tourInfo').get();
      tours = querySnapshot.docs
          .map((doc) => Tour.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      // setState() çağrısını buradan kaldırın
    } catch (e) {
      print("XETA BASH VERDI - 1: $e");
    }
  }

  Future<String?> getUserName(String? uid) async {
    if (uid == null) return null;
    try {
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        return userDoc['userName'];
      } else {
        print("Kullanıcı Firestore'da bulunamadı.");
        return null;
      }
    } catch (e) {
      print("Kullanıcı adını alırken hata: $e");
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
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FutureBuilder<String?>(
                        future: UserPreferences.getUserName(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Loading...');
                          } else if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {
                            currentUsername = snapshot.data;
                            return Text('Welcome, ${snapshot.data}');
                          } else {
                            return const Text('Welcome');
                          }
                        },
                      ),
                    ],
                  ),
                  const Text(
                    "Let's Discover the best places",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchText(
                searchController: _searchController,
                onChanged: (p0) {
                  setState(() {
                    searchQuery = p0;
                  });
                  print("Arama Sonuçları: $searchQuery");
                },
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Popular Packages",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 290,
                child: tours.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      ) // Veri yüklenirken göster
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tours.length,
                        itemBuilder: (context, index) {
                          final tour = tours[index];
                          print("Building tour: $tour"); // Her tur için log
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailTourScreen(
                                    userName: currentUsername ?? '',
                                    userEmail: auth.currentUser!.email ?? '',
                                    tourName: tour.tourName,
                                    aboutTour: tour.aboutTour,
                                    questCount: tour.questCount,
                                    totalPrice: tour.totalPrice,
                                    sedanPrice: tour.sedanPrice,
                                    minivanPrice: tour.minivanPrice,
                                    airportPickUpPrice: tour.airportPickUpPrice,
                                    coverImage: tour.coverImage,
                                    allImages: tour.allImages,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                width: 180,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        tour.coverImage,
                                        width: 180,
                                        height: 180,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          print("Error loading image: $error");
                                          return Icon(Icons.error);
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: HeartIcon(),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tour.tourName,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(tour.questCount),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "Total price: ${tour.totalPrice} AZN",
                                                  style: const TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "All Packages",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/gabala.jpeg',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Image.asset(
                                'assets/images/saved_product.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            const Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gabala tour",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "\$380",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(padding: EdgeInsets.all(20)),
            ],
          ),
        ),
      ),
    );
  }
}
