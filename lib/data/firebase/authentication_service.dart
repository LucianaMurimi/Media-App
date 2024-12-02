import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // login
  Future loginWithEmailAndPassword(email, password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // register
  Future registerWithEmailAndPassword(email, password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // logOut
  Future logout() async {
    return await _auth.signOut();
  }

  // reset password
  Future resetPassword(email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }
  
}
