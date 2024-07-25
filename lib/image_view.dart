import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String image;
  const MyWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              image,
              width: 400,
              height: 400,
            ),
          ],
        ),
      ),
    );
  }
}
