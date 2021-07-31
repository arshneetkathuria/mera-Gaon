//@dart=2.9
import 'package:flutter/material.dart';
import 'package:govt_survey/Views/LayoutComponents/Layout.dart';
import 'package:govt_survey/Views/WidgetComponents/Components.dart';
import 'package:image_picker/image_picker.dart' ;
import 'Personalities.dart';

class FineArts extends StatefulWidget {
  final String villageId;
  FineArts({Key key, @required this.villageId}) : super(key: key);

  @override
  _FineArtsState createState() => _FineArtsState();
}

class _FineArtsState extends State<FineArts> {
  final title = TextEditingController();
ImagePicker picker=new ImagePicker();
// List<File> _images=[];
  // List<File> _videos=[];
  Map<String,dynamic> fineArtsDetail={};
  Layout fineArts=new Layout();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Components.setBackground(),
        Scaffold(
          backgroundColor:Colors.transparent,
        bottomNavigationBar: Components.setBottomNavigationBar(context, Personalities(villageId: widget.villageId), fineArts, widget.villageId.toString()),
          appBar: AppBar(
            title: Text("Fine Arts"),
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
                  Text("Fine Arts",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 23)),
                  SizedBox(height: 20),
                  fineArts.createCard("Any story associated with the origin of art or craft forms?", "story",fineArtsDetail),
                  fineArts.createCard("Name some of your art/dance/music/craft/products that can be promoted to better your life", "promote",fineArtsDetail),
                ],
              ),
            ),
          ),
        ),
      ]);
  }
}
