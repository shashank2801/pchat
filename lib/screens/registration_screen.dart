
import 'package:flutter/material.dart';
import 'package:pchat/components/Button.dart';
import 'package:pchat/services/authService.dart';

import 'package:provider/provider.dart';

import '../constants.dart';
import '../routes.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override

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
              text: 'Register',
              color: Colors.blueAccent,
              onPressed: (){
                context.read<AuthenticationService>().signUp(
                  email: email,
                  password: password
                );
                Navigator.popAndPushNamed(context, Routes.login_screen);
                //Navigator.pushReplacementNamed(context, Routes.chat_screen);

              }
              
            ),
          ],
        ),
      ),
    );
  }
}
