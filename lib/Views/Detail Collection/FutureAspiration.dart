//@dart=2.9
import 'package:flutter/material.dart';
import 'package:govt_survey/Views/LayoutComponents/Layout.dart';
import 'package:govt_survey/Views/VillageAssign/VillageDashboard.dart';
import 'package:govt_survey/Views/WidgetComponents/Components.dart';


    class FutureAspiration extends StatelessWidget {
      Layout aspiration = new Layout();
      Map<String, dynamic> aspirationDetail = {};

      @override
      Widget build(BuildContext context) {
        return Stack(
            children: [
              Components.setBackground(),
              Scaffold(
                backgroundColor: Colors.transparent,
                bottomNavigationBar: Container(
                  color: Colors.blue[900],
                  child: Row(
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => VillageDashboard()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          )),
                      GestureDetector(
                          onTap: () async {
                            // FirebaseUser user=await SignUp.auth.currentUser();
                            // var userId=AuthService.currentUID.toString();
                            // _uploadDetails(userId).whenComplete(() =>  showPopUp(context)) ;
                            Components.showPopUp(context);
                          },

                          child: Padding(
                            padding: EdgeInsets.only(right: 50, bottom: 30),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ))
                    ],
                  ),
                ),
                appBar: AppBar(
                  backgroundColor: Colors.blue[900],
                  title: Text("Future Aspirations"),
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
                      Text("Village Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 23)),
                      SizedBox(height: 20),
                      aspiration.createDescription(
                          "What are the Community Aspirations for enhancing cultural resources of the Village for its sustainable economic development?",
                          "aspirations", aspirationDetail)
                    ],
                  ),
                ),
              ),
            ]);
      }

    }
