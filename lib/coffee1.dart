import 'package:closercafe/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Coffee1Main());
}

class Coffee1Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {

        // エラー時に表示するWidget
        if (snapshot.hasError) {
          return Container(color: Colors.white);
        }

        // Firebaseのinitialize完了したら表示したいWidget
        if (snapshot.connectionState == ConnectionState.done) {
          return Coffee1();
        }

        // Firebaseのinitializeが完了するのを待つ間に表示するWidget
        return Container(color: Colors.red);
      },
    );
  }
}


class Coffee1 extends StatelessWidget {
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
            "樋口おすすめのコーヒー",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/coffee1.jpg'),
              Text(
                "こちらの商品はCloserCafe代表の樋口翔太おすすめの一杯となっています。"
                    "\n特にコーヒー豆はアメリカのマンハッタン産のものを贅沢に使用しています。",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
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

                  //アプリが支払いが終わったら次の番号をセットしたい
                  AddInfo("1234567890","540","0"),

                  //お会計ボタン
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 15.0, bottom: 15.0, right: 50.0, left: 50.0
                      ),
                      child: Text(
                        "お会計",
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
                            builder: (context) => CheckoutMenu()
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


//データ送信ボタンを無くしてお会計ボタンを押したらFirebaseにデータが送信されるようにする
//confirm_pageを参照すること！





//Firebaseにデータを追加する
class AddInfo extends StatelessWidget {
  final String ordernum;
  final String price;
  final String status;

  AddInfo(this.ordernum, this.price, this.status);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference product = firestore.collection("product");

    Future<void> addInfo() async{
      return await product.doc("coffee2").set({
        "ordernum" : ordernum,
        "price" : price,
        "status" : status,
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
          "データ送信",
          style: TextStyle(
            fontSize: 18,
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