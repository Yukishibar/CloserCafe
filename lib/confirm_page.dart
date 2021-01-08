import 'package:closercafe/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Confirm extends StatelessWidget {
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
              Flexible(
                child: Container(
                  child: Text(
                    'ご利用ありがとうございました。\n商品ができるまでもう少しお待ちください。',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              GetProductName("coffee4"),

              RaisedButton(
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
                  Map<String, dynamic> updateData = {
                    'status': '1',
                  };
                  FirebaseFirestore.instance.collection("product")
                      .doc("coffee4").update(updateData);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage()
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


//Firebase上のデータを取得する
class GetProductName extends StatelessWidget {
  final String documentId;

  GetProductName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference product = FirebaseFirestore.instance.collection('product');
    return FutureBuilder<DocumentSnapshot>(
      future: product.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Container(
            margin: const EdgeInsets.all(30.0),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, right: 200.0, left: 200.0
              ),
              child: Column(
                children: <Widget> [
                  Text(
                    "ご注文詳細 \n",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "オーダー番号 : ${data['ordernum']} ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "商品名 : 樋口おすすめのコーヒー \n"
                        "金額 : ${data['price']}円 "
                        "状態 : ${data['status']}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            color: Colors.grey[200],
          );
        }
        return Text("loading");
      },
    );
  }
}