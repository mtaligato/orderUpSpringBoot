import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  static FirebaseAuth instance = FirebaseAuth.instance;

  static void signUpOwner({String email, String username, String password, String entityName, String entityAddress}) {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).catchError((err) {
      print(err);
    });
  }

  static Future<User> signInOwner({String email, String username, String password}) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).catchError((err) {
      print(err);
    }).then((value) {
      return value.user;
    });
  }
}
