
import 'package:flutter/material.dart';
import 'package:pchat/components/Button.dart';
import 'package:pchat/services/authService.dart';
import 'package:pchat/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

import '../constants.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final _auth = FirebaseAuth.instance;
  FirebaseAuth _firebaseAuth;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'Logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/groupicon.jpg'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value.toString().trim();
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email.'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                password = value.toString().trim();
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password.'),
            ),
            SizedBox(
              height: 24.0,
            ),
            Button(
              text: 'Log In',
              color: Colors.lightBlueAccent,
              onPressed: () {

                context.read<AuthenticationService>().signIn(
                  email: email,
                  password: password
                );

                

                // String ans = await AuthenticationService(_firebaseAuth).signIn();
                // if(ans == "Signed In")
                //   Navigator.pushReplacementNamed(context, Routes.chat_screen);


              },
            ),
          ],
        ),
      ),
    );
  }
}
