import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:san_travel/screens/payment_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String guestName;
  final String guestCount;
  final String carType;
  final String phoneNumber;
  final bool isCheckedAirportPickUp;
  final DateTime? startDate;
  final DateTime? endDate;

  const PaymentMethodScreen({
    super.key,
    required this.guestName,
    required this.guestCount,
    required this.carType,
    required this.phoneNumber,
    required this.isCheckedAirportPickUp,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  Future<void> addDataToFirestore() async {
    print("${widget.guestName}");
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final Map<String, dynamic> data = {
      'guestName': widget.guestName,
      'guestCount': widget.guestCount,
      'carType': widget.carType,
      'phoneNumber': widget.phoneNumber,
      'isCheckedAirportPickUp': widget.isCheckedAirportPickUp,
      'startDate': widget.startDate?.toIso8601String(),
      'endDate': widget.endDate?.toIso8601String(),
      'orderDate': FieldValue.serverTimestamp(),
    };

    try {
      await firestore.collection("Sifarish Detallari").add(data);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentScreen(),
        ),
      );
    } catch (e) {
      print("Firestore'a veri eklenirken hata oluştu: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bir hata oluştu: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Confirm and payment",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/goygol.jpeg',
                              fit: BoxFit.cover,
                              height: 70,
                              width: 70,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Gabala Tour",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Order number #837nx38",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset('assets/images/divider.png'),
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 110,
                            child: const Text(
                              "Total price",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: 110,
                              child: const Text(
                                "\$1800",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            " / 3 Person",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset('assets/images/divider.png'),
                      const SizedBox(
                        height: 22,
                      ),
                      ClipRRect(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(28.0),
                          child: Row(
                            children: [
                              Image.asset('assets/images/bank_card.png'),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text("Credit card/debit"),
                              const SizedBox(
                                width: 90,
                              ),
                              const Flexible(
                                child: Icon(Icons.check_circle),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(22.0),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.payments_sharp,
                                size: 40,
                                color: Color(0XFFF0FA3E2),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Cash payment"),
                              SizedBox(
                                width: 93,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: GestureDetector(
              onTap: () async {
                await addDataToFirestore();

                // firestore.collection("Sifarish Detallari").add(data);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const PaymentScreen(),
                //   ),
                // );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0XFFF0FA3E2),
                ),
                height: 60,
                width: double.infinity,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Process Payment',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
