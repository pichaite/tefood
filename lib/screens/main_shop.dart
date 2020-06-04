import 'package:flutter/material.dart';
import 'package:tefood/screens/home.dart';
import 'package:tefood/utility/my_style.dart';
import 'package:tefood/utility/signout_process.dart';
import 'package:tefood/widget/infomation_shop.dart';
import 'package:tefood/widget/list_food_menu_shop.dart';
import 'package:tefood/widget/order_lost_shop.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  // Field
  Widget currentWidget = OrderListShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text('Main Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // exit(0);
              signOutProcess(context);
            },
          ),
        ],
      ),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: [
            showHeader(),
            homeMenu(),
            foodMenu(),
            infomationMenu(),
            Divider(),
            signOutMenu(),
          ],
        ),
      );

  ListTile homeMenu() {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text('รายการอาหารที่ลูกค้าสั่ง'),
      subtitle: Text('รายการอาหารที่ยังไม่ได้ ทำส่งลูกค้า'),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = OrderListShop();
        });
      },
    );
  }

  ListTile foodMenu() {
    return ListTile(
      leading: Icon(Icons.fastfood),
      title: Text('รายการอาหาร'),
      subtitle: Text('รายการอาหาร'),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ListFoodMenuShop();
        });
      },
    );
  }

  ListTile infomationMenu() {
    return ListTile(
      leading: Icon(Icons.info),
      title: Text('รายละเอียดของร้าน'),
      subtitle: Text('รายละเอียด ของร้าน พร้อม Edit'),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = InfomationShop();
        });
      },
    );
  }

  ListTile signOutMenu() {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Sign Out'),
      subtitle: Text('Sign Out และ กลับไปหาหน้าแรก'),
      onTap: () {
        signOutProcess(context);
      },
    );
  }

  UserAccountsDrawerHeader showHeader() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('shop.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('Name Shop'),
      accountEmail: Text('Login'),
    );
  }
}
