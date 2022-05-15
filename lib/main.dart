import 'package:flutter/material.dart';
import 'package:food_recipe_app/splash.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FOOD RECIPE',
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      home:Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
