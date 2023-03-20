import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  Future signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future signUp(String email, String password, String name) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'name': name,
      'email': email,
      'bio': "",
      'url': "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      'career': "",
      'github': "",
      'facebook': "",
      "linkedin": "",
      "education": "",
      "skills": ""
    });
  }

  String? currentUserEmail() {
    return FirebaseAuth.instance.currentUser!.email;
  }

  String? currentUserUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
