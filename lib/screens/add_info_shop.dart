import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tefood/utility/my_style.dart';

class AddInfoShop extends StatefulWidget {
  @override
  _AddInfoShopState createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มข้อมูลร้านค้า'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyStyle().mySizedbox,
            nameForm(),
            MyStyle().mySizedbox,
            addressForm(),
            MyStyle().mySizedbox,
            phoneForm(),
            MyStyle().mySizedbox,
            groupImage(),
            MyStyle().mySizedbox,
            showMap(),
            MyStyle().mySizedbox,
            saveButton(),
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: MyStyle().primaryColor,
        onPressed: () {},
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'Save Infomation',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Container showMap() {
    LatLng latLng = LatLng(15.965910, 99.765835);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 16.0);

    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (conyroller) {},
      ),
    );
  }

  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: Icon(
              Icons.add_a_photo,
              size: 36.0,
            ),
            onPressed: () {}),
        Container(
          width: 250.0,
          child: Image.asset('assets/images/pic.png'),
        ),
        IconButton(
            icon: Icon(
              Icons.add_photo_alternate,
              size: 36.0,
            ),
            onPressed: () {}),
      ],
    );
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'ชื่อร้านค้า :',
                prefixIcon: Icon(Icons.account_box),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget addressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'ที่อยู่ร้านค้า :',
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
  Widget phoneForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'เบอร์ติดต่อร้านค้า :',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
