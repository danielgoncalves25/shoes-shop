import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShowMessage extends StatelessWidget {
  var message;

  ShowMessage(this.message);

  Map<String, String> errors = {
    'unknownGiven': 'You did not enter the password. Please enter the password',
    'user-not-found': 'There is no user record corresponding to this email.',
    'weak-password': 'Password should be at least 6 characters',
    'email-already-in-use':
        'The email address is already in use by another account.',
    'wrong-password':
        'The password is invalid or the user does not have a password.',
    'too-many-requests':
        'There was a problem trying to log you in. Please try again.',
    'invalid-email': 'Please enter a valid email',
  };

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: message,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData && snapshot.data is String) {
    //       print('is a string and has data');
    //       return Text(errors[snapshot.data],
    //           style: TextStyle(color: Colors.redAccent));
    //     }
    //     if (snapshot.hasError)
    //       return Text(snapshot.error,
    //           style: TextStyle(color: Colors.redAccent));
    //     return Container();
    //   },
    // );
    print('the message is $message');
    return Text(message == null ? ' ' : errors[message],
        style: TextStyle(color: Colors.redAccent));
  }
}
