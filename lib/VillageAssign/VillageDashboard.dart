import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:govt_survey/Detail%20Collection/Tradition.dart';
import 'package:govt_survey/Detail%20Collection/VillageDetail.dart';
import 'package:govt_survey/SignUp.dart';

class VillageDashboard extends StatefulWidget {
  const VillageDashboard({Key? key}) : super(key: key);

  @override
  _VillageDashboardState createState() => _VillageDashboardState();
}

class _VillageDashboardState extends State<VillageDashboard> {
  static final db = SignUp.fb.reference();
  static var userId;
  List images=Tradition.Images;


  static Future getVillages() async {
    FirebaseUser user = await SignUp.auth.currentUser();
    userId = user.uid;
    print("id=$userId");
  return await db
        .child(userId).child("villageAssigned").once();


     // return villages;
    // print(villages);
  }



  @override
  initState() {
    // print(images.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
        GestureDetector(
        onTap: ()
    {
      Navigator.pop(context);
    },
    child: Padding(
    padding: EdgeInsets.only(left: 50, bottom: 30),
    child: Text(
    "Cancel",
    style: TextStyle(
    color: Colors.blue[900],
    fontWeight: FontWeight.bold,
    fontSize: 20),
    ),
    )),
    GestureDetector(
    onTap: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => VillageDetail()));
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
    title: Text("Villages Assigned"),
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
    body: Padding(
    padding: EdgeInsets.all(20),
    child:FutureBuilder(
    future:getVillages().then((value) => value.value),
      builder: (context,snapshot)
      {
        if(snapshot.hasData) {
          List<String> villages=[];
          Map v=snapshot.data as Map ;
          v.forEach((key, value) {
     villages.add(value);
            });
           return  GridView.builder(
          shrinkWrap: true,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 20.0),
          itemCount:villages.length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VillageDetail()));
              },
              child: Container(
                child: Card(
                  child: Column(
                    children: [
                      Container(height: 140,
                          width: 200,
                      color: Colors.grey[300],
                       child:Image.asset("assets/images/village.jpg",fit: BoxFit.cover,),
                      ),
                      Center(child: Text(villages[index]))
                    ],
                  ),
                ),
              ),
            );
          });
        }
        else
          {
            return Center(
              child: CircularProgressIndicator()

            );
          }
      },
    )

    )

    );
    }
  }
