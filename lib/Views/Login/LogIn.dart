//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:govt_survey/Service/FirebaseAuthService.dart';
import 'package:govt_survey/Service/common_functions.dart';
import 'package:govt_survey/Views/Detail%20Collection/LocationTrack.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SignUp/SignUp.dart';
import '../Detail Collection/Details.dart';

class LogIn extends StatelessWidget {
String userKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text("Sign In", style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: app(),
    );
  }
}

class app extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return appState();
  }
}

class appState extends State<app> {
  final _key = new GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showPassword = true;

  ///Register once
 //  static bool seen;
 // checkSeen()
 //  async {
 //   var email=await CommonFunctions.getSharedPreferences('email');
 //   print("email=$email");
 // seen=await CommonFunctions.checkFirstSeen(email);
 // print("seen==$seen");
 //  }


  // Future<FirebaseUser> login(String email, String password) async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   try {
  //     AuthResult result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     FirebaseUser user = result.user;
  //     return user;
  //   } catch (e) {
  //     print("Your Email Id or Password might be wrong");
  //     return null;
  //   }
  // }
@override
  void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
    super.dispose();
  }

  ///Register once
// @override
//   void initState() {
//    checkSeen();
//     super.initState();
//   }
  @override
  Widget build(BuildContext context) {
    final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
    return
      Form(
        key: _key,
        child:Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.blue[900]
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                  child:
                  Text(
                      "Welcome Back",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )
                  ),
                ),
                Text(
                  "Sign In with your Email and Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 70),
                    child:
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Enter your email id"),));
                        }
                        if(value.length>0){
                          EmailValidator.validate(value)
                              ? null
                              : ScaffoldMessenger
                              .of(context)
                              .showSnackBar(SnackBar(
                            content:
                            Text("Enter valid email address"),
                          ));
                        }
                        return null;
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: 'Email Id',
                          hintText: 'Enter Email Id or Mobile Number',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.mail_outline_rounded,color: Colors.blue[900]),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.grey,),


                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.green,),

                          )
                      ),
                      controller: _emailController,
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child:
                    TextFormField(
                      validator: (value){
                        if(value.isEmpty)
                        {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content:
                            Text("Enter password"),
                          ));
                        }
                        return null;
                      },
                      autofocus: true,
                      obscureText: showPassword,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Your Password',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.vpn_key_outlined,color: Colors.blue[900],),
                          suffixIcon: GestureDetector(
                              child: showPassword
                                  ? Icon(Icons.visibility_off,color: Colors.blue[900])
                                  : Icon(Icons.visibility,color: Colors.blue[900]),
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              }
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.grey,),

                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.green,),


                          )
                      ),
                      controller: _passwordController,

                    )
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10, right: 25, left: 250),
                    child:
                    SizedBox(width: double.infinity,
                        child:
                        GestureDetector(
                          onTap: () {
                            print("clicked");
                          },
                          child: RichText(text:
                          TextSpan(text:
                          "Forgot Password",

                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[300]),
                            // recognizer:  _tapGestureRecognizer
                            //   ..onTap = () {
                            //     print('Clicked"');
                            //   }
                          ),),
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 20, top: 70, bottom: 30),
                    child:
                    Container(
                      width: 300,
                      height: 40,
                      child:
                      RaisedButton(child: Text(
                          'LogIn⇛',
                          style: TextStyle(
                            color: Colors.blue[900],
                          )),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 10.0,
                        color: Colors.white,
                        onPressed: ()
                          async {
                            final email = _emailController.text.toString()
                                .trim();
                            final password = _passwordController.text
                                .toString()
                                .trim();

                            // FirebaseUser user = await login(email, password);
                            FirebaseUser user =await AuthService.login(email, password);
                            CommonFunctions.setSharedPreferences('email',email);
                            if (_key.currentState.validate()) {
                              if (user != null) {
                                //
                                // if(seen)
                                //   {
                                //     Navigator.pushReplacement(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => LocationTrack()),);
                                //   }
                                // else{
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Details()),);
                                // }


                              }
                              else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                  Text("Not Registered"),
                                ));
                              }
                            }
                          }

                      ),
                    )
                ),

                Row(children: <Widget>[
                  Container(width: 65),
                  Container(
                    width: 120,
                    child:
                    Divider(color: Colors.white, thickness: 1.0,),),
                  Padding(padding: EdgeInsets.all(7.0),
                    child:
                    Text('OR', style: TextStyle(color: Colors.white)),),
                  Container(width: 120,
                      child:
                      Divider(color: Colors.white, thickness: 1.0)),
                ]
                ),


                Padding(
                  padding: EdgeInsets.only(top: 40, right: 25, left: 100),
                  child:
                  SizedBox(width: double.infinity,
                      child:
                      RichText(

                          text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(text:
                                "Don't have an Account? ",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                TextSpan(text:
                                "SignUp",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                    recognizer: _tapGestureRecognizer
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignUp()));
                                        // );
                                      }
                                ),
                              ]
                          )
                      )
                  ),
                ),

              ],
            ),
          ),
        ),
      );
  }
}