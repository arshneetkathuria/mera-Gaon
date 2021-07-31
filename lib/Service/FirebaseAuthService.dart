import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  static final FirebaseAuth _auth = FirebaseAuth.instance;


  //Login
  static Future<FirebaseUser?> login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print("Your Email Id or Password might be wrong");
      return null;
    }
  }

  //Register User

  static Future<bool> signupUser(String name,String email,String password,String phone)
  async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }


  //UID
  static Future<String> get currentUID
  async{
    return (await(_auth.currentUser())).uid;
  }

  //Current User
  static Future get currentUser
  async {
    return (await _auth.currentUser());
  }

  //SignOut
  static Future SignOut() async{
    try{
      _auth.signOut();
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
}