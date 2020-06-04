import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tefood/screens/home.dart';

Future<Null> signOutProcess(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => HomePage());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
