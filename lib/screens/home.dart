import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tefood/screens/main_rider.dart';
import 'package:tefood/screens/main_shop.dart';
import 'package:tefood/screens/main_user.dart';
import 'package:tefood/screens/signin.dart';
import 'package:tefood/screens/signup.dart';
import 'package:tefood/utility/my_style.dart';
import 'package:tefood/utility/normal_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chackPreferance();
  }

  Future<Null> chackPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String chooseType = preferences.getString('ChooseType');
      if (chooseType != null && chooseType.isNotEmpty) {
        if (chooseType == 'User') {
          routToservice(MainUser());
        } else if (chooseType == 'Shop') {
          routToservice(MainShop());
        } else if (chooseType == 'Rider') {
          routToservice(MainRider());
        } else {
          narmalDialog(context, 'Error User Type');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void routToservice(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: [
            showHeadDrawer(),
            signInMenu(),
            signUpMenu(),
          ],
        ),
      );
  ListTile signUpMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sign Up'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (value) => SignUp());
        Navigator.push(context, materialPageRoute);
      },
    );
  }

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text('Sign In'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, materialPageRoute);
      },
    );
  }

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('guest.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('Guest'),
      accountEmail: Text('Please Login'),
    );
  }
}
