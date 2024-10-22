import 'package:flutter/material.dart';

class FullscreenImage extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const FullscreenImage(
      {Key? key, required this.images, required this.initialIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(""),
      ),
      backgroundColor: Colors.black,
      body: PageView.builder(
        itemCount: images.length,
        controller: PageController(initialPage: initialIndex),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Resmin üzerine tıklandığında hiçbir şey yapma
            },
            child: Image.network(images[index], fit: BoxFit.contain),
          );
        },
      ),
    );
  }
}
