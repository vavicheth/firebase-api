import 'package:firebase_api/screens/login_screen.dart';
import 'package:firebase_api/screens/photos_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';

import '../helpers/keystore_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.account_box),
              onPressed: () {
                print(readStorage('userstorage'));
                print(readStorage('pwdstorage'));
              }),
        ],
      ),
      body: _buildBody(),
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _handleSignin() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print('signin ${user.displayName}');
    print('email: ${user.email}');
    print('Phone ${user.phoneNumber}');
    return user;
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
                          child: LoginScreen(),
                        ),
                      );
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
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: RaisedButton(
                  child: Text("Signin with Google"),
                  onPressed: () {
                    _handleSignin().then((user) {
                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: PhotoScreen(
                              user: user,
                            ),
                          ),
                        );
                      } else {
                        print('Login faild');
                      }
                    });
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
