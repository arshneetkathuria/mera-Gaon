//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:govt_survey/Detail%20Collection/PlaceOfInterest.dart';
import 'package:govt_survey/VillageAssign/VillageDashboard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

import '../SignUp.dart';

class Personalities extends StatefulWidget {

  @override
  _PersonalitiesState createState() => _PersonalitiesState();
}

class _PersonalitiesState extends State<Personalities> {
 ImagePicker picker=new ImagePicker();
 List<File> _images=[];
 List<File> _videos=[];
  final name_of_personality=TextEditingController();
  final description_of_personality=TextEditingController();
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
                _uploadDetails(userId);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PlaceOfInterest()));
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Personalities",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23)),
              SizedBox(height: 20),
              Text(
                "(Famous Personalities/unsung heroes)",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 30),
              Text(
                "Name",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: TextFormField(
                  controller: name_of_personality,
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
              Text(
                "Description",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 10),
              Container(
                child: TextFormField(
                  minLines: 1,
                  maxLines: null,
                  controller: description_of_personality,
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
              Text("Take Image", style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  _takePhoto();
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Icon(Icons.camera_alt,color: Colors.blue[900],size: 29),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right:10),
                            child: Icon(Icons.add_circle,color: Colors.blue[900],size: 29,))
                      ]),
                ),
              ),
              SizedBox(height: 30),
              Text("Take Video", style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _takeVideo,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Icon(Icons.video_call,
                                color: Colors.blue[900], size: 34),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.blue[900],
                              size: 29,
                            ))
                      ]),
                ),
              ),
              // SizedBox(height:40),
              // Center(
              //   child: RaisedButton(
              //     color: Colors.blue[900],
              //     onPressed: () async {
              //       FirebaseUser user=await SignUp.auth.currentUser();
              //       var userId=user.uid;
              //       _uploadDetails(userId);
              //     },
              //     child: Text("Upload",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void _takePhoto() async {
    try{
      await
      picker.pickImage(source: ImageSource.camera)
          .then((recordedImage) async {
        if (recordedImage != null && recordedImage.path != null) {
          _images.add(File(recordedImage.path));

        }

        else if(recordedImage.path==null)
        {
          retrieveLostData(_images);
        }
      });
    }
    catch(e)
    {
      print("Error=$e");
    }

  }

  Future<void>retrieveLostData(_fileType) async{
    final LostData response=await picker.retrieveLostData() as LostData;
    if(response.isEmpty)
    {
      return null;
    }
    if(response.file!=null)
    {
      setState(() {
        _fileType.add(File(response.file.path));
      });
    }
    else{
      print("File lost==${response.file}");
    }
  }

  Future _uploadPhoto(String key) async
  {
    final _storage=FirebaseStorage.instance;
    var i=1;
    for(var img in _images)
    {
      print("image path==${Path.basename(img.path)}");
      var ref= _storage.ref().child("images/${Path.basename(img.path)}");
      await ref.putFile(img).onComplete;
      await ref.getDownloadURL().then((value) => SignUp.fb.reference().child(key).child("Personalities").child("images").child("PersonalityImage$i").set(value));
      i++;
      print("uploaded");
    }
  }

  void _uploadDetails(String key)
  {
    SignUp.fb.reference().child(key).child("Personalities").child("NameOfPersonality").set(name_of_personality.text);
    SignUp.fb.reference().child(key).child("Personalities").child("DescriptionOfPersonality").set(description_of_personality.text);
    _uploadPhoto(key);
  }

 void _takeVideo() async {
   try {
     await ImagePicker()
         .pickVideo(source: ImageSource.camera)
         .then((recordedVideo) async {
       if (recordedVideo != null && recordedVideo.path != null) {
         setState(() {
           _videos.add(File(recordedVideo.path));
         });
       }

       if (recordedVideo.path == null) {
         retrieveLostData(_videos);
       }
     });
   } catch (e) {
     print("Error=$e");
   }
 }
}
