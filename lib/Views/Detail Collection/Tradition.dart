//@dart=2.9
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:govt_survey/Views/LayoutComponents/Layout.dart';
import 'package:govt_survey/Views/WidgetComponents/Components.dart';
import 'package:video_player/video_player.dart';
import 'FineArts.dart';

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
  // static double progressTrack = 1;
  var name=TextEditingController();
  Map<String,dynamic> traditionDetail={};


  // String albumName = 'Media';
  // final int maxLine = 5;
  // static List<File> _videos = [];
  // final picker = new ImagePicker();

  Layout tradition=new Layout();




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
    return Stack(
      children:[
        Components.setBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
        bottomNavigationBar: Components.setBottomNavigationBar(context, FineArts()),
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
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
    child:Padding(
    padding: EdgeInsets.only(left: 20, right: 10, top: 40),
    child: Column(
              children: [
                tradition.createMultipleSelection("Folklores practised in the village", 'folklores',traditionDetail),
                tradition.createMultipleSelection("Rituals and Practices of the villagers", 'rituals',traditionDetail),
                tradition.createMultipleSelection("Famous dishes prepared in the village along with its recipies", 'dishes',traditionDetail),
              ],
            ),
          ),
        ),
      ),
   ] );
  }


  // Future _uploadPhoto(String key) async {
  //   final _storage = FirebaseStorage.instance;
  //
  //   var i = 1;
  //   setState(() {
  //     uploading = true;
  //   });
  //
  //   for (var img in Tradition._images) {
  //     setState(() {
  //       value = progressTrack / (Tradition._images.length + _videos.length);
  //     });
  //     var ref = _storage.ref().child("images/${Path.basename(img.path)}");
  //     await ref.putFile(img).onComplete;
  //     await ref.getDownloadURL().then((value) => SignUp.fb
  //         .reference()
  //         .child(key)
  //         .child("Tradition")
  //         .child("images")
  //         .child("TraditionImage$i")
  //         .set(value));
  //     i++;
  //     progressTrack++;
  //
  //     print("uploadedPhoto");
  //   }
  // }
  //
  // Future _uploadVideo(String key) async {
  //   final _storage = FirebaseStorage.instance;
  //   var i = 1;
  //
  //   for (var video in _videos) {
  //     setState(() {
  //       value = progressTrack / (Tradition._images.length + _videos.length);
  //     });
  //     var ref = _storage.ref().child("videos/${Path.basename(video.path)}");
  //     await ref.putFile(video).onComplete;
  //     await ref.getDownloadURL().then((value) => SignUp.fb
  //         .reference()
  //         .child(key)
  //         .child("Tradition")
  //         .child("videos")
  //         .child("TraditionVideo$i")
  //         .set(value));
  //     i++;
  //     progressTrack++;
  //   }
  //   setState(() {
  //     uploading = false;
  //   });
  // }

  // Future _uploadDetails(String key) async {
  //   SignUp.fb
  //       .reference()
  //       .child(key)
  //       .child("Tradition")
  //       .child("Description")
  //       .set(description.text)
  //       .whenComplete(
  //           () => _uploadPhoto(key).whenComplete(() => _uploadVideo(key)));
  // }

  // Widget uploader() {
  //   return Center(
  //       child: Container(
  //     height: MediaQuery.of(context).size.height * 0.3,
  //     width: MediaQuery.of(context).size.width * 0.7,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       color: Colors.black87,
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           value.toString() == '0.0'
  //               ? '0%'
  //               : "${(value * 100).round().toString()}%",
  //           style: TextStyle(
  //               color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 10),
  //         CircularProgressIndicator(
  //           color: Colors.white,
  //           value: value,
  //         ),
  //         SizedBox(height: 12),
  //         Text(
  //           "Uploading...",
  //           style: TextStyle(
  //               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23),
  //         )
  //       ],
  //     ),
  //   ));
  // }
  //
  //  Widget ImageTile(BuildContext cxt, int index, List list) {
  //   return Container(
  //       margin: EdgeInsets.only(top: 15),
  //       child: Stack(children: [
  //         Container(
  //           // height:150,
  //           width: 120,
  //           color: Colors.green,
  //           child: Image.file(
  //             list[index],
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         Positioned(
  //           right: -2,
  //           top: -10,
  //           child: IconButton(
  //             icon: Icon(Icons.cancel, color: Colors.red, size: 23),
  //             onPressed: () {
  //               setState(() {
  //                 list.removeAt(index);
  //               });
  //             },
  //           ),
  //         )
  //       ])
  //       );
  // }
//
//   Widget VideoTile(BuildContext ctx,VideoPlayerController controller, int index, List list) {
//     return Container(
//         margin: EdgeInsets.only(top: 15),
//         child: Stack(children: [
//           Container(
//               // height:150,
//               // width: 120,
//               color: Colors.green,
//               child: VideoPlayer(controller)),
//           _PlayPauseOverlay(controller),
//           Positioned(
//             right: -2,
//             top: -10,
//             child: IconButton(
//               icon: Icon(Icons.cancel, color: Colors.red, size: 23),
//               onPressed: () {
//                 setState(() {
//                   list.removeAt(index);
//                 });
//               },
//             ),
//           )
//         ]));
//   }
// }

// class _PlayPauseOverlay extends StatelessWidget {
//   const _PlayPauseOverlay( this.controller);
//
//   final VideoPlayerController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimatedSwitcher(
//           duration: Duration(milliseconds: 50),
//           reverseDuration: Duration(milliseconds: 200),
//           child: controller.value.isPlaying
//               ? SizedBox.shrink()
//               : Container(
//                   color: Colors.black26,
//                   child: Center(
//                     child: Icon(
//                       controller.value.isPlaying?Icons.pause:Icons.play_arrow,
//                       color: Colors.white,
//                       size: 20.0,
//                     ),
//                   ),
//                 ),
//         ),
//         GestureDetector(
//           onTap: () {
//             controller.value.isPlaying ? controller.pause() : controller.play();
//           },
//         ),
//       ],
//     );
//   }
}
