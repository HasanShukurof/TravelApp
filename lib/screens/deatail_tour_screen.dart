import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:san_travel/screens/detail_booking_screen.dart';
import 'package:san_travel/widgets/bottom_navigation_bar.dart';

class DetailTourScreen extends StatefulWidget {
  const DetailTourScreen({super.key});

  @override
  State<DetailTourScreen> createState() => _DetailTourScreenState();
}

class _DetailTourScreenState extends State<DetailTourScreen> {
  final List<String> images = [
    'assets/images/gabala.jpeg',
    'assets/images/goygol.jpeg',
    'assets/images/baku.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Üstten biraz boşluk eklemek isterseniz bu satırı kullanabilirsiniz
                      // SizedBox(height: 90),

                      // Resmi ekran genişliğine yaymak için Container içinde kullanıyoruz
                      Container(
                        // Ekran genişliğini alır
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/gabala.jpeg',
                              height: 400,
                              fit: BoxFit
                                  .fill, // Resmi yatay olarak ekranı kaplayacak şekilde ayarlar
                            ),
                            Positioned(
                              top: 65,
                              right: 45,
                              child: Image.asset(
                                'assets/images/saved_product.png',
                              ),
                            ),
                            Positioned(
                              top: 65,
                              left: 25,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavBar(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 25,
                              left: 45,
                              child: Text(
                                "Gabala Tour",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "About",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Convallis condimentum morbi non egestas enim amet sagittis. Proin sed aliquet rhoncus ut pellentesque ullamcorper sit eget ac.Sit nisi, cras amet varius eget egestas pellentesque. Cursus gravida euismod non...",
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Image.asset("assets/images/divider.png"),
                            const SizedBox(
                              height: 35,
                            ),
                            const Text(
                              "What is included",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 160,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.directions_car,
                                              size: 35,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Comfortable Car ",
                                                    style: TextStyle(
                                                        fontSize: 13.5),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                        width:
                                            10), // Container ve Text arasına boşluk ekler
                                    Expanded(
                                      child: Container(
                                        width: 160,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.group_outlined,
                                                size: 35,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Proffetional guide ",
                                                      style: TextStyle(
                                                          fontSize: 13.5),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 160,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.hotel_rounded,
                                              size: 35,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Pickup hotel / Drop hotel ",
                                                    style: TextStyle(
                                                        fontSize: 13.5),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                        width:
                                            10), // Container ve Text arasına boşluk ekler
                                    Expanded(
                                      child: Container(
                                        width: 160,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.water_drop_rounded,
                                                size: 35,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Free water during the trip",
                                                      style: TextStyle(
                                                          fontSize: 13.5),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 43,
                            ),
                            Image.asset("assets/images/divider.png"),
                            const SizedBox(
                              height: 47,
                            ),
                            SizedBox(
                              height: 400,
                              child: GridView.builder(
                                padding: const EdgeInsets.all(5.0),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Her satırda iki sütun
                                  crossAxisSpacing:
                                      10.0, // Sütunlar arasındaki boşluk
                                  mainAxisSpacing:
                                      10.0, // Satırlar arasındaki boşluk
                                ),
                                itemCount: images.length,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          index % 2 == 0 ? 10 : 0),
                                      bottomLeft: Radius.circular(
                                          index % 2 == 0 ? 10 : 0),
                                      topRight: Radius.circular(
                                          index % 2 == 1 ? 10 : 0),
                                      bottomRight: Radius.circular(
                                          index % 2 == 1 ? 10 : 0),
                                    ),
                                    child: Image.asset(
                                      images[index],
                                      fit: BoxFit
                                          .cover, // Görüntüyü kapsayıcıya sığdır
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Card(
                elevation: BorderSide.strokeAlignCenter,
                child: SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20, top: 20, left: 26, right: 26),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Row(
                            children: [
                              Text(
                                "\$600",
                                style: TextStyle(
                                    color: Color(0XFFF0A7BAB),
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "/ 1-3 pax",
                                style: TextStyle(color: Color(0XFFF0A7BAB)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DetailBookingScreen(),
                              ),
                            ),
                            child: const Card(
                              color: Color(0XFFF0FA3E2),
                              child: SizedBox(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Book Now",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
