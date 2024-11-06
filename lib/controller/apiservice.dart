// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:codeedex_machinetest/model/categorymodel.dart';
import 'package:codeedex_machinetest/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService with ChangeNotifier {
  bool isLoading = false;
  List<Productmodel> productList = [];
  List<Categorymodel> categoryList = [];

  Future<String?> _getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future fetchProducts() async {
    isLoading = true;
    notifyListeners();

    final String? token = await _getAccessToken();
    final url = Uri.parse(
        "https://prethewram.pythonanywhere.com/api/parts_categories/");

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List decodedData = jsonDecode(response.body);
      productList =
          decodedData.map((data) => Productmodel.fromJson(data)).toList();
      print(productList.map((product) => product.description).toList());
    } else {
      print("API request failed with status: ${response.statusCode}");
    }

    isLoading = false;
    notifyListeners();
  }

  Future fetchCategory() async {
    isLoading = true;
    notifyListeners();

    final String? token = await _getAccessToken();
    final url =
        Uri.parse("https://prethewram.pythonanywhere.com/api/Top_categories/");

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print("API Response: ${response.body}");

      List decodedData = jsonDecode(response.body);
      categoryList =
          decodedData.map((data) => Categorymodel.fromJson(data)).toList();
      print(
          "Categories: ${categoryList.map((category) => category.catName).toList()}");
    } else {
      print("API request failed with status: ${response.statusCode}");
    }

    isLoading = false;
    notifyListeners();
  }
}
