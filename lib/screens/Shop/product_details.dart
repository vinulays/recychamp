import 'package:flutter/material.dart';
import 'package:recychamp/models/product.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(product.imageUrl),
            const SizedBox(height:20),
            Text(product.name),
            const SizedBox(height:10),
            Text('Price: \\${product.price.toStringAsFixed(2)}')
            ],
        ),
      ),
    );
  }
}
