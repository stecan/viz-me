import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SendVerifyMail extends StatefulWidget {
  SendVerifyMail({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _SendVerifyMailState createState() => _SendVerifyMailState();
}

class _SendVerifyMailState extends State<SendVerifyMail> {
  // メッセージ表示用
  String infoText = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _reSendVerifyMail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      setState(() {
        infoText = "再送";
      });
    } catch (e) {
      setState(() {
        infoText = "本人確認メールの送信に失敗しました：${e.toString()}";
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
                Text(_auth.currentUser!.email! + "宛に本人確認メールを送信しました。"),
                FlatButton(
                  child: Text("再送信"),
                  onPressed: _reSendVerifyMail,
                ),
                TextButton(
                    child: Text("ログイン画面に戻る"),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return Login(
                            title: '',
                          );
                        }),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
