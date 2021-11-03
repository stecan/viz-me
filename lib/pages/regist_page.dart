import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dummy_page.dart';
import 'login_page.dart';

class Regist extends StatefulWidget {
  Regist({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _RegistState createState() => _RegistState();
}

class _RegistState extends State<Regist> {

  String email='';
  String password='';

  String infoText='';

  void _signUpWithEmailAndPassword() async {
    try {
      // メール・パスワードでユーザ登録
      final FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      // ユーザ登録に成功した場合
      // TOP画面に遷移
      await Navigator
          .of(context)
          .pushReplacement(
          MaterialPageRoute(builder: (context) {
            return Dummy(title: '',);
          })
      );
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      setState(() {
        infoText = "登録に失敗しました。：${e.toString()}";
      });
    } catch (e) {
      print(e);
      setState(() {
        infoText = "登録に失敗しました。：${e.toString()}";
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
                },
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Type your password',
                  labelText: 'password',
                ),
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Text(infoText),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Sign Up',),
                  onPressed: _signUpWithEmailAndPassword,
                ),
              ),
              Container(
                width: double.infinity,
                child: TextButton(
                  child: Text('アカウントをお持ちの方はこちら',),
                  onPressed: () {
                    print('Go To Loginボタンが押されました。');
                    Navigator
                        .of(context)
                        .pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return Login(title: 'ログイン',);
                        })
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}