import 'package:closercafe/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(premiumcoffee());
}

class premiumcoffee extends StatelessWidget {
  final String _product = 'プレミアムコーヒー';
  final int  _number = 1;
  final int  _menu = 2;
  final int _price = 360;

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
            "プレミアムコーヒー",
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
              Image.asset("images/premiumcoffee.png"),
              Container(
                margin: EdgeInsets.fromLTRB(30, 25, 30, 25),  //Left, Top, Right, Under
                child: Text(
                  "最上級グレード豆を使用したプレミアムコーヒー。"
                      "マイルドな口あたりが特徴で、どなたにも親しんでいただけるコーヒーです。",
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
                                  "360円",
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
        )
    );
  }
}
