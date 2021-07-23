import 'package:flutter/material.dart';

import 'LogIn.dart';
import 'SignUp.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Container(
      height:1000,
      decoration:  BoxDecoration(
        image:  DecorationImage(
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4),BlendMode.darken),
          image:  AssetImage('assets/images/survey-app.jpeg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: <Widget>[
          // Padding(padding: EdgeInsets.only(top:40.0,left:30),
          //   child: Container(
          //     width: 370,
          //     height:370,
          //     decoration:  BoxDecoration(
          //       image:  DecorationImage(
          //         image:  AssetImage('images/logo.png'),
          //         fit: BoxFit.fill,),),
          //   ),
          // ),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 20, top: 150,bottom:20),
              child:
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
              )
          ),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 20, top: 5,bottom:30),
              child:
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
          )
        ],
      ),
    )
    );
  }
}
