import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pchat/components/Button.dart';
import 'package:pchat/components/colors.dart';
import 'package:pchat/components/title.dart';
import 'package:pchat/services/authService.dart';
import 'package:provider/provider.dart';

import '../components/constants.dart';
import '../routes.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String username, email, password;
  FirebaseAuth auth = FirebaseAuth.instance;
  final DateTime timestamp = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  child: Image.asset(
                    'images/background.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                      ),
                      CustomText(
                        title: 'Hello',
                        size: 30,
                        color: white,
                      ),
                      CustomText(
                        title: 'Sign Up',
                        size: 50,
                        weight: FontWeight.bold,
                        color: white,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        username = value.toString().trim();
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          icon: Icon(
                            Icons.face,
                            color: Colors.grey,
                          ),
                          hintText: 'Enter your name'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }

                        if (!value.contains("@")) return "Invalid Email";
                        return null;
                      },
                      onChanged: (value) {
                        email = value.toString().trim();
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          icon: Icon(
                            Icons.mail,
                            color: Colors.grey,
                          ),
                          hintText: 'Enter your email'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password = value.toString().trim();
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          hintText: 'Enter your password'),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Button(
                      text: 'Register',
                      color: Colors.blueAccent,
                      onPressed: () async{
                        if (_formKey.currentState.validate()) {
                          final message = await context
                              .read<AuthenticationService>()
                              .signUp(email: email, password: password);

                          if (message == "Signed Up") {
                            print('hello');
                            context.read<AuthenticationService>().addUserToDB(
                                uid: auth.currentUser.uid,
                                username: username,
                                email: auth.currentUser.email,
                                timestamp: timestamp);
                            Navigator.popAndPushNamed(
                                context, Routes.login_screen);
                          }

                          else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
