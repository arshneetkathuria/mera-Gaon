import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Layout
{
  static final picker = new ImagePicker();
List images=[];
List videos=[];

// List<File> get imageList=>images;
// List<File> get videoList=>videos;

   Future<void> takePicture() async {
    try {
      await picker
          .pickImage(source: ImageSource.camera)
          .then((recordedImage) async {
        if (recordedImage != null && recordedImage.path != null) {
          images.add(File(recordedImage.path));
          print("recorded image path==${recordedImage.path}");
        }
        else if (recordedImage!.path == null) {
                  retrieveLostData(images);
                }
              print("list==$images");

      });
    } catch (e) {
      print("Error=$e");
    }
  }

  Future<void> retrieveLostData(_fileType) async {
    final LostData response = await picker.retrieveLostData() as LostData;
    if (response.isEmpty) {
      return null;
    }
    if (response.file != null) {
        _fileType.add(File(response.file!.path));
    } else {
      print("File lost==${response.file}");
    }
  }



   Future<void> takeVideo() async {
    try {
      await ImagePicker()
          .pickVideo(source: ImageSource.camera)
          .then((recordedVideo) async {
        if (recordedVideo != null && recordedVideo.path != null) {
          print("recorded image path==${recordedVideo.path}");
          videos.add(File(recordedVideo.path));

        }
        if (recordedVideo!.path == null) {
          retrieveLostData(videos);
        }


      });
    } catch (e) {
      print("Error=$e");
    }
  }

  Widget createCard(String ques,String key,Map<String,dynamic> Detail) {
    return Padding(
      padding: EdgeInsets.only(bottom:30),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black,
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ques,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (val){
                    updateData(key, val,Detail);
                  },
                  decoration: InputDecoration(
                    hintText: "fill here...",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color:(Colors.blue[900])!,
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
      ),
    );
  }

 Widget createDescription(String ques,String key,Map<String,dynamic> Detail)
  {
    return Padding(
      padding: EdgeInsets.only(bottom:30),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black,
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ques,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(height: 10),
              Container(
                child: TextFormField(
                  onChanged: (val){
                    updateData(key, val,Detail);
                  },
                  minLines: 1,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: (Colors.blue[900])!,
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
      ),
    );
  }

 Widget createMultipleSelection(String ques,String key,Map<String,dynamic> Detail) {
    return Padding(
      padding: EdgeInsets.only(bottom:30),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black,
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ques,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: TextFormField(
                  onChanged: (val){
                    updateData(key, val,Detail);
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "fill here...",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color:(Colors.blue[900])!,
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
              SizedBox(height:50),
              Center(
                child: Container(
                  padding: EdgeInsets.only(left:10,right:10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[900],

                  ),
                  width:180,
                  // height:50,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed:(){
                        takePicture().whenComplete(() =>  updateData('images',images, Detail));
                      }, icon:Icon(Icons.add_photo_alternate,size: 30,color: Colors.white,)),
                      Container(height:30,width: 2,color: Colors.white,),
                      IconButton(onPressed:(){
                        takeVideo().whenComplete(() =>  updateData('videos',videos, Detail));
                      }, icon:Icon(Icons.video_call,size: 30,color: Colors.white,)),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget createAudioCard()
  {
    return Card(

    );
  }

  static updateData(String key,dynamic value,Map<String,dynamic> detail)
  {
    if(detail.containsKey(key))
    {
      detail.remove(key);
    }
    detail.putIfAbsent(key, () => value);
    print(detail);
    // print(prettyEncoder(detail));
  }
  static prettyEncoder(jsonObject)
  {
    // var encoder = JsonEncoder.withIndent(' ');
    // return encoder.convert(jsonObject);
    return json.encode(jsonObject);
  }
}