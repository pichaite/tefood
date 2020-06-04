import 'package:flutter/material.dart';

class MyStyle {
  SizedBox mySizedbox = SizedBox(
    height: 16.0,
    width: 8.0,
  );

  Color darkColor = Colors.blue.shade900;
  Color primaryColor = Colors.green;

  Container showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('assets/images/logo.png'),
    );
  }

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget titleCenter(BuildContext context,String string) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.5,
        child: Text(
          string,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );

  BoxDecoration myBoxDecoration(String namePic) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/$namePic'),
        fit: BoxFit.cover,
      ),
    );
  }

  MyStyle();
}
