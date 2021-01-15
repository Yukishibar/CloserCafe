import 'package:closercafe/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(cafelatte());
}

class cafelatte extends StatelessWidget {
  final String _product = 'カフェラテ';
  final int  _number = 1;
  final int  _menu = 1;
  final int  _price = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          centerTitle: true ,
          //戻るボタンの色の変更
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "カフェラテ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("images/cafelatte.png"),
              Container(
                margin: EdgeInsets.fromLTRB(30, 25, 30, 25),  //Left, Top, Right, Under
                child: Text(
                  "厳選したコーヒー豆とフレッシュな味わいのミルクを使い、"
                      "風味豊かに仕上げました。"
                      "深みのあるエスプレッソの香りと豊かなミルクのコク、"
                      "ほどよい甘さがバランスよく引き立てあう贅沢な一杯です。",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(30.0),
                          child: Row(
                              children: [
                                Text(
                                  "300円",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.add_circle,
                                  color: Colors.orange,
                                  size: 40.0,
                                ),
                                Text(
                                  "1個",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.remove_circle,
                                  color: Colors.orange,
                                  size: 40.0,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),

                  //お会計ボタン
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 15.0, bottom: 15.0, right: 50.0, left: 50.0
                      ),
                      child: Text(
                        "カートに追加",
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
                            builder: (context) => Checkout(
                              product: _product,
                              number: _number,
                              menu: _menu,
                              price: _price
                            ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
