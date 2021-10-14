import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class Dummy extends StatefulWidget {
  Dummy({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  int _counter = 100;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                "ログインに成功しました。"
            ),
            Text("認証状態："),
            TextButton(
                child: Text("ログイン画面に戻る"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Login(title: "rogin")
                  ));
                }
            )
          ],
        ),
      ),
    );
  }
}