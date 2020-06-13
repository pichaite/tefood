import 'package:flutter/material.dart';
import 'package:tefood/screens/home.dart';
import 'package:tefood/utility/my_style.dart';
import 'package:tefood/utility/signout_process.dart';

class MainRider extends StatefulWidget {
  @override
  _MainRiderState createState() => _MainRiderState();
}

class _MainRiderState extends State<MainRider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text('Main Rider '),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              signOutProcess(context);
            },
          ),
        ],
      ),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: [
            showHeader(),
          ],
        ),
      );

  UserAccountsDrawerHeader showHeader() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('rider.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(
        'Rider Login',
        style: TextStyle(color: MyStyle().darkColor),
      ),
      accountEmail: Text(
        'Login',
        style: TextStyle(color: MyStyle().primaryColor),
      ),
    );
  }
}
