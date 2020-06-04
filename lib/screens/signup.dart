import 'package:flutter/material.dart';
import 'package:tefood/utility/my_style.dart';
import 'package:tefood/utility/normal_dialog.dart';
import 'package:dio/dio.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String chooseType, name, user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: [
            showLogo(),
            MyStyle().mySizedbox,
            showAppName(),
            MyStyle().mySizedbox,
            nameForm(),
            MyStyle().mySizedbox,
            userForm(),
            MyStyle().mySizedbox,
            passwordForm(),
            MyStyle().mySizedbox,
            MyStyle().showTitleH2('ชนิดของสมาชิก :'),
            userRadio(),
            shopRadio(),
            riderRadio(),
            MyStyle().mySizedbox,
            registerButton(),
          ],
        ),
      ),
    );
  }

  Widget registerButton() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            height: 45.0,
            child: RaisedButton(
              color: MyStyle().darkColor,
              onPressed: () {
                print(
                    'name = $name, user = $user, password = $password, chooseType = $chooseType');
                if (name == null ||
                    name.isEmpty ||
                    user == null ||
                    user.isEmpty ||
                    password == null ||
                    password.isEmpty) {
                  print('Have Space');
                  narmalDialog(context, 'มีช่องว่าง ค่ะ กรุณากรอกทุกช่อง ค่ะ');
                } else if (chooseType == null) {
                  narmalDialog(context, 'โปรด เลือกชนิดของผู้สมัคร');
                } else {
                  chackUser();
                }
              },
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      );

  Future<Null> chackUser() async {
    String url = 'http://192.168.1.37/tefood/getUserWhereUser.php?isAdd=true&User=$user';

    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        regidterThread();
      } else {
        narmalDialog(context, 'user นี่ $user มีคนอื่นใช้ไปแล้ว กรุณาเปลี่ยน User ใหม่');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> regidterThread() async {
    String url =
        'http://192.168.1.37/tefood/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType';
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        narmalDialog(context, 'ไม่สามารถ สมัครได้ กรุณาลองใหม่ ค่ะ');
      }
    } catch (e) {
      print(e);
    }
  }

  Row userRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250.0,
          child: Row(
            children: [
              Radio(
                value: 'User',
                groupValue: chooseType,
                onChanged: (value) {
                  setState(
                    () {
                      chooseType = value;
                    },
                  );
                },
              ),
              Text(
                'ผู้สั่งอาหาร',
                style: TextStyle(
                  color: MyStyle().darkColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row shopRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250.0,
          child: Row(
            children: [
              Radio(
                value: 'Shop',
                groupValue: chooseType,
                onChanged: (value) {
                  setState(
                    () {
                      chooseType = value;
                    },
                  );
                },
              ),
              Text(
                'เจ้าของร้านอาหาร',
                style: TextStyle(
                  color: MyStyle().darkColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row riderRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250.0,
          child: Row(
            children: [
              Radio(
                value: 'Rider',
                groupValue: chooseType,
                onChanged: (value) {
                  setState(
                    () {
                      chooseType = value;
                    },
                  );
                },
              ),
              Text(
                'ผู้ส่งอาหาร',
                style: TextStyle(
                  color: MyStyle().darkColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.face,
                  color: MyStyle().darkColor,
                ),
                labelText: 'Name : ',
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
          ),
        ],
      );
  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
          ),
        ],
      );

  Row showAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyStyle().showTitle('Te Food'),
      ],
    );
  }

  Widget showLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().showLogo(),
        ],
      );
}
