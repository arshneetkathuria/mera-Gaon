//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:govt_survey/VillageAssign/VillageDashboard.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../SignUp.dart';

    class FutureAspiration extends StatelessWidget {
    final aspiration_detail=TextEditingController();
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VillageDashboard()));
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
                    _uploadDetails(userId).whenComplete(() =>  showPopUp(context)) ;

                  },

                  child: Padding(
                    padding: EdgeInsets.only(right: 50, bottom: 30),
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ))
            ],
          ),
          appBar: AppBar(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Our Future Aspirations",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23)),
                SizedBox(height: 20),
                Text(
                  "Aspiration",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10),
                Container(
                  height: 40,
                  child: TextFormField(
                    controller: aspiration_detail,
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
        );
      }

     Future _uploadDetails(String key)
      {
       return SignUp.fb.reference().child(key).child("Aspirations").set(aspiration_detail.text);
      }


       showPopUp(BuildContext context)
      {
        return showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(icon:Icon(Icons.cancel,size: 30,color:Colors.grey[500]), onPressed: () { Navigator.pop(context);},)
              ],
            ),
            content:Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/tenor.gif",width:150,height:150),
                  SizedBox(height:20),
                  Text("Details Saved!!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),)
                ],
              ),
            ),
            actions: <Widget>[
          DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Colors.green,
          onPressed: () =>  Navigator.push(context,MaterialPageRoute(builder: (context)=>VillageDashboard())),
          ),

              ],

          );
        });
      }


    }
