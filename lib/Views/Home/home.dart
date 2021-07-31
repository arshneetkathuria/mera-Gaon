import 'package:flutter/material.dart';
import 'package:govt_survey/Service/common_functions.dart';
import 'package:govt_survey/Views/Detail%20Collection/LocationTrack.dart';

import '../Login/LogIn.dart';
import '../SignUp/SignUp.dart';


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
        height:1000,
        decoration:  BoxDecoration(
          image:  DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4),BlendMode.darken),
            image:  AssetImage('assets/images/Asset 55.png'),
            fit: BoxFit.fill,
          ),
        ),
    ),
    Positioned(
      top:MediaQuery.of(context).size.height*0.1,
      child: Container(
        width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Image.asset(
      'assets/images/map.png',
        height:500,
        fit: BoxFit.contain,
      ),
      ),
    ),

        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: <Widget>[

                Container(
                  margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.6),
                  width: 350,
                  height: 50,
                  child:
                  RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),),
                    child: Text(
                        'LogIn',
                        style:TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.w800,
                            fontSize: 20
                        )),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LogIn()));
                    },
                  ),
                ),
                Container(
                  width: 350,
                  height: 50,
                  child:
                  RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                      side: BorderSide(color: Colors.white,width:0.5),),
                    child: Text(
                        'Sign Up',
                        style:TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.w800,
                            fontSize: 20
                        )),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),

    ]);

  }


}
