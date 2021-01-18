import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map userData = context.watch<DocumentSnapshot>().data();
    String uid = context.watch<User>().uid;

    return Scaffold(
      body: Column(
        children: [
          Text('First Name: ${userData['name']['firstName']}'),
          Text('Last Name: ${userData['name']['lastName']}'),
          Text('Uid: $uid'),
        ],
      ),
    );
  }
}
