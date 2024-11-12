import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tripaz/screens/detail_booking_screen.dart';
import 'package:tripaz/screens/full_screen_image.dart';
import 'package:tripaz/widgets/bottom_navigation_bar.dart';

class DetailTourScreen extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String tourName;
  final String aboutTour;
  final String questCount;
  final String totalPrice;
  final String coverImage;
  final List<String> allImages;
  final dynamic sedanPrice;
  final dynamic minivanPrice;
  final dynamic airportPickUpPrice;
  const DetailTourScreen({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.tourName,
    required this.aboutTour,
    required this.questCount,
    required this.totalPrice,
    required this.coverImage,
    required this.allImages,
    required this.sedanPrice,
    required this.minivanPrice,
    required this.airportPickUpPrice,
  });

  @override
  State<DetailTourScreen> createState() => _DetailTourScreenState();
}

class _DetailTourScreenState extends State<DetailTourScreen> {
  final List<String> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Tour Detail",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
      ),
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
                            Image.network(
                              widget.coverImage,
                              height: 400,
                              fit: BoxFit
                                  .fill, // Resmi yatay olarak ekranı kaplayacak şekilde ayarlar
                            ),
                            Positioned(
                              bottom: 25,
                              left: 45,
                              child: Text(
                                widget.tourName,
                                style: const TextStyle(
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
                            Text(widget.aboutTour),
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
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemCount: widget.allImages.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Tıklandığında yeni bir sayfa aç
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FullscreenImage(
                                            images: widget.allImages,
                                            initialIndex: index,
                                          ),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
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
                                      child: Image.network(
                                        widget.allImages[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
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
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, top: 10, left: 16, right: 16),
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
                            builder: (context) => DetailBookingScreen(
                              userName: widget.userName,
                              userEmail: widget.userEmail,
                              tourName: widget.tourName,
                              sedanPrice: widget.sedanPrice,
                              minivanPrice: widget.minivanPrice,
                              airportPickUpPrice: widget.airportPickUpPrice,
                            ),
                          ),
                        ),
                        child: const Card(
                          color: Color(0XFFF0FA3E2),
                          child: SizedBox(
                            height: 50,
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
          ],
        ),
      ),
    );
  }
}
