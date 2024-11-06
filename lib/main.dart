// ignore_for_file: prefer_const_constructors

import 'package:codeedex_machinetest/controller/apiservice.dart';
import 'package:codeedex_machinetest/controller/authservice.dart';
import 'package:codeedex_machinetest/view/loginscreen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Apiservice(),
          ),
          ChangeNotifierProvider(
            create: (context) => Authservice(),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false, home: LoginScreen()));
  }
}
