//@dart=2.9
import 'package:flutter/material.dart';
import 'package:govt_survey/Views/LayoutComponents/Layout.dart';
import 'package:govt_survey/Views/WidgetComponents/Components.dart';
import 'FutureAspiration.dart';
import 'package:image_picker/image_picker.dart';

class DailyLife extends StatefulWidget {

  @override
  _DailyLifeState createState() => _DailyLifeState();
}

class _DailyLifeState extends State<DailyLife> {

  final name=TextEditingController();
  final description=TextEditingController();
  ImagePicker picker=new ImagePicker();
  // List<File> _images=[];
  // List<File> _videos=[];
  Map<String,dynamic> dailyLifeDetail={};
  Layout dailyLife=new Layout();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Components.setBackground(),
        Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar:Components.setBottomNavigationBar(context, FutureAspiration()),
        appBar: AppBar(
          title: Text("Daily Life Details"),
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
        body:SingleChildScrollView(
            physics: BouncingScrollPhysics(),
      child:Padding(
      padding: EdgeInsets.only(left: 20, right: 10, top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Daily life ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23)),
                SizedBox(height: 20),
                dailyLife.createMultipleSelection("What does a typical Day in the village look like?", "day_life",dailyLifeDetail),
                dailyLife.createMultipleSelection("What is the primary source of livelihood and economy of the village?", "source_of_livelihood",dailyLifeDetail),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
