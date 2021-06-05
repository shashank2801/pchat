import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pchat/userModel.dart';

class UserCircle extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;
 

  const UserCircle({Key key, this.snapshot, this.index}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  UserModel user = UserModel.fromMap(snapshot.docs[index].data());

    return Container(
      width: 75,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.cyan,
      ),
      alignment: Alignment.center,
      child: Text(user.username[0],style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
    );
  }
}