import 'package:firebase_auth/firebase_auth.dart';
import 'package:sccult_media/domain/models/authentication_models.dart';

//[authenticatedUserFromFirebaseUser] function creates [AuthenticatedUser] object based on [FirebaseUser]
AuthenticatedUser? authenticatedUserFromFirebaseUser(User? user){
  return user != null ? AuthenticatedUser(email: user.email) : null;
}