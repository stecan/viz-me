import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viz_me/pages/regist_page.dart';
import 'package:viz_me/pages/reset_password_page.dart';
import 'package:viz_me/pages/send_verifiy_mail_page.dart';

import 'dummy_page.dart';

class Login extends StatefulWidget {
  Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int _counter = 100;

  // メッセージ表示用
  String infoText = '';

  // 入力メールアドレス
  String email = '';

  // 入力パスワード
  String password = '';

  // メール/パスワードでログイン試行
  void _loginExec() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ログインに成功した場合
      // トップ画面に遷移＋ログイン画面を破棄
      final _isVerified = await _auth.currentUser!.emailVerified;
      if (_isVerified) {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return Dummy(
              title: '',
            );
          }),
        );
      } else {
        await _auth.currentUser!.sendEmailVerification();

        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) {
            return SendVerifyMail(
              title: '未認証',
              from: 1,
            );
          }),
        );
      }
    } catch (e) {
      // ログインに失敗した場合
      setState(() {
        infoText = "ログインに失敗しました：${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(infoText),
                // メールアドレス入力
                TextFormField(
                  decoration: InputDecoration(labelText: 'メールアドレス'),
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                // パスワード入力
                TextFormField(
                  decoration: InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                FlatButton(
                  onPressed: _loginExec,
                  color: Colors.blue,
                  child: Text(
                    'ログイン',
                  ),
                ),
                TextButton(
                    child: Text("アカウント登録"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Regist(title: "登録画面")));
                    }),
                TextButton(
                    child: Text("パスワードを忘れた場合"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ResetPassword(title: "パスワードリセット")));
                    }),
              ],
            ),
          ),
        ));
  }
}
