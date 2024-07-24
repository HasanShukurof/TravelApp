import 'package:flutter/material.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wishlist',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 33,
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    child: Image.asset(
                      'assets/images/goygol.jpeg',
                      height: 122,
                      width: 122,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Camping 1 night at LakeSide',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'GoyGol Ganja',
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        children: [
                          Text(
                            'From \$50',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " / person",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/divider.png'),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    child: Image.asset(
                      'assets/images/shamakhi.jpeg',
                      height: 122,
                      width: 122,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Balloon ride',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Shamakhi',
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        children: [
                          Text(
                            'From \$45',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " / person",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset('assets/images/divider.png'),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    child: Image.asset(
                      'assets/images/baku.jpeg',
                      height: 122,
                      width: 122,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Old Town City tour',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Baku city',
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        children: [
                          Text(
                            'From \$30',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " / person",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
