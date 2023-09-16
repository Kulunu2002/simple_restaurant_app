import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  Future<Map<String, dynamic>?> signUpUser(
      String email, String password) async {
    // Sign-up code
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? uid = credential.user!.uid;
      return {"isError": true, "msg": uid};

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return {"isError": true, "msg": "The password provided is too weak."};
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return {
          "isError": true,
          "msg": "The account already exists for that email."
        };
      }
    } catch (e) {
      print(e);
      return {"isError": true, "msg": "${e.toString()}"};
    }
  }

  Future signInUser(String name , String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String? uid = credential.user!.uid;
      
      return {"isError": false, "msg": uid};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User");
        return {"isError": true, "msg": "no user"};
      } else if (e.code == 'wrong-password') {
        print("Worng password");
        return {"isError": true, "msg": "wrong password"};
      }
    }
  }
}
