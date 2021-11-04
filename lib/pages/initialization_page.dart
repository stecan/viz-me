import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class Initialization extends StatefulWidget {
  Initialization({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _InitializationState createState() => _InitializationState();
}

class _InitializationState extends State<Initialization> {
  // メッセージ表示用
  String infoText = '';

  // 入力ユーザー名
  String userName = '';
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                Text("ユーザー名の設定"),
                Form(
                  key:_formKey,
                    child: Column(
                  children: [
                    TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'Type your nickname',
                        labelText: 'ユーザー名',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ユーザー名を入力してください。';
                        }
                        if (value.length <= 4) {
                          return 'ユーザー名が短すぎます';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          userName = value;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _submitButtonClick();
                        }
                      },
                      child: Text('登録'),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ));
  }

  void _submitButtonClick() async {
    try {
      await _auth.currentUser!.updateDisplayName(userName);
    } catch (e) {}
  }
}
