import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pchat/components/constants.dart';
import 'package:pchat/components/title.dart';
import 'package:pchat/services/authService.dart';
import 'package:pchat/userModel.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection("users");
  UserModel _currentUser;

  String _uid='',_name='',_email='';

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      getCurrentUser();
    }

  getCurrentUser() async{
    UserModel currentUser = await context.read<AuthenticationService>().getUserFromDB(uid: auth.currentUser.uid);

    _currentUser = currentUser;

    setState(() {
          _uid = _currentUser.uid;
          _name = _currentUser.username;
          _email = _currentUser.email;
        });  
  }


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
              }),
        ],
        title: Text('Homepage'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomText(title: "Welcome $_name",size: 30,),
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
                  TextButton(
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