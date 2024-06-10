import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //construir o login do usuario
   final FirebaseAuth _auth = FirebaseAuth.instance;

   //login do usuario
   Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
        );
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //create a new user
  Future<void> registerWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
         );
    } catch (e) {
      print(e.toString());
    }
  }
  
  //logout do usuario
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

}