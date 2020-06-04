import 'package:flutter/material.dart';
import 'package:tefood/screens/home.dart';
import 'package:tefood/utility/my_style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Te Food',
      theme: ThemeData(
        primarySwatch: MyStyle().primaryColor,
      ),
      home: HomePage(),
    );
  }
}
