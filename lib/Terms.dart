import 'package:flutter/material.dart';
import 'package:leotrip/AddPlace.dart';
import 'package:leotrip/login.dart';

import 'AddPlace.dart';



void main() {
  runApp(MaterialApp(
    home: Terms()),
  );
}

class Terms extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, 
        title: Text('Terms and Conditions'),
      ),
  body: new Container(
    decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/add.png"),
            fit: BoxFit.cover,
            
          ),
        ),
    child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: RaisedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
        },
           child: Text("I Agree")
            ),  
          ),
        ),
    );
  }
}