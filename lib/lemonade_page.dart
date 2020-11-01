import 'package:closercafe/checkout_page.dart';
import 'package:closercafe/custom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LemonadeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/CloserCafe.png'),
              RaisedButton(
                child: Text('カスタム'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomMenu()
                    ),
                  );
                },
              ),
              Image.asset('images/lemonade.jpg'),
              RaisedButton(
                child: Text('お会計'),
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
        )
    );
  }
}