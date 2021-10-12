import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
            FlatButton(
              onPressed: _incrementCounter,
              color: Colors.blue,
              child: Text(
                'リセットメールを送信',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
