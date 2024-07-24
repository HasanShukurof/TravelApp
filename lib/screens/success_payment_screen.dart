import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:san_travel/widgets/bottom_navigation_bar.dart';

class SuccesPaymentScreen extends StatefulWidget {
  const SuccesPaymentScreen({super.key});

  @override
  State<SuccesPaymentScreen> createState() => _SuccesPaymentScreenState();
}

class _SuccesPaymentScreenState extends State<SuccesPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF0FA3E2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            Image.asset('assets/images/succes_payment.png'),
            const SizedBox(
              height: 190,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBar(),
                  ),
                );
              },
              child: SizedBox(
                height: 50,
                width: 300,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Back to home',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
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
