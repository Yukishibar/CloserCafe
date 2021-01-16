import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:closercafe/logo.dart';
import 'package:closercafe/cafelatte.dart';
import 'package:closercafe/premiumcoffee.dart';
import 'package:closercafe/lattemacchiato.dart';
import 'package:closercafe/custom_page.dart';
import 'package:closercafe/lemonade_page.dart';
import 'package:closercafe/checkout_page.dart';

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
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //ドリンクセレクト
              //_drinkSelect(context),
              //リストビュー
              Flexible(
                  child: CoffeeSelect()
              ),
              //フッター表示
              //_fotter(context),
            ]
        ),
      );
  }

  //コーヒー，レモネード，カスタム選択画面
  Widget _drinkSelect(BuildContext context){
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 30, 20, 15),
      decoration: BoxDecoration(
        //黒フチで囲うかどうか
        border: Border.all(color: Colors.black38),
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

  Widget _fotter(BuildContext context){
    return Scrollbar(
      isAlwaysShown: false,
      child: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Container(
                height: 80,
                decoration: BoxDecoration(
                  //黒フチで囲うどうか
                    //border: Border.all(color: Colors.black),
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 10.0,
                        blurRadius: 10.0,
                        offset: Offset(15, 15),
                      )
                    ]
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart_sharp,
                      color: Colors.pink,
                      size: 35.0,
                    ),
                    RaisedButton(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, right: 3.0, left: 3.0
                        ),
                        child: Text(
                          "注文へ",
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
                              builder: (context) => Checkout()
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }
}

//リストビュー
class CoffeeSelect extends StatelessWidget {
  Widget build(BuildContext context) {
    //商品の写真
    var imageList = [
      _imageItem("cafelatte"), _imageItem("premiumcoffee"), _imageItem("lattemacchiato"),
    ];

    //商品名
    List<String> name = [
      "カフェラテ", "プレミアムコーヒー", "ラテマキアート",
    ];

    //金額
    List<String> price = [
      "300円", "360円", "320円",
    ];

    //各注文ページへの遷移
    var page = [
      cafelatte(), premiumcoffee(), lattemacchiato(),
    ];

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 25, 20, 25),
        child: GridView.count(
          crossAxisCount: 2,  //横方向に並べる数
          crossAxisSpacing: 20.0, // 縦
          mainAxisSpacing: 20,  //各リストの縦
          childAspectRatio: 0.8, //各リストの高さ

          //グリッドのリストに表示させる情報
          children: List.generate(3, (index) {
            return Container(
                alignment: Alignment.center,
                //ボックスの装飾
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                //画面内の余白設定
                padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      //グリッドの画像の角を丸く表示
                      borderRadius: BorderRadius.circular(15),
                      child: imageList[index],
                    ),
                    Flexible(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
                                    //商品名のテキスト編集
                                    child: Text(
                                      name[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    //価格のテキスト編集
                                    child: Text(
                                      price[index],
                                      style: TextStyle(
                                        fontSize: 25,
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
                                  Container(
                                    margin: EdgeInsets.fromLTRB(75, 18, 0, 0),
                                    child: RaisedButton(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(3, 10, 3, 10),
                                        child: Text(
                                          "注文",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      color: Colors.teal[400],
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => page[index]
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
    var image = "images/" + name + ".png";
    return Container(
      child: Image.asset(image, fit: BoxFit.cover,),
    );
  }
}