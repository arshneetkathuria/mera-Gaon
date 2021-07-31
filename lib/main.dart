//@dart=2.9
import 'package:flutter/material.dart';
import 'package:govt_survey/Service/common_functions.dart';
import 'package:govt_survey/Views/Detail%20Collection/LocationTrack.dart';
import 'Views/Home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var email=await CommonFunctions.getSharedPreferences('email');
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: email==null?Home():LocationTrack()));
}
