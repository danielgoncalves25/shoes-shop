import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;

  Authentication(this._firebaseAuth, this._fireStore);

  Stream<User> get authState => _firebaseAuth.authStateChanges();
  User get currentUser => _firebaseAuth.currentUser;

  Stream<DocumentSnapshot> get userData =>
      _fireStore.collection('users').doc(currentUser.uid).snapshots();
  String errorCode;

  Future<void> signOut() async {
    print('SIGNING OUT');
    await _firebaseAuth.signOut();
  }

  Future signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code + e.message);
      return e.code;
    }
  }

  Future signUp(
      {String email,
      String password,
      String firstName,
      String lastName}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      _fireStore.collection('users').doc(currentUser.uid).set({
        'name': {
          'firstName': firstName,
          'lastName': lastName,
        },
        'cart': []
      });

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code + e.message);
      return e.code;
    }
  }
}
