import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp1/models/app_user.dart';
import 'package:flutterapp1/services/database.dart';

class AuthServices {
  AppUser? _userFromFireBaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user {
    return FirebaseAuth.instance.authStateChanges().map(_userFromFireBaseUser);
  }

  //sign in anonymous
  Future signInAnonymous() async {
    try {
      UserCredential result = await FirebaseAuth.instance.signInAnonymously();
      User? user = result.user;
      await DatabaseService(uid: user!.uid)
          .updateUserData("0", "new Anonymous user", 100);
      return _userFromFireBaseUser(user);
    } catch (e) {
      return null;
    }
  }

  //sign up with email
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid)
          .updateUserData("0", "new Email user", 100);
      return _userFromFireBaseUser(user);
    } catch (e) {
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
    } catch (e) {
      return null;
    }
  }
}
