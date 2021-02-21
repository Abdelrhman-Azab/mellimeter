import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mellimeter/providers/admin.dart';
import 'package:mellimeter/screens/adminScreen.dart';
import 'package:provider/provider.dart';

class FBAuth {
  final String adminpass = "adminmohab1234";
  FirebaseAuth auth = FirebaseAuth.instance;

  bool checkIfAdminAuth() {
    if (auth.currentUser != null) {
      if (auth.currentUser.uid == "VZ92O4PD4CVuuioMtW9L7j8AKsv1") {
        return true;
      }
    }
    return false;
  }

  Future signUp(
      String email,
      String password,
      String address,
      int number,
      String username,
      BuildContext context,
      GlobalKey<ScaffoldState> key) async {
    try {
      UserCredential _userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User user = auth.currentUser;
      final uid = user.uid;
      FirebaseFirestore.instance.collection("users").doc(uid).set({
        "email": email,
        "password": password,
        "address": address,
        "number": number,
        "name": username,
        "Anonymous": false
      });
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        key.currentState.showSnackBar(SnackBar(
            content: Text("كلمة السر ضعيفه"),
            backgroundColor: Colors.red[400]));
      } else if (e.code == 'email-already-in-use') {
        key.currentState.showSnackBar(SnackBar(
            content: Text("هذا الحساب مسجل بالفعل"),
            backgroundColor: Colors.red[400]));
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signIn(String email, String password, BuildContext context,
      GlobalKey<ScaffoldState> key) async {
    try {
      if (Provider.of<Admin>(context, listen: false).isAdmin) {
        if (password == adminpass) {
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email: email, password: password);
          Navigator.of(context).pushNamedAndRemoveUntil(
              AdminScreen.routeName, (Route<dynamic> route) => false);
        } else {
          key.currentState.showSnackBar(SnackBar(
              content: Text("حدث خطأ ما"), backgroundColor: Colors.red[400]));
        }
      } else {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        key.currentState.showSnackBar(SnackBar(
            content: Text("لا يوجد حساب بهذا الايميل"),
            backgroundColor: Colors.red[400]));
      } else if (e.code == 'wrong-password') {
        key.currentState.showSnackBar(SnackBar(
            content: Text('كلمة السر غير صحيحه'),
            backgroundColor: Colors.red[400]));
      }
    }
  }

  Future signInAnonymously(
      String name, String address, int number, BuildContext context) async {
    UserCredential userCredential = await auth.signInAnonymously();
    final uid = userCredential.user.uid;
    FirebaseFirestore.instance.collection("users").doc(uid).set({
      "name": name,
      "address": address,
      "number": number,
      "Anonymous": true
    });
    Navigator.of(context).pop();
  }
}
