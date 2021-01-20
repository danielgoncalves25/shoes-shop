import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/services.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Stream<DocumentSnapshot> data;

  @override
  void initState() {
    super.initState();
    data = context.read<Authentication>().userData;
  }

  @override
  Widget build(BuildContext context) {
    String uid = context.watch<User>().uid;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        child: StreamBuilder<DocumentSnapshot>(
          stream: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map userData = snapshot.data.data();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('First Name: ${userData['name']['firstName']}'),
                  Text('Last Name: ${userData['name']['lastName']}'),
                  Text('Uid: $uid'),
                  Text('hi'),
                ],
              );
            }
            return Text('no data');
          },
        ),
      ),
    );
  }
}
