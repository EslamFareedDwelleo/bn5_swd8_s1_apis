import 'package:bn5_swd8_s1_apis/features/products/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          Hero(
            tag: product.id,
            child: Image.network(
              product.thumbnail,
              width: MediaQuery.sizeOf(context).width,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  product.title,
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ),
              Text(
                product.price.toString(),
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          Text(product.description),
          Text(product.category),
        ],
      ),
    );
  }
}
