import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tefood/utility/my_constant.dart';
import 'package:tefood/utility/my_style.dart';
import 'package:tefood/utility/normal_dialog.dart';

class AddFoodMenu extends StatefulWidget {
  @override
  _AddFoodMenuState createState() => _AddFoodMenuState();
}

class _AddFoodMenuState extends State<AddFoodMenu> {
  File file;
  String nameFood, price, detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการเมนูอาหาร'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            showTitleTopFood('รูปอาหาร'),
            groupImage(),
            showTitleTopFood('รายละเอียด อาหาร'),
            MyStyle().mySizedbox,
            nameForm(),
            MyStyle().mySizedbox,
            priceForm(),
            MyStyle().mySizedbox,
            detailForm(),
            MyStyle().mySizedbox,
            saveButton(),
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: MyStyle().primaryColor,
        onPressed: () {
          if (file == null) {
            narmalDialog(context,
                'กรุณาเลือกรูปภาพ อาหาร โดยการ Tap Camera หรือ Gallery');
          } else if (nameFood == null ||
              nameFood.isEmpty ||
              price == null ||
              price.isEmpty ||
              detail == null ||
              detail.isEmpty) {
            narmalDialog(context, 'กรุณากรอก ทุกช่อง ค่ะ');
          } else {
            print(
                'nameFood = $nameFood, price = $price, detail = $detail Image = ${file.path}');
            uploadFoodAndInsertData();
          }
        },
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'Save Food Menu',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> uploadFoodAndInsertData() async {
    String urlUpload = '${MyConstant().domain}/tefood/saveFood.php';
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'food$i.jpg';
    try {
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);
      await Dio().post(urlUpload, data: formData).then((value) async {
        String urlPathImage = '/tefood/Food/$nameFile';
        print('urlPathImage = ${MyConstant().domain}$urlPathImage');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String idShop = preferences.getString('id');
        String urlInsertData =
            '${MyConstant().domain}/tefood/addFood.php?isAdd=true&idShop=$idShop&NameFood=$nameFood&PathImage=$urlPathImage&Price=$price&Detail=$detail';
        await Dio().get(urlInsertData).then((value) => Navigator.pop(context));
      });
    } catch (e) {}
  }

  Widget nameForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => nameFood = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.fastfood),
            labelText: 'ชื่ออาหาร',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget priceForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => price = value.trim(),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.attach_money),
            labelText: 'ราคาอาหาร',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget detailForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => detail = value.trim(),
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.details),
            labelText: 'รายละเอียดอาหาร',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        Container(
          width: 250.0,
          height: 250.0,
          child: file == null
              ? Image.asset('assets/images/picfood.png')
              : Image.file(file),
        ),
        IconButton(
          icon: Icon(Icons.add_photo_alternate),
          onPressed: () => chooseImage(ImageSource.gallery),
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Widget showTitleTopFood(String string) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: [
          MyStyle().showTitleH2(string),
        ],
      ),
    );
  }
}
