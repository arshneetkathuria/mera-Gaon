//@dart=2.9
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:govt_survey/Service/common_functions.dart';
import 'package:govt_survey/Views/LayoutComponents/Layout.dart';
import 'package:govt_survey/Views/WidgetComponents/Components.dart';

import 'Tradition.dart';

class VillageDetail extends StatefulWidget {
  final String villageId;
  VillageDetail({Key key, @required this.villageId}) : super(key: key);


  @override
  _VillageDetailState createState() => _VillageDetailState();
}

class _VillageDetailState extends State<VillageDetail> {
  // final name_of_village = TextEditingController();
  // final history_of_village = TextEditingController();

  final int maxLine = 50;
   // List<Map<String,dynamic>> _villageDetail;
  Map<String,dynamic> _villageDetail={};
   String result=" ";
   Layout villageDetail=new Layout();


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Components.setBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Components.setBottomNavigationBar(context, Tradition()),
          appBar: AppBar(
            elevation: 0,
            title: Text("About Village"),
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
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 10, top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Village Details",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 23)),
                  SizedBox(height: 20),
                  villageDetail.createCard("Present Name of the village or any other name","present_name",_villageDetail),
                  villageDetail.createCard("Ancient name","ancient_name",_villageDetail),
                  villageDetail.createCard("Tehsil","tehsil",_villageDetail),
                  villageDetail.createCard("District","district",_villageDetail),
                  villageDetail.createCard("State","state",_villageDetail),
                  villageDetail.createCard("When was the village established?","village_established_year",_villageDetail),
                  villageDetail.createCard("Total Population of the village","total_population",_villageDetail),
                  villageDetail.createDescription("Brief Introduction of the village","introduction_of_village",_villageDetail),
                  villageDetail.createDescription("What languages are spoken in the village?","languages_spoken",_villageDetail),
                  villageDetail.createDescription("Stories associated with the village and/or its origin","stories",_villageDetail),
                  villageDetail.createMultipleSelection("Which is the oldest school and when was it opened?","oldest_school_info",_villageDetail),
                  villageDetail.createCard("When did electricity come to the village?","electricity_established",_villageDetail),
                  villageDetail.createCard("When did drinking water come to the village?","drinking_water_introduced",_villageDetail),
                  villageDetail.createCard("When did internet come to the village?","internet_introduced",_villageDetail),
                ],
              ),
            ),
          ),
        ),
      ],

    );
  }
//
//   Future _uploadDetails(String key) async {
// SignUp.fb.reference()
//         .child(key)
//         .child("village")
//         .child("Name")
//         .set(name_of_village.text);
//     SignUp.fb
//         .reference()
//         .child(key)
//         .child("village")
//         .child("History")
//         .set(history_of_village.text);
//   }
  Future _uploadDetails(String key) async{

  }
}
