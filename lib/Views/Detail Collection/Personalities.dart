//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:govt_survey/Views/LayoutComponents/Layout.dart';
import 'package:govt_survey/Views/WidgetComponents/Components.dart';
import 'package:image_picker/image_picker.dart';
import 'PlaceOfInterest.dart';

class Personalities extends StatefulWidget {
  final String villageId;
  Personalities({Key key, @required this.villageId}) : super(key: key);

  @override
  _PersonalitiesState createState() => _PersonalitiesState();
}

class _PersonalitiesState extends State<Personalities> {
 ImagePicker picker=new ImagePicker();
 // List<File> _images=[];
 // List<File> _videos=[];
  final name_of_personality=TextEditingController();
  final description_of_personality=TextEditingController();
  Map<String,dynamic> personalityDetail={};
  Layout personality=new Layout();
  int counter=1;
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Components.setBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
        bottomNavigationBar:Components.setBottomNavigationBar(context, PlaceOfInterest(villageId: widget.villageId), personality, widget.villageId.toString()),
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              setState(()
              {
                counter++;
              });
            }, icon: Icon(Icons.add,color: Colors.white,size: 23,))
          ],
          title: Text("Personailities Details"),
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
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: counter,
              itemBuilder: (context,index){
            return PersonalityCard(index+1);
          }),
        ),
      ),
    ]);
  }


Widget PersonalityCard(int index)
{
  return Padding(
    padding: EdgeInsets.only(bottom:30),
    child: Card(
        child: Container(
          color: Colors.blueGrey[200],
          padding: EdgeInsets.only(top:10,left:5,right:5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Personality $index",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),),
              SizedBox(height:10),
              personality.createCard("Name of the known or Unsung Heroes/ famous personalities", "name", personalityDetail),
              personality.createDescription("A brief personal detail of the hero/es:","description",personalityDetail),
              personality.createDescription("What they are famous for:","famous_for",personalityDetail),
              personality.createMultipleSelection("Famous work/s or Event/s:","famous_work",personalityDetail),
              personality.createDescription("Associated Legends/stories:", "assosciated_legends", personalityDetail),
              personality.createMultipleSelection("Associated cultural events with the hero/es:", "cultural_events", personalityDetail),
              personality.createMultipleSelection("Associated heritage and other places:", "assosciated_heritage", personalityDetail),
              personality.createMultipleSelection("Person or family related with the heroes (If they are present):","family_related_hero", personalityDetail),
              // personality.createAudioCard("Person or family related with the heroes (If they are present):","audio",personalityDetail)
            ],
          ),
        ),
      ),
  );
}
}
