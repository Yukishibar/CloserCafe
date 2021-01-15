import 'package:closercafe/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(Confirm());

class Confirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConfirmPage(
          title: 'Flutter Demo Home Page'
      ),
    );
  }
}

class ConfirmPage extends StatefulWidget {
  ConfirmPage({Key key, this.title,}) : super(key: key);

  final String title;

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  //int order_num;
  String product = 'aaa';
  int number; //個数
  int price;

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    product = prefs.get('product') ?? 'ドリンク';
    number = prefs.get('number') ?? 0;
    price = prefs.get('price') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          //戻るボタンをなくす
          leading: Container(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/CloserCafe.png",
                fit: BoxFit.contain,
                height: 45,
              ),
            ],
          ),
        ),
        body: Center(
          //margin: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 20, 30),
                child: Flexible(
                  child: Container(
                    child: Text(
                      "ご利用ありがとうございました。\n商品ができるまでもう少しお待ちください。",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 240.0, left: 240.0
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "ご注文内容\n",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        //"オーダー番号 : $order_num \n"
                            "$product    ×  $number    $price 円 ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                color: Colors.grey[200],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: RaisedButton(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, right: 50.0, left: 50.0
                    ),
                    child: Text(
                      "閉じる",
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

  initState() {
    super.initState();
    _getData();
  }
}