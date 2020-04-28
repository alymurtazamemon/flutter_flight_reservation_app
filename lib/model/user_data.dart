import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String username = 'Username';
  String email;
  String password;
  ImageProvider image = AssetImage('images/account_user.png');

  void uploadImage(ImageProvider image) {
    this.image = image;
    notifyListeners();
  }

  void setEmailAndPassword(String email, String password) {
    this.email = email;
    this.password = password;
    notifyListeners();
  }

  void saveProfileChanges({String username, String email, String password}) {
    this.username = username;
    this.email = email;
    this.password = password;
    notifyListeners();
  }
}
