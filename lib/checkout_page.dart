import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

int orderNum = 1;

void main() => runApp(CheckoutPage());

class CheckoutPage extends StatelessWidget {
  final String product;
  final int menu;
  final String qr = '0';
  int number;
  int total;

  CheckoutPage({Key key, this.product, this.menu, this.number, this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
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
                width: deviceWidth * 0.94,
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
                    "お客様のオーダー番号は　$orderNum　です。",
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
                      top: 40.0, bottom: 40.0, right: 120.0, left: 120.0
                  ),
                  child: Text(
                    "$product       ×  $number        $total 円 ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              Container(
                width: deviceWidth * 0.94,
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

              AddInfo("$menu", total, "$qr", number, "$product"),

              Container(
                width: deviceWidth * 0.85,
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                  color: Colors.white,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false),
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
  final int _total;
  final String _qr;
  final int _number;
  final String _product;

  AddInfo(this._menu, this._total, this._qr, this._number, this._product);

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('product', _product);
    await prefs.setInt('number', _number);
    await prefs.setInt('total', _total);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference product = firestore.collection("product");

    Future<void> addInfo() async{
      return await product.doc("$orderNum").set({
        "menu" : _menu,
        "total" : _total,
        "qr" : _qr,
      })
          .then((value) => print("Order Information(menu, price, qr) Added"))
          .catchError((error) => print("Failed to add information: $error"));
    }

    //データ送信ボタン
    return Container(
      width: deviceWidth * 0.85,
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
                color: Colors.white,
              ),
            ),
          ),
          color: Colors.teal[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: (){
            _saveData();
            addInfo();
            Navigator.pushNamedAndRemoveUntil(context, "/paypay", (_) => false);
          }
      ),
    );
  }
}