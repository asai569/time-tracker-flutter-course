import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  User({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWitGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  Stream<User> get onAuthStateChanged {
    // ignore: deprecated_member_use
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWitGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: 'EROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'messing google auth token');
      }
    } else {
      throw PlatformException(
          code: 'EROR_ABORTED_BY_USER', message: 'sign in aborted by user');
    }
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
