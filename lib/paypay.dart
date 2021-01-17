import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:closercafe/checkout_page.dart';

void main() => runApp(PayPay());

class PayPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PayPayPage();
  }
}

class PayPayPage extends StatefulWidget {
  @override
  _PayPayPageState createState() => _PayPayPageState();
}

class _PayPayPageState extends State<PayPayPage> {
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
          leading: Container(),
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
                      top: 30.0, bottom: 30.0, right: 250.0, left: 250.0
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
                    "PayPayアプリを起動し、以下のQRコードを読み取ってください。\n"
                        "PayPayによるQRコード決済が完了し次第、ドリンクは調理されます。",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 50),  //left, top, right, down
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('product').doc('$orderNum').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return QrImage(
                        data: snapshot.data['qr'],
                        size: 350,
                      );
                    } return CircularProgressIndicator();
                  },
                ),
              ),
              Container(
                width: deviceWidth * 0.45,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RaisedButton(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, right: 50.0, left: 50.0
                    ),
                    child: Text(
                      "次へ",
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
                  onPressed: () => Navigator.of(context).pushReplacementNamed("/confirm"),
                ),
              ),
            ],
          ),
        )
    );
  }
}