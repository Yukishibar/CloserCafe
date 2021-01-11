import 'package:closercafe/confirm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

String order_num = "1";
//int amount = 0; 合計金額

main () {
  runApp(Checkout());
}

class Checkout extends StatelessWidget {
  final String product;
  final int number; //個数
  final int menu;
  final String qr = "0";

  int price = 300;  //Firestoreテスト用

  Checkout({
    Key key,
    this.product,
    this.number,
    this.menu,
  }) : super(key: key);

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
                      top: 20.0, bottom: 20.0, right: 300.0, left: 300.0
                  ),
                  child: Text(
                    "支払い詳細",
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
                      top: 20.0, bottom: 20.0, right: 120.0, left: 120.0
                  ),
                  child: Text(
                    "オーダー番号　  $order_num",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 120.0, left: 120.0
                  ),
                  child: Text(
                    "ご注文日時 : 2020/10/24 17:26",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 120.0, left: 120.0
                  ),
                  child: Text(
                    "・$product       ×  $number        $price 円 ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              AddInfo("$menu","$price","$qr"),

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
                        builder: (context) => Confirm(
                          order_num: order_num,
                          product: product,
                          number: number,
                        ),
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

//Firebaseにデータを追加する
class AddInfo extends StatelessWidget {
  final String _menu;
  final String _price;
  final String _qr;

  AddInfo(this._menu, this._price, this._qr);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference product = firestore.collection("product");

    Future<void> addInfo() async{
      return await product.doc("$order_num").set({
        "menu" : _menu,
        "price" : _price,
        "qr" : _qr,
      })
          .then((value) => print("Order Information Added"))
          .catchError((error) => print("Failed to add information: $error"));
    }

    //データ送信ボタン
    return RaisedButton(
      child: Padding(
        padding: EdgeInsets.only(
            top: 15.0, bottom: 15.0, right: 50.0, left: 50.0
        ),
        child: Text(
          "注文確定",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      color:Colors.orangeAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: addInfo,
    );
  }
}