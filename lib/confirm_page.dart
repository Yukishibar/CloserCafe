import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:closercafe/checkout_page.dart';

void main() => runApp(Confirm());

class Confirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConfirmPage();
  }
}

class ConfirmPage extends StatefulWidget {
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  String product = 'ドリンク';
  int number = 1; //個数
  int total = 0;

  final ordertime = DateTime.now();

  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    product = prefs.get('product') ?? 'ドリンク';
    number = prefs.get('number') ?? 0;
    total = prefs.get('total') ?? 0;
  }

  SharedPreferences sharedPrefs;

  @override
  initState() {
    super.initState();
    _getData();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 20, 30),
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
              Container(
                width: deviceWidth * 0.94,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 30.0, bottom: 30.0, right: 20.0, left: 20.0
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "ご注文内容",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 35.0),
                          child: Text(
                            "ご注文日時  :  $ordertime",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "オーダー番号    $orderNum \n"
                            "$product    ×    $number        $total 円",
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
                width: deviceWidth * 0.45,
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: RaisedButton(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, right: 50.0, left: 50.0
                    ),
                    child: Text(
                      "閉じる",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  color: Colors.teal[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    orderNum++;
                    Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
                  }
                ),
              ),
            ],
          ),
        )
    );
  }
}