import 'package:flutter/material.dart';
import 'package:govt_survey/Views/VillageAssign/VillageDashboard.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Components
{
  static Widget setBackground()
  {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Asset 55.png"), // <-- BACKGROUND IMAGE
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Widget setBottomNavigationBar(BuildContext context,nextRoute)
  {
    return Container(
      color: Colors.blue[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
                      color: Colors.white,
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
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )),
          GestureDetector(
              onTap: () async {
                // FirebaseUser user = await SignUp.auth.currentUser();
                // var userId = AuthService.currentUID.toString();
                // print("UserID=$userId");
                // _uploadDetails(userId).whenComplete(() => Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => Tradition())));
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => nextRoute));
              },
              child: Padding(
                padding: EdgeInsets.only(right: 50, bottom: 30),
                child: Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ))
        ],
      ),
    );
  }

  static showPopUp(BuildContext context)
  {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(icon:Icon(Icons.cancel,size: 30,color:Colors.grey[500]), onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context)=>VillageDashboard()));},)
          ],
        ),
        content:Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/tenor.gif",width:150,height:150),
              SizedBox(height:20),
              Text("Details Saved!!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),)
            ],
          ),
        ),
        actions: <Widget>[
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.green,
            onPressed: () =>  Navigator.push(context,MaterialPageRoute(builder: (context)=>VillageDashboard())),
          ),

        ],

      );
    });
  }

}