//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:govt_survey/Service/FirebaseAuthService.dart';
import 'package:govt_survey/Service/common_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SignUp/SignUp.dart';
import 'LocationTrack.dart';

class Details extends StatefulWidget {
  static String userKey;

  static String get Key => userKey;

  @override
  _DetailsState createState() => _DetailsState(userKey);
}

class _DetailsState extends State<Details> {
  String userKey;
  final _nameController = TextEditingController();
  final _phone = TextEditingController();
  final _age = TextEditingController();
  final _language = TextEditingController();
  final _education = TextEditingController();
  final _district = TextEditingController();
  final _state = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String dropdownValue = 'Gender';
  String state = 'Select State';
  String district = 'Select District';

  // final FirebaseDatabase database = SignUp.fb;

  // final FirebaseAuth _auth=SignUp.auth;

  _DetailsState(String userKey);

  @override
  void dispose() {
    _nameController.dispose();
    _language.dispose();
    _phone.dispose();
    _age.dispose();
    _education.dispose();
    _district.dispose();
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        title:
            Text('Enter your Details', style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: Container(
          height: 55,
          child: RaisedButton(
            child: Text("Proceed →",
                style: TextStyle(fontSize: 20, color: Colors.blue[900])),
            color: Colors.white,
            onPressed: () async {

              if (formKey.currentState.validate()) {
                // FirebaseUser user=await _auth.currentUser();
                var email=await CommonFunctions.getSharedPreferences('email');

                ///Register once
                // CommonFunctions.setSharedPreferences(email,"true");
                setState(() {
                  AuthService.currentUID.then((value){
                    userKey = value;
                    print("UserKey==$userKey");
                    _uploadInfo(userKey).whenComplete(() => (Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LocationTrack()))));
                  });
                });

              }
            },
          )),
      body: Container(
          width: 500,
          height: 700,
          color: Colors.blue[900],
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 40),
                    child: TextFormField(
                      controller: _nameController,
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Full name',
                          hintText: 'Enter your full name',
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.blue[900],
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          )),
                      //controller: _nameController,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Gender', 'Male', 'Female']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Phone number";
                        }
                        if (value.length > 10 || value.length < 10) {
                          return "Please enter 10 digit phone no.";
                        }
                        return null;
                      },
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      autofocus: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Mobile',
                          hintText: 'Enter your Mobile',
                          prefixIcon: Icon(Icons.call, color: Colors.blue[900]),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          )),
                      //controller: _nameController,
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter age";
                        }
                        return null;
                      },
                      controller: _age,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Age',
                          hintText: 'Enter your age',
                          prefixIcon:
                              Icon(Icons.check_circle, color: Colors.blue[900]),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          )),
                      //controller: _nameController,
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter language you know";
                        }
                        return null;
                      },
                      controller: _language,
                      autofocus: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Language',
                          hintText: 'Enter language your know (comma separated)',
                          prefixIcon:
                              Icon(Icons.check_circle, color: Colors.blue[900]),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          )),
                      //controller: _nameController,
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your education details (comma Separated)";
                        }
                        return null;
                      },
                      controller: _education,
                      autofocus: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Education',
                          hintText: 'Enter education details',
                          prefixIcon:
                              Icon(Icons.menu_book, color: Colors.blue[900]),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          )),
                      //controller: _nameController,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: DropdownButton<String>(
                        value: state,
                        onChanged: (String newValue) {
                          setState(() {
                            state = newValue;
                          });
                        },
                        items: <String>[
                          'Select State',
                          "Andhra Pradesh",
                          "Arunachal Pradesh",
                          "Assam",
                          "Bihar",
                          "Chhattisgarh",
                          "Goa",
                          "Gujarat",
                          "Haryana",
                          "Himachal Pradesh",
                          "Jammu and Kashmir",
                          "Jharkhand",
                          "Karnataka",
                          "Kerala",
                          "Madhya Pradesh",
                          "Maharashtra",
                          "Manipur",
                          "Meghalaya",
                          "Mizoram",
                          "Nagaland",
                          "Odisha",
                          "Punjab",
                          "Rajasthan",
                          "Sikkim",
                          "Tamil Nadu",
                          "Telangana",
                          "Tripura",
                          "Uttarakhand",
                          "Uttar Pradesh",
                          "West Bengal",
                          "Andaman and Nicobar Islands",
                          "Chandigarh",
                          "Dadra and Nagar Haveli",
                          "Daman and Diu",
                          "Delhi",
                          "Ladakh",
                          "Lakshadweep",
                          "Puducherry"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: DropdownButton<String>(
                        value: district,
                        onChanged: (String newValue) {
                          setState(() {
                            district = newValue;
                          });
                        },
                        items: <String>[
                          'Select District',
                          "Anantapur",
                          "Chittoor",
                          "East Godavari",
                          "Guntur",
                          "Krishna",
                          "Kurnool",
                          "Nellore",
                          "Prakasam",
                          "Srikakulam",
                          "Visakhapatnam",
                          "Vizianagaram",
                          "West Godavari",
                          "YSR Kadapa",

                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          )),
    );
  }

  Future _uploadInfo(String key) async {
    String uid=await AuthService.currentUID;
    FirebaseDatabase database= await AuthService.databaseInstance;
    database
        .reference()
        .child(uid)
        .child("userDetail")
        .child("Gender")
        .set(dropdownValue);
    database
        .reference()
        .child(uid)
        .child("userDetail")
        .child("Age")
        .set(_age.text);
    database
        .reference()
        .child(uid)
        .child("userDetail")
        .child("Language")
        .set(_language.text);
    database
        .reference()
        .child(uid)
        .child("userDetail")
        .child("Education")
        .set(_education.text);
    database
        .reference()
        .child(uid)
        .child("userDetail")
        .child("State")
        .set(_state.text);
    database
        .reference()
        .child(uid)
        .child("userDetail")
        .child("District")
        .set(_district.text);
  }
  //
  // checkFirstSeen() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   bool seen = (pref.getBool('seen')) ?? false;
  //   print("screenVisited==$seen");
  //
  //
  //   if (seen) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => LocationTrack()));
  //   } else {
  //     pref.setBool('seen', true);
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => Details()));
  //   }
  // }
}
