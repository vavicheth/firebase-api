import 'package:firebase_api/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _emailCtrl = TextEditingController();
  var _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
              child: RaisedButton(
                  child: Text("Register"),
                  onPressed: () {
                    _registerByEmail(_emailCtrl.text, _passwordCtrl.text)
                        .then((user) {
                      print('userID: ${user.uid} and email: ${user.email}');
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: LoginScreen()));
                    });
                  }),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: RaisedButton(
                  child: Text("Already have account?"),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: LoginScreen(),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> _registerByEmail(String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user;
  }
}
