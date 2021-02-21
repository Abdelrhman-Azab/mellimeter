import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Admin with ChangeNotifier {
  bool checkIfAuth() {
    if (FirebaseAuth.instance.currentUser != null) {
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  bool isAdmin = false;
  void changeAdminState(bool value) {
    isAdmin = value;
    notifyListeners();
  }
}
