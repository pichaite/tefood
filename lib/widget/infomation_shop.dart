import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tefood/model/user_model.dart';
import 'package:tefood/screens/add_info_shop.dart';
import 'package:tefood/screens/edit_info_shop.dart';
import 'package:tefood/utility/my_constant.dart';
import 'package:tefood/utility/my_style.dart';

class InfomationShop extends StatefulWidget {
  @override
  _InfomationShopState createState() => _InfomationShopState();
}

class _InfomationShopState extends State<InfomationShop> {
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDateUser();
  }

  Future<Null> readDateUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');

    String url =
        '${MyConstant().domain}/tefood/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(url).then((value) {
      print('value = $value');
      var result = json.decode(value.data);
      print('result = $result');
      for (var map in result) {
        setState(() {
          userModel = UserModel.fromJson(map);
        });
        print('nameShop = ${userModel.nameShop}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        userModel == null
            ? MyStyle().showProgress()
            : userModel.nameShop.isEmpty
                ? showNoData(context)
                : showListInShop(),
        assAnEditButton(),
      ],
    );
  }

  Widget showListInShop() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            MyStyle().showTitleH2('รายละเอียดร้าน ${userModel.nameShop}'),
            MyStyle().mySizedbox,
            showImage(),
            MyStyle().mySizedbox,
            Row(
              children: [
                MyStyle().showTitleH2('ที่อยู่ของร้าน'),
              ],
            ),
            Row(
              children: [
                Text(userModel.address),
              ],
            ),
            MyStyle().mySizedbox,
            showMap(),
          ],
        ),
      );

  Container showImage() {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Image.network('${MyConstant().domain}${userModel.urlPicture}'),
    );
  }

  Set<Marker> shopMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('shopID'),
        position: LatLng(
          double.parse(userModel.lat),
          double.parse(userModel.lng),
        ),
        infoWindow: InfoWindow(
          title: 'ตำแหน่งร้าน',
          snippet: 'ละติจูต = ${userModel.lat}, ลองติจูต = ${userModel.lng}',
        ),
      ),
    ].toSet();
  }

  Widget showMap() {
    double lat = double.parse(userModel.lat);
    double lng = double.parse(userModel.lng);
    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(target: latLng, zoom: 16.0);

    return Expanded(
      // padding: EdgeInsets.all(10.0),
      // height: 300.0,
      child: GoogleMap(
        initialCameraPosition: position,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: shopMarker(),
      ),
    );
  }

  Widget showNoData(BuildContext context) {
    return MyStyle()
        .titleCenter(context, 'ยังไม่มีข้อมูล กรุณาเพิ่มข้อมูลด้วย ค่ะ');
  }

  Row assAnEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(
                right: 16.0,
                bottom: 16.0,
              ),
              child: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  routeToAddInfo();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void routeToAddInfo() {
    Widget widget = userModel.nameShop.isEmpty ? AddInfoShop() : EditInfoShop();

    MaterialPageRoute route = MaterialPageRoute(builder: (context) => widget);
    Navigator.push(context, route).then((value) => readDateUser());
  }
}
