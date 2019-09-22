import 'package:firebase_api/helpers/keystore_helper.dart';
import 'package:firebase_api/helpers/loginbyemail_helper.dart';
import 'package:firebase_api/helpers/preference_helper.dart';
import 'package:firebase_api/screens/photos_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _emailCtrl = TextEditingController();
  var _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: 'Email Address'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: TextField(
                controller: _passwordCtrl,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: RaisedButton(
                  child: Text("Login"),
                  onPressed: () {
                    loginByEmail(_emailCtrl.text, _passwordCtrl.text)
                        .then((user) {
                      saveDataToLocal('useremail', _emailCtrl.text);
                      saveDataToLocal('pwd', _passwordCtrl.text);

                      writeStorage('userstorage', _emailCtrl.text);
                      writeStorage('pwdstorage', _passwordCtrl.text);

                      print('userID: ${user.uid} and email: ${user.email}');
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: PhotoScreen(),
                        ),
                      );
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
