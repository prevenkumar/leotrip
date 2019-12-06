import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leotrip/tab_screen.dart';
import 'package:leotrip/tab_screen2.dart';
import 'package:leotrip/tab_screen3.dart';


class MainScreen extends StatefulWidget {
  final String email;

 const MainScreen({Key key,this.email}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 List<Widget> tabs;

 int currentTabIndex = 0;

 @override
  void initState() {
    super.initState();
    tabs = [
      TabScreen(),
      TabScreen2(),
      TabScreen3(),
    ];
  }

  String $pagetitle = "LeoTrip";

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        //backgroundColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed ,
        
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search,color: Color.fromRGBO(8, 196, 49, 1)),
            title: Text("Search")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,color: Color.fromRGBO(8, 196, 49, 1)),
            title: Text("Add Location"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Color.fromRGBO(8, 196, 49, 1)),
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }
}
