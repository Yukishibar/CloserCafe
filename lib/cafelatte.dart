import 'package:closercafe/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(cafelatte());
}

class cafelatte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: cafelattePage(title: "cafelatte")
    );
  }
}

class cafelattePage extends StatefulWidget {
  cafelattePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _cafelattePageState createState() => _cafelattePageState();
}

class _cafelattePageState extends State<cafelattePage> {
  final String _product = 'カフェラテ';
  int  _number = 1;
  final int  _menu = 1;
  final int  _price = 300;

  void _incrementCounter() {
    setState(() {
      _number++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _number--;
    });
  }

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
                margin: EdgeInsets.fromLTRB(15, 50, 15, 40),  //Left, Top, Right, Under
                child: Text(
                  "厳選したコーヒー豆とフレッシュな味わいのミルクを使い、"
                      "風味豊かに仕上げました。"
                      "深みのあるエスプレッソの香りと豊かなミルクのコク、"
                      "ほどよい甘さがバランスよく引き立てあう贅沢な一杯です。",
                  style: TextStyle(
                    fontSize: 22,
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
                          margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
                          child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 100, 0),
                                  child: Text(
                                    "300円",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                    width: 45,
                                    margin: EdgeInsets.only(left: 80, right: 10),
                                    child: FloatingActionButton(
                                      heroTag: "hero1",
                                      onPressed: _incrementCounter,
                                      backgroundColor: Colors.teal[400],
                                      child: Icon(
                                        Icons.add,
                                        size: 30,
                                      ),
                                    )
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Text(
                                    "$_number",
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 45,
                                  margin: EdgeInsets.only(left: 20, right: 10),
                                    child: FloatingActionButton(
                                      heroTag: "hero2",
                                      onPressed: _decrementCounter,
                                      backgroundColor: Colors.teal[400],
                                      child: Icon(
                                        Icons.remove,
                                        size: 30,
                                      ),
                                    ),
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
                    color: Colors.teal[400],
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
