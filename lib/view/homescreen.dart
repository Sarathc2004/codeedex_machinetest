// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:codeedex_machinetest/controller/apiservice.dart';
import 'package:codeedex_machinetest/view/productdetailscreen.dart';
import 'package:codeedex_machinetest/view/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchdata();
    });
  }

  Future<void> fetchdata() async {
    await Provider.of<ApiService>(context, listen: false).fetchProducts();
    await Provider.of<ApiService>(context, listen: false).fetchCategory();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Homescreen", style: TextStyle(color: Colors.white)),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ));
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            )
          ],
          backgroundColor: Colors.black,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: "Products"),
              Tab(text: "Categories"),
            ],
          ),
        ),
        body: Consumer<ApiService>(
          builder: (context, provider, child) {
            return TabBarView(
              controller: _tabController,
              children: [
                provider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : provider.productList.isEmpty
                        ? Center(
                            child: Text("No products available",
                                style: TextStyle(color: Colors.white)))
                        : _buildProductGrid(provider),
                provider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : provider.categoryList.isEmpty
                        ? Center(
                            child: Text("No categories available",
                                style: TextStyle(color: Colors.white)))
                        : _buildCategoryGrid(provider),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductGrid(ApiService provider) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemCount: provider.productList.length,
      itemBuilder: (context, index) {
        final product = provider.productList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(),
                settings: RouteSettings(arguments: product),
              ),
            );
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product.partImage ?? ""),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.partsName ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product.price ?? "",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryGrid(ApiService provider) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: provider.categoryList.length,
      itemBuilder: (context, index) {
        final category = provider.categoryList[index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
          ),
          child: Center(
            child: Text(
              category.catName ?? "",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
