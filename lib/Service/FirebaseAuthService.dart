import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  //Login
  static Future<String> login(String email, String password) async {
    String errorMessage;
    AuthResult result;
    try {
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return "SUCCESS";
    }on PlatformException catch (e) {

      switch (e.code){
        case "ERROR_INVALID_EMAIL":
          errorMessage = "The email address is malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "The Password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "Either email or password is wrong.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "The user has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many attempts to sign in.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Account not enabled.";
          break;
        default:
          errorMessage = "Unknown Error Occurred";
          break;
      }
      print(e.toString());
      return errorMessage;
    }
  }

  //Register User

  static Future<String> signupUser(
      String name, String email, String password, String phone) async {
    AuthResult result;
    String errorMessage;
    try {
      result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "SUCCESS";
    } on PlatformException catch (e) {
      print(e.toString());
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "ERROR_WEAK_PASSWORD":
          errorMessage = "Password should be at least 6 characters.";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "The email address is already in use by another account.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      return errorMessage;
    }
  }

  //UID
  static Future<String> get currentUID async {
    return (await (_auth.currentUser())).uid.toString();
  }

  //Current User
  static Future get currentUser async {
    return (await _auth.currentUser());
  }

  //SignOut
  static Future SignOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<FirebaseDatabase>get databaseInstance async{
     final FirebaseDatabase db = FirebaseDatabase.instance;
     return db;
  }
}
