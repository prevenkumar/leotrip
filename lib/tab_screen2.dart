import 'package:flutter/material.dart';
import 'package:leotrip/login.dart';
 
class TabScreen2 extends StatefulWidget {
  //final String apptitle;
  TabScreen2();

  @override
  _TabScreen2State createState() => _TabScreen2State();
}

class _TabScreen2State extends State<TabScreen2> {
  @override
  Widget build(BuildContext context) {
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