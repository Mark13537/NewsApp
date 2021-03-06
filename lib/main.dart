import 'package:flutter/material.dart';
import 'package:news_app/UI/BottomNavigationBarMenu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavigationBarMenu(
        index: 0,
      ),
    );
  }
}
