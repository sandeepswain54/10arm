import 'package:flutter/material.dart';

class Featured extends StatefulWidget {
  const Featured({super.key});

  @override
  State<Featured> createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Featured",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            iconSize: 24.0, // Set a suitable icon size
            onPressed: () {
              print("Button pressed");
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
    );
  }
}
