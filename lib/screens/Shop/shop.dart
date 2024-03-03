import 'package:flutter/material.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Column(
            children: [Text(" "), Text("Momda Menuri"), Text("Momda Rashmi")]),
      ),
    );
  }
}
