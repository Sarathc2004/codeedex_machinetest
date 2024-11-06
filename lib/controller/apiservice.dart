// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:codeedex_machinetest/model/categorymodel.dart';
import 'package:codeedex_machinetest/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Apiservice with ChangeNotifier {
  bool isloading = false;
  List<Productmodel> productList = [];
  List<Categorymodel> categorylist = [];

  Future fetchproducts() async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse(
        "https://prethewram.pythonanywhere.com/api/parts_categories/");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List decodedData = jsonDecode(response.body);
      productList =
          decodedData.map((data) => Productmodel.fromJson(data)).toList();
      print(productList.map((product) => product.description).toList());
    } else {
      print("API request failed with status: ${response.statusCode}");
    }

    isloading = false;
    notifyListeners();
  }

  Future fetchcategory() async {
    isloading = true;
    notifyListeners();

    final url =
        Uri.parse("https://prethewram.pythonanywhere.com/api/Top_categories/");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("API Response: ${response.body}");

      List decodedData = jsonDecode(response.body);
      categorylist =
          decodedData.map((data) => Categorymodel.fromJson(data)).toList();
      print(
          "Categories: ${categorylist.map((category) => category.catName).toList()}");
    } else {
      print("API request failed with status: ${response.statusCode}");
    }

    isloading = false;
    notifyListeners();
  }
}
