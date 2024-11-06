// ignore_for_file: use_key_in_widget_constructors, sort_child_properties_last

import 'package:codeedex_machinetest/controller/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loginscreen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authService.logout();

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: const Icon(Icons.logout),
        tooltip: 'Logout',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
              SizedBox(height: 16),
              Text(
                "John",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "john@mail.com",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
