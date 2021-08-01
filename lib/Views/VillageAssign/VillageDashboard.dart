import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:govt_survey/Service/FirebaseAuthService.dart';
import 'package:govt_survey/Views/SignUp/SignUp.dart';
import 'package:govt_survey/Views/Detail%20Collection/Tradition.dart';
import 'package:govt_survey/Views/Detail%20Collection/VillageDetail.dart';

class VillageDashboard extends StatefulWidget {
  const VillageDashboard({Key? key}) : super(key: key);

  @override
  _VillageDashboardState createState() => _VillageDashboardState();
}

class _VillageDashboardState extends State<VillageDashboard> {
  static final db = SignUp.fb.reference();
  List images = Tradition.Images;

  static Future getVillages() async {
    // FirebaseUser user = await AuthService.currentUser;
    // userId = user.uid;
    FirebaseDatabase database=await AuthService.databaseInstance;
    String uid=await AuthService.currentUID;
    print("id=$uid");
    return await database.reference().child(uid).child("villageAssigned").once();
    // print("DetailValue=${detail.value}");

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
                onTap: () {
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
            child: FutureBuilder(
              future: getVillages().then((value) => value.value),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String> villages = [];
                  List villagesList = snapshot.data as List;
                  //Map v = snapshot.data as Map;
                  villagesList.forEach((value) {
                    villages.add(jsonEncode(value));
                  });
                  print("villages==$villages");
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 30.0,
                          mainAxisSpacing: 20.0),
                      itemCount: villages.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VillageDetail(
                                        villageId: json
                                            .decode(villages[index])["id"].toString())));
                          },
                          child: Container(
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                    height: 140,
                                    width: 200,
                                    color: Colors.grey[300],
                                    child: Image.asset(
                                      "assets/images/village.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Center(
                                      child: Text(
                                          json.decode(villages[index])["name"]))
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(
                      child: Column(
                    children: [
                      Text("No villages assigned yet!"),
                      // CircularProgressIndicator(),
                    ],
                  ));
                }
              },
            )));
  }
}
