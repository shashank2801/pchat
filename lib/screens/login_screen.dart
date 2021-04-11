import 'package:flutter/material.dart';
import 'package:pchat/components/Button.dart';
import 'package:pchat/components/colors.dart';
import 'package:pchat/components/title.dart';
import 'package:pchat/services/authService.dart';




import 'package:provider/provider.dart';

import '../components/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      SizedBox(height: MediaQuery.of(context).size.height*0.12,),
                      CustomText(title: 'Welcome Back',size: 30,color: white,),
                      CustomText(
                          title: 'Log In',size: 50,weight: FontWeight.bold,color: white,),
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
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains("@")) {
                          return 'Please enter some text';
                        }
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
                      text: 'Log In',
                      color: Colors.lightBlueAccent,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final message = await context
                              .read<AuthenticationService>()
                              .signIn(email: email, password: password);

                          if(message == "Signed In")
                            Navigator.pop(context);

                          else
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
