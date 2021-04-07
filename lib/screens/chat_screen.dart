
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pchat/services/authService.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../routes.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn;

  GoogleSignInAccount gLoggedInUser;
  User loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getCurrentUser();
  }

  // void getCurrentUser() async {
  //   try{
  //       final user = await _auth.currentUser;
  //       loggedInUser = user;
  //       gLoggedInUser = await _googleSignIn.currentUser;
  //   }
  //   catch(e){
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                // if(loggedInUser!=null){
                //   _auth.signOut();
                //   Navigator.popUntil(context, ModalRoute.withName(Routes.login_screen));
                // }
                // if(gLoggedInUser!=null)
                //   _googleSignIn.signOut();

                Navigator.pushReplacementNamed(context, Routes.welcome_screen);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
