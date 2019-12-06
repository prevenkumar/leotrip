import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';



String apptitle;


String pathAsset = 'assets/images/sliverwork.jpg';
File _image;
class TabScreen extends StatefulWidget {
  TabScreen();

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List data;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('LeoTrip'),
             
          ),
          resizeToAvoidBottomPadding: false,
         
          body: ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Card(
                        elevation: 5,
                        child: InkWell(
                            child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: <Widget>[
                                
                            
                   Container(
                                  height: 130,
                                  width: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                    _image == null ? AssetImage(pathAsset) : NetworkImage("http://leotrip1app.000webhostapp.com/leotrip/location/${data[index]['locationname']}.jpg"),
                   // _image == null ? AssetImage(pathAsset) : FileImage(_image),
                    fit: BoxFit.fill,
                   )),
                                ),
                                   
                               // ),
                                //Text("http://leotrip1app.000webhostapp.com/leotrip/location/${data[index]['locationname']}.jpg"),
                              //  _image == null
                       // ? AssetImage(pathAsset)
                       // : FileImage(_image),
                   // fit: BoxFit.fill,
                                    Text(
                                              data[index]['locationname']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                       Text(data[index]['map']),
                                       Text(data[index]['city']),
                                       Text(data[index]['state']),   
                                  ],
                                )))));
              }
              //Step 6: Count the data
              ),
        ));
  }

  Future<String> makeRequest() async {
    String urlLoadLocations =
        "http://leotrip1app.000webhostapp.com/leotrip/php/load_location.php";
    http.post(urlLoadLocations, body: {
      // "email": widget.email,
    }).then((res) {
      setState(() {
        // print(res.body);
        var extractdata = json.decode(res.body);
        data = extractdata["locations"] ?? '';
        print(extractdata);
      });
    }).catchError((err) {
      print(err);
    });
    return null;
  }

  Future init() async {
    this.makeRequest();
  }

}
