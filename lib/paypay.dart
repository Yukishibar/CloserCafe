import 'package:closercafe/confirm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class paypay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          //戻るボタンの色の変更
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/CloserCafe.png',
                fit: BoxFit.contain,
                height: 45,
              ),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 30.0, bottom: 30.0, right: 270.0, left: 270.0
                  ),
                  child: Text(
                    "PayPayによる支払い",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                color: Colors.grey[200],
              ),

              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 50.0, left: 50.0
                  ),
                  child: Text(
                    "上記の内容で注文を確定します。「注文確定」ボタンを押すと、支払い画面に切り替わります。\n"
                        "「注文確定」ボタンを押してもPayPayによるQRコード決済が完了するまでは、商品は調理されません。",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              //QRコード表示
              QrImage(
                data: 'https://www.yahoo.co.jp',
                size: 300,
              ),

              RaisedButton(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 15.0, bottom: 15.0, right: 50.0, left: 50.0
                  ),
                  child: Text(
                    "次へ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                color: Colors.cyan[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Confirm()
                    ),
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}