import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viz_me/pages/regist_page.dart';
import 'package:viz_me/pages/reset_password.dart';

class Login extends StatefulWidget {
  Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          TextField(
          obscureText:false,
          decoration: const InputDecoration(
            hintText: 'Type your email address',
            labelText: 'email address',
          ),
        ),
        TextField(
          obscureText:true,
          decoration: const InputDecoration(
            hintText: 'Type your password',
            labelText: 'password',
          ),
        ),
        FlatButton(
          onPressed: _incrementCounter,
          color: Colors.blue,
          child: Text(
            'ログイン',
          ),
        ),
        TextButton(
          child: Text("アカウント登録"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Regist(title: "登録画面")
            ));
          }
        ),
        TextButton(
            child: Text("パスワードを忘れた場合"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ResetPassword(title: "パスワードリセット")
              ));
            }
        ),
      ],
    ),
    ),
    );
  }
}
