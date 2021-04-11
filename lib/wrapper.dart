
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pchat/screens/home_screen.dart';
import 'package:pchat/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class WrapperClass extends StatelessWidget {

  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();
    if(firebaseuser != null){

     return HomeScreen();
    }

    return WelcomeScreen();
  }
}