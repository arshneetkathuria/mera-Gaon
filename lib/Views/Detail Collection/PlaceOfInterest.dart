//@dart=2.9
import 'package:flutter/material.dart';
import 'package:govt_survey/Views/LayoutComponents/Layout.dart';
import 'package:govt_survey/Views/WidgetComponents/Components.dart';
import 'package:image_picker/image_picker.dart';
import 'DailyLife.dart';

class PlaceOfInterest extends StatefulWidget {

  @override
  _PlaceOfInterestState createState() => _PlaceOfInterestState();
}

class _PlaceOfInterestState extends State<PlaceOfInterest> {

  final name = TextEditingController();
  ImagePicker picker = new ImagePicker();

  // List<File> _images=[];
  // List<File> _videos=[];

  Layout poi = new Layout();
  Map<String, dynamic> placeOfInterest = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Components.setBackground(),
          Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Components.setBottomNavigationBar(
                context, DailyLife()),
            appBar: AppBar(
              title: Text("Places Of Interest Details"),
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
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 10, top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Places Of Interest",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 23)),
                    SizedBox(height: 20),
                    poi.createMultipleSelection(
                        "What are the historical places of the village? Any legend associated with it.",
                        "historical_places", placeOfInterest),
                    poi.createMultipleSelection(
                        "Important places of worship and shrines or any other religious space and legends associated with it.",
                        "places_of_worship", placeOfInterest),
                    poi.createMultipleSelection(
                        "Are there any physical landmarks in terms of sacred grooves, sacred trees, sacred ponds and other water bodies, boulders and rocks etc. what are the stories associated with these.",
                        "landmarks", placeOfInterest),
                    poi.createMultipleSelection(
                        "Any specific rituals/worship held in these places.? Are there any deities associated with these places?",
                        "rituals", placeOfInterest),
                    poi.createMultipleSelection(
                        "Important persons either historical or mythological, associated with the village.",
                        "person_assosciated_with_village", placeOfInterest)
                  ],
                ),
              ),
            ),
          ),
        ]);
  }
}
