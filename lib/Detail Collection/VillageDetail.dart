//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:govt_survey/Detail%20Collection/Details.dart';
import 'package:govt_survey/SignUp.dart';
import 'package:govt_survey/VillageAssign/VillageDashboard.dart';

import 'Tradition.dart';

class VillageDetail extends StatelessWidget {
  final name_of_village = TextEditingController();
  final history_of_village = TextEditingController();
  final int maxLine=50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 50, bottom: 30),
                child: Text(
                  "Prev",
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
          GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>VillageDashboard()));
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
          GestureDetector(
              onTap: () async {
                FirebaseUser user=await SignUp.auth.currentUser();
                var userId=user.uid;
                print("UserID=$userId");
                _uploadDetails(userId).whenComplete(() => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Tradition())));
              },
              child: Padding(
                padding: EdgeInsets.only(right: 50, bottom: 30),
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ))
        ],
      ),
      appBar: AppBar(
        title: Text("Village Detail"),
        backgroundColor: Colors.blue[900],
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 30,
            )),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 10, top: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Village",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23)),
              SizedBox(height: 20),
              Text(
                "Name of the Village",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: TextFormField(
                  controller: name_of_village,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.blue[900],
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("History of the village ",
                  style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
              Container(
                height: (maxLine*5).toDouble(),
                child: TextFormField(
                  maxLines:null,
                  controller: history_of_village,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.blue[900],
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _uploadDetails(String key)
  async {
    SignUp.fb.reference().child(key).child("village").child("Name").set(name_of_village.text);
    SignUp.fb.reference().child(key).child("village").child("History").set(history_of_village.text);

  }
}
