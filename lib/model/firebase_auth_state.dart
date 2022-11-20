import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mse_yonsei/repo/user_network_repository.dart';

class FirebaseAuthState extends ChangeNotifier {

  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.progress;
  User? _firebaseUser;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if(firebaseUser == null && _firebaseUser == null){
        changeFirebaseAuthStatus();
        return;
      } else if(firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });             // authStateChanges 는 Stream<User>
  }
  Future<void> registerUser(BuildContext context, {required String email, required String password}) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    UserCredential authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).catchError((error){
      String _message = "";
      switch (error.code) {
        case 'email-already-in-use':
          _message = "email-already-in-use";
          break;
        case 'invalid-email':
          _message = "invalid-email";
          break;
        case 'operation-not-allowed':
          _message = "operation-not-allowed";
          break;
        case 'weak-password':
          _message = "weak-password";
          break;
      }
      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    _firebaseUser = authResult.user;
    if(_firebaseUser == null) {
      SnackBar snackBar = SnackBar(
        content: Text('Please try again later!'),
      );
    } else {
      await userNetworkRepository.attemptCreateUser(userKey: _firebaseUser!.uid, email: _firebaseUser!.email!);
    }
  }




  Future<void> login(BuildContext context,
      {required String email, required String password}) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    UserCredential authResult = await _firebaseAuth
        .signInWithEmailAndPassword(
        email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error.code);
      String _message = "";
      switch (error.code) {
        case 'invalid-email':
          _message = "invalid-email";
          break;
        case 'user-not-found':
          _message = "user-not-found";
          break;
        case 'wrong-password':
          _message = "wrong-password";
          break;
        case 'user-disabled':
          _message = "user-disabled";
          break;
      }
      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    _firebaseUser = authResult.user;
    if(_firebaseUser == null) {
      SnackBar snackBar = SnackBar(
        content: Text('Please try again later!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }

  void signOut() async{
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if(_firebaseUser != null) {
      _firebaseUser = null;
      await _firebaseAuth.signOut();
    }
    notifyListeners();
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus? firebaseAuthStatus]) {
    if(firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    }else{
      if(_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
  User? get firebaseUser => _firebaseUser;
}
enum FirebaseAuthStatus{
  signout, progress, signin
}
