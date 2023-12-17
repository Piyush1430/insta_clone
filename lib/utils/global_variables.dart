import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:insta_clone/utils/colors.dart";

const webScreenSize = 600;

class PageConst {
  static const String signInPage = "signInPage";
  static const String signUpPage = "signUpPage";
}

class FirebaseConst {
  static const String users = "users";
  static const String posts = "posts";
  static const String comment = "comment";
  static const String replay = "replay";
}

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: blueColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
