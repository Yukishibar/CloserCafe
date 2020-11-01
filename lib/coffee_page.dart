import 'package:closercafe/checkout_page.dart';
import 'package:closercafe/coffee1.dart';
import 'package:closercafe/custom_page.dart';
import 'package:closercafe/lemonade_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:closercafe/logo.dart';

//Statelessはアプリが動作途中でもウィジェットが変化しない
class CoffeeMenu extends StatelessWidget {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //ドリンクセレクト
              _drinkSelect(context),
              //リストビュー
              Flexible(
                  child: CoffeeSelect()
              ),
              //お会計ボタン
              _paycheckBotton(context),
            ]
        ),
      ),
    );
  }

  //コーヒー，レモネード，カスタム選択画面
  Widget _drinkSelect(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        //黒フチで囲うかどうか
        border: Border.all(color: Colors.black38),
        //color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(CoffeeBeans.coffeebeans),
                  Text(
                    "コーヒー",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                //コーヒーの商品ページでここを押しても遷移しないようにする
              },
            ),
            FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(Lemonade.lemonade),
                  Text(
                    "レモネード",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LemonadeMenu()
                  ),
                );
              },
            ),
            FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(Custom.custom),
                  Text(
                    "カスタム",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomMenu()
                  ),
                );
              },
            ),
          ]
      ),
    );
  }

  //お会計ボタン
  Widget _paycheckBotton(BuildContext context){
    return  Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 15.0, bottom: 15.0, right: 50.0, left: 50.0
                ),
                child: Text(
                  'お会計',
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
        )
    );
  }
}

//リストビュー
class CoffeeSelect extends StatelessWidget {
  Widget build(BuildContext context) {
    //商品の写真
    var imageList = [
      _imageItem("coffee1"), _imageItem("coffee2"), _imageItem("coffee3"),
      _imageItem("coffee4"), _imageItem("coffee5"), _imageItem("coffee6"),
      _imageItem("coffee7"), _imageItem("coffee8"), _imageItem("coffee9"),
    ];

    //商品名
    List<String> name = [
      "コーヒー1", "コーヒー2", "コーヒー3",
      "コーヒー4", "コーヒー5", "コーヒー6",
      "コーヒー7", "コーヒー8", "コーヒー9",
    ];

    //金額
    List<String> price = [
      "100円", "200円", "430円",
      "210円", "310円", "920円",
      "280円", "540円", "820円",
    ];
    return Scaffold(
      body: Container(
        child: GridView.count(
          crossAxisCount: 3,  //横方向に並べる数
          crossAxisSpacing: 15.0, // 縦
          mainAxisSpacing: 10.0, // 横
          childAspectRatio: 0.8, // 高さ

          //グリッドのリストに表示させる情報
          children: List.generate(9, (index) {
            return Container(
                alignment: Alignment.center,
                //ボックスの装飾
                decoration: BoxDecoration(
                  //黒フチで囲うどうか
                  //border: Border.all(color: Colors.black26),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                //画面内の余白設定
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      //グリッドの画像の角を丸く表示
                      borderRadius: BorderRadius.circular(20),
                      child: imageList[index],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 15.0),
                                //商品名のテキスト編集
                                child: Text(
                                  name[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                //価格のテキスト編集
                                child: Text(
                                  price[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 5.0, bottom: 5.0, right: 3.0, left: 3.0
                                  ),
                                  child: Text(
                                    "Order",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                color: Colors.orange[400],
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Coffee1()
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            );
          }),
        ),
      ),
    );
  }

  //商品写真のURL処理
  Widget _imageItem(String name) {
    var image = "images/" + name + ".jpg";
    return Container(
      child: Image.asset(image, fit: BoxFit.cover,),
    );
  }
}