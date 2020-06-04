import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tefood/model/user_model.dart';
import 'package:tefood/screens/main_rider.dart';
import 'package:tefood/screens/main_shop.dart';
import 'package:tefood/screens/main_user.dart';
import 'package:tefood/utility/my_style.dart';
import 'package:tefood/utility/normal_dialog.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String user, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[
              Colors.white,
              MyStyle().primaryColor,
            ],
            radius: 1.0,
            center: Alignment(0, -0.3),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyStyle().showLogo(),
                MyStyle().mySizedbox,
                MyStyle().showTitle('Te Food'),
                MyStyle().mySizedbox,
                userForm(),
                MyStyle().mySizedbox,
                passwordForm(),
                MyStyle().mySizedbox,
                loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => Container(
        width: 250.0,
        height: 45.0,
        child: RaisedButton(
          color: MyStyle().darkColor,
          onPressed: () {
            print('user = $user, password = $password');
            if (user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              narmalDialog(context, 'มีช่องว่าง กรุณากรอกให้ครบ ค่ะ');
            } else {
              chackAuthen();
            }
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      );

  Future<Null> chackAuthen() async {
    String url =
        'http://192.168.1.37/tefood/getUserWhereUser.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      print('res = $response');
      if (response.toString() != 'null') {
        var result = json.decode(response.data);
        print('result = $result');
        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);
          if (password == userModel.password) {
            String chooseType = userModel.chooseType;
            if (chooseType == 'User') {
              routTuService(MainUser(), userModel);
            } else if (chooseType == 'Shop') {
              routTuService(MainShop(),userModel);
            } else if (chooseType == 'Rider') {
              routTuService(MainRider(),userModel);
            } else {
              narmalDialog(context, 'Error');
            }
          } else {
            narmalDialog(context, 'password ผิด กรุณาลองใหม่ ค่ะ');
          }
        }
      } else {
        narmalDialog(context, 'ไม่มีข้อมูล $user กรุณาลองใหม่ ค่ะ');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> routTuService(Widget myWidget, UserModel userModel)async {

    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('id', userModel.id);
    preferences.setString('ChooseType', userModel.chooseType);
    preferences.setString('Name', userModel.name);

    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().darkColor,
            ),
            labelText: 'User : ',
            labelStyle: TextStyle(
              color: MyStyle().darkColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyStyle().darkColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyStyle().primaryColor,
              ),
            ),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().darkColor,
            ),
            labelText: 'Password : ',
            labelStyle: TextStyle(
              color: MyStyle().darkColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyStyle().darkColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyStyle().primaryColor,
              ),
            ),
          ),
        ),
      );
}
