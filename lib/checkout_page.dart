import 'package:closercafe/confirm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CheckoutMenu extends StatelessWidget {
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
                    "オーダー番号　　1234567890",
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
                    "樋口おすすめのコーヒー　　×1   400円",
                    style: TextStyle(
                      fontSize: 18,
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
                    "大谷おすすめのコーヒー　　×1   500円",
                    style: TextStyle(
                      fontSize: 18,
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
                    "俺のコーヒー　　×2   1000円",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              Flexible(child: Image.asset('images/QR1.jpg')),
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