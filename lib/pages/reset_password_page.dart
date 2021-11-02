import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // メッセージ表示用
  String infoText = '';

  // 入力メールアドレス
  String email = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _sendPasswordResetEmail() async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      setState(() {
        infoText = 'パスワード再設定用のメールを送信しました。';
      });
    } catch (e) {
      setState(() {
        infoText = "パスワード再設定用のメールを送信に失敗しました：${e.toString()}";
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
                TextField(
                    obscureText: false,
                    decoration: const InputDecoration(
                      hintText: 'Type your email address',
                      labelText: 'email address',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        email = value;
                      });
                    }),
                FlatButton(
                  onPressed: _sendPasswordResetEmail,
                  color: Colors.blue,
                  child: Text(
                    'リセットメールを送信',
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
