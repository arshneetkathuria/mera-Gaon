//@dart=2.9
import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:govt_survey/VillageAssign/VillageDashboard.dart';
import 'package:path/path.dart' as Path;
import 'package:video_player/video_player.dart';

import '../SignUp.dart';
import 'FineArts.dart';
import 'package:image_picker/image_picker.dart';

class Tradition extends StatefulWidget {
  static final List<File> _images=[];
  static get Images=>_images;
  @override
  _TraditionState createState() => _TraditionState();
}

class _TraditionState extends State<Tradition> {
  VideoPlayerController _controller;
  final description = TextEditingController();
  var firstButtonText;
  bool uploading = false;
  double value = 0;
  static double progressTrack = 1;
  var name=TextEditingController();

  // String albumName = 'Media';
  final int maxLine = 5;
  static List<File> _videos = [];
  final picker = new ImagePicker();




  @override
  void initState() {
    // _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
   if(_controller!=null) {
     _controller.dispose();
   }
    super.dispose();
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
                  "Prev",
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VillageDashboard()));
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
                FirebaseUser user = await SignUp.auth.currentUser();
                var userId = user.uid;
                if (value != 1) {
                  _uploadDetails(userId);
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FineArts()));
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
        title: Text("Custom & Traditions"),
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
        padding: EdgeInsets.only(left: 20, right: 10, top: 40),
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Custom & Traditions",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 23)),
                SizedBox(height: 20),
                Text(
                  "(Folklores, Rituals and Practices, Religious beliefs and local festivals)",
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
                    controller: name,
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
                SizedBox(height:30),
                Text(
                  "Description",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    minLines: 1,
                    maxLines: null,
                    controller: description,
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
                  onTap: _takePhoto,
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
                              child: Icon(Icons.camera_alt,
                                  color: Colors.blue[900], size: 29),
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

                Column(
                  children:[
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10),
                    itemCount: Tradition._images.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return ImageTile(context, index, Tradition._images);
                    }

                ),
                    GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150,
                            childAspectRatio: 2 / 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10),
                        itemCount: _videos.length,
                        itemBuilder: (BuildContext ctx, index) {
                          _controller = VideoPlayerController.file(_videos[index])
                            ..initialize()
                            ..setVolume(0.0);
                          return VideoTile(context,_controller, index, _videos);
                        }),

                  ]

                )],
            ),
          ),
          uploading ? uploader() : Container()
        ]),
      ),
    );
  }

  void _takePhoto() async {
    try {
      await picker
          .pickImage(source: ImageSource.camera)
          .then((recordedImage) async {
        if (recordedImage != null && recordedImage.path != null) {
          setState(() {
            Tradition._images.add(File(recordedImage.path));
          });
        } else if (recordedImage.path == null) {
          retrieveLostData(Tradition._images);
        }

        print("list==${Tradition._images}");
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
      setState(() {
        _fileType.add(File(response.file.path));
      });
    } else {
      print("File lost==${response.file}");
    }
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

  Future _uploadPhoto(String key) async {
    final _storage = FirebaseStorage.instance;

    var i = 1;
    setState(() {
      uploading = true;
    });

    for (var img in Tradition._images) {
      setState(() {
        value = progressTrack / (Tradition._images.length + _videos.length);
      });
      var ref = _storage.ref().child("images/${Path.basename(img.path)}");
      await ref.putFile(img).onComplete;
      await ref.getDownloadURL().then((value) => SignUp.fb
          .reference()
          .child(key)
          .child("Tradition")
          .child("images")
          .child("TraditionImage$i")
          .set(value));
      i++;
      progressTrack++;

      print("uploadedPhoto");
    }
  }

  Future _uploadVideo(String key) async {
    final _storage = FirebaseStorage.instance;
    var i = 1;

    for (var video in _videos) {
      setState(() {
        value = progressTrack / (Tradition._images.length + _videos.length);
      });
      var ref = _storage.ref().child("videos/${Path.basename(video.path)}");
      await ref.putFile(video).onComplete;
      await ref.getDownloadURL().then((value) => SignUp.fb
          .reference()
          .child(key)
          .child("Tradition")
          .child("videos")
          .child("TraditionVideo$i")
          .set(value));
      i++;
      progressTrack++;
    }
    setState(() {
      uploading = false;
    });
  }

  Future _uploadDetails(String key) async {
    SignUp.fb
        .reference()
        .child(key)
        .child("Tradition")
        .child("Description")
        .set(description.text)
        .whenComplete(
            () => _uploadPhoto(key).whenComplete(() => _uploadVideo(key)));
  }

  Widget uploader() {
    return Center(
        child: Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.toString() == '0.0'
                ? '0%'
                : "${(value * 100).round().toString()}%",
            style: TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          CircularProgressIndicator(
            color: Colors.white,
            value: value,
          ),
          SizedBox(height: 12),
          Text(
            "Uploading...",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
          )
        ],
      ),
    ));
  }

   Widget ImageTile(BuildContext cxt, int index, List list) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        child: Stack(children: [
          Container(
            // height:150,
            width: 120,
            color: Colors.green,
            child: Image.file(
              list[index],
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: -2,
            top: -10,
            child: IconButton(
              icon: Icon(Icons.cancel, color: Colors.red, size: 23),
              onPressed: () {
                setState(() {
                  list.removeAt(index);
                });
              },
            ),
          )
        ])
        );
  }

  Widget VideoTile(BuildContext ctx,VideoPlayerController controller, int index, List list) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        child: Stack(children: [
          Container(
              // height:150,
              // width: 120,
              color: Colors.green,
              child: VideoPlayer(controller)),
          _PlayPauseOverlay(controller),
          Positioned(
            right: -2,
            top: -10,
            child: IconButton(
              icon: Icon(Icons.cancel, color: Colors.red, size: 23),
              onPressed: () {
                setState(() {
                  list.removeAt(index);
                });
              },
            ),
          )
        ]));
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay( this.controller);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      controller.value.isPlaying?Icons.pause:Icons.play_arrow,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}
