import 'package:flutter/material.dart';
 
class TabScreen3 extends StatefulWidget {
  //final String apptitle;
  TabScreen3();

  @override
  _TabScreen3State createState() => _TabScreen3State();
}

class _TabScreen3State extends State<TabScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, 
        title: Text('My Profile'),
      ),
    );
  }
}