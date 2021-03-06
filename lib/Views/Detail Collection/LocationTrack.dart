import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:govt_survey/Service/FirebaseAuthService.dart';
import 'package:govt_survey/Views/Home/home.dart';
import 'package:govt_survey/Views/VillageAssign/VillageDashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SignUp/SignUp.dart';

class LocationTrack extends StatefulWidget {
  @override
  _LocationTrackState createState() => _LocationTrackState();
}

class _LocationTrackState extends State<LocationTrack> {
  logOut(BuildContext context) async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('email');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  late Position currentPosition;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  Set<Marker> markers = {};
  late GoogleMapController newGoogleMapController;
  List<Placemark> placemarks = [];

  void setMarker() async {
    markers.add(Marker(
        markerId: MarkerId("id1"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(37.42796133580664, -122.085749655962)));
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    LatLng latLng = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLng, zoom: 14);

    setState(() {
      markers.add(Marker(
          markerId: MarkerId("id1"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: latLng));
    });

    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    getAddress(latLng);
  }

  void getAddress(LatLng latlng) async {
    // FirebaseUser user=await SignUp.auth.currentUser();
    AuthService.currentUID.then((value) async {
      placemarks =
          await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
      FirebaseDatabase database=await AuthService.databaseInstance;
      var ref =database.reference().child(value).child("Location");
      ref.child("street").set(placemarks[0].street);
      ref.child("Country").set(placemarks[0].country);
      ref.child("PostalCode").set(placemarks[0].postalCode);
      ref.child("AdministrativeArea").set(placemarks[0].administrativeArea);
      ref.child("SubadministrativeArea").set(placemarks[0].subAdministrativeArea);
      ref.child("locality").set(placemarks[0].locality);
      ref.child("subLocality").set(placemarks[0].subLocality);
      ref.child("thoroughfare").set(placemarks[0].thoroughfare);
      ref.child("subThoroughfare").set(placemarks[0].subThoroughfare);

    });


  }

  @override
  void initState() {
    setMarker();
    locatePosition();
    super.initState();
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
                  "Cancel",
                  style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VillageDashboard()));
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
        title: Text("Your Location"),
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
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Icon(Icons.logout)
              ),
            ),
            onTap: () {
              logOut(context);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 10, top: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Save Your Location",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23)),
              SizedBox(height: 20),

              SizedBox(height: 30),
              SizedBox(height: 20),
              Container(
                  // padding: EdgeInsets.only(right:10),
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black)),
                  child: GoogleMap(
                    markers: markers,
                    myLocationButtonEnabled: true,
                    compassEnabled: true,
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(37.42796133580664, -122.085749655962),
                        zoom: 12),
                    onMapCreated: (GoogleMapController controller) {
                      _controllerGoogleMap.complete(controller);
                      newGoogleMapController = controller;
                      locatePosition();
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
