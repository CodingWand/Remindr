import 'package:ebb/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  User _userFromFirebaseUser(FirebaseUser user) {
    return (user != null) ? User(user.uid) : null;
  }

  //Sign in with email and password
  Future signInWithEmailPassword(String email, String password) async
  {
    try{
      dynamic result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Register with email and password
  Future registerWithEmailPassword(String email, String password) async
  {
    try {
      dynamic result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //Log out
  Future signOut() async
  {
    try {
      return await _auth.signOut();
    } catch(e) {
      return null;
    }
  }

}
