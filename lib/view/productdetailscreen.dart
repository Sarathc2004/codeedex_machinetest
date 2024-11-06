// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, use_key_in_widget_constructors

import 'package:codeedex_machinetest/model/productmodel.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Productmodel?;

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Product Details")),
        body: Center(child: Text("Product not found")),
      );
    } else
      return Scaffold(
        appBar: AppBar(
          title: Text(product.partsName ?? "Product Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.partImage ?? "",
                fit: BoxFit.cover,
                height: 300,
              ),
              SizedBox(height: 16.0),
              Text(
                product.partsName ?? "",
              ),
              SizedBox(height: 8.0),
              Text(
                product.description ?? "",
              ),
              SizedBox(height: 8.0),
              Text(
                product.price ?? "",
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_border_purple500_rounded,
                    color: Colors.green,
                  ),
                  Text(
                    product.productRating ?? "",
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
