import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui/Services/auth.dart';

class Database {
  Future addUserdata(String? uid, String name, String email) async {
    FirebaseFirestore.instance.collection("users").doc(uid).set({
      "name": name,
      "email": email,
      "url": "",
    });
  }

  Future updateProfile(String name, String bio, String career, String skills,
      String education, String facebook, String linkedin, String github) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'name': name,
      'bio': bio,
      'career': career,
      'skills': skills,
      'education': education,
      'facebook': facebook,
      'linkedin': linkedin,
      'github': github,
    });
  }

  Future updateUrl(String url) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'url': url,
    });
  }

  Future<String> readField(String fieldName) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    // Access a specific field in the document
    var specificFieldValue = snapshot.get(fieldName);

    return specificFieldValue;
  }
}
