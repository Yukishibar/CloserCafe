import 'package:closercafe/main.dart';
import 'package:closercafe/paypay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

int order_num = 1;
//int amount = 0; 合計金額

void main() => runApp(Checkout());

class Checkout extends StatelessWidget {
  final String product; //商品名
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

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('product', product);
    await prefs.setInt('number', number);
    await prefs.setInt('price', price);
  }

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
                    "ご注文内容の確認",
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
                    "お客様のオーダー番号は　$order_num　です。",
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
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 40.0, left: 40.0
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

              AddInfo("$menu","$price","$qr"),

              Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: RaisedButton(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 12.0, bottom: 12.0, right: 270.0, left: 270.0
                    ),
                    child: Text(
                      "キャンセル",
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
                          builder: (context) => MyHomePage()
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}

//Firebaseにデータを追加するウィジェット
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
          .then((value) => print("Order Information(menu, price, qr) Added"))
          .catchError((error) => print("Failed to add information: $error"));
    }

    //データ送信ボタン
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: RaisedButton(
          child: Padding(
            padding: EdgeInsets.only(
                top: 12.0, bottom: 12.0, right: 270.0, left: 270.0
            ),
            child: Text(
              "注文確定",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
          color:Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: (){
            addInfo();
            order_num++;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => paypay(
                    order_num: order_num,
                  )
              ),
            );
          }
      ),
    );
  }
}