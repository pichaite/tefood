import 'package:flutter/material.dart';
import 'package:tefood/screens/add_info_shop.dart';
import 'package:tefood/utility/my_style.dart';

class InfomationShop extends StatefulWidget {
  @override
  _InfomationShopState createState() => _InfomationShopState();
}

class _InfomationShopState extends State<InfomationShop> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyStyle()
            .titleCenter(context, 'ยังไม่มีข้อมูล กรุณาเพิ่มข้อมูลด้วย ค่ะ'),
        assAnEditButton()
      ],
    );
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
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) => AddInfoShop());
                  Navigator.push(context, route);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
