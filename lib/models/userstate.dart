import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  User? u;
  void setUser(User? i) {
    u = i;
    notifyListeners();
  }

  void logoutUser() {
    u = null;
    print("Loging out");
    notifyListeners();
  }
}
