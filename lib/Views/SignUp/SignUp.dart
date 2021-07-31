//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:govt_survey/Service/FirebaseAuthService.dart';

import '../Login/LogIn.dart';

class SignUp extends StatelessWidget {

  // String name, email, password, phone;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  static final FirebaseDatabase fb=FirebaseDatabase.instance;
 String userKey;

// static get Key=>userKey;
//   Future<bool> signupUser(String name,String email,String password,String phone)
//   async{
//     try{
//       AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
//       FirebaseUser user = result.user;
//       return true;
//     }
//     catch(e){
//       print("Error==$e");
//       return false;
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text("Sign Up"),
        elevation: 0,
      ),
      body: Container(
        color:Colors.blue[900],
        child: Form(child:
        ListView(
          children: <Widget>[
            SizedBox(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Text(
                          "Create Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color:Colors.white
                          )
                      ),
                    ),

                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                              filled: true,
                              labelText: 'Name',
                              hintText: 'Enter your full name',
                              prefixIcon: Icon(Icons.account_circle_outlined,color: Colors.blue[900],),
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
                          controller: _nameController,
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Email Id',
                              hintText: 'Enter Email Id or Mobile Number',
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
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Phone Number',
                              hintText: 'Enter Mobile Number',
                              prefixIcon: Icon(Icons.phone,color: Colors.blue[900]),
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
                          controller: _phoneController,
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: TextFormField(
                          autofocus: true,
                          obscureText: true,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Password',
                              hintText: 'Enter Your Password',
                              prefixIcon: Icon(Icons.vpn_key_outlined,color: Colors.blue[900]),
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
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: TextFormField(
                          autofocus: true,
                          obscureText: true,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Enter Password again',
                              hintText: 'Re enter your password',
                              prefixIcon: Icon(Icons.vpn_key_outlined,color: Colors.blue[900]),
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
                        padding: EdgeInsets.only(left: 10, right: 20, top: 40),
                        child: Container(
                          width: 300,
                          height: 40,
                          child:
                          RaisedButton(child: Text(
                              'Finish',
                              style: TextStyle(
                                color: Colors.blue[900],
                              )),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: Colors.white,
                            onPressed: () async {
                              final name = _nameController.text.toString().trim();
                              var email = _emailController.text.toString().trim();
                              final password = _passwordController.text.toString()
                                  .trim();
                              final phone = _phoneController.text.toString()
                                  .trim();

                              bool result =await AuthService.signupUser(name, email, password, phone);
                              userKey=AuthService.currentUID.toString();
                              if(result){
                                _uploadDetails(userKey).whenComplete(() =>  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LogIn()),
                                ));
                              }
                              // ignore: unnecessary_statements
                              else(){
                                print("nahi hua");
                              };
                            },
                          ),
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 20, top: 15),
                        child: Container(
                          width: 300,
                          height: 40,
                          child:
                          RaisedButton(child: Text(
                              'Already have a account? login',
                              style: TextStyle(
                                color: Colors.blue[900],
                              )),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: Colors.white,
                            onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LogIn()),
                            );

                            },),))
                  ],
                )
            )
          ],
        )
        ),
      ),
    );
  }


  Future _uploadDetails(String key) async{
fb.reference().child(key).child("userDetail").child("name:").set(_nameController.text);
fb.reference().child(key).child("userDetail").child("email:").set(_emailController.text);
fb.reference().child(key).child("userDetail").child("phone:").set(_phoneController.text);

  }
}
