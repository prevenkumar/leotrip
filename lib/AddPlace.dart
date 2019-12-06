import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:leotrip/mainscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';



void main() {
  runApp(MaterialApp(
    home: AddPlacesScreen(),
  ));
}

String pathAsset = 'assets/images/addloc.png';
String urlUpload = "http://leotrip1app.000webhostapp.com/leotrip/php/addlocation.php";
File _image;
final TextEditingController _lnamecontroller = TextEditingController();
final TextEditingController _mapcontroller = TextEditingController();
final TextEditingController _citycontroller = TextEditingController();
final TextEditingController _statecontroller = TextEditingController();
final TextEditingController _ratingcontroller = TextEditingController();
String _locationname, _map, _city, _state,_rating;




class AddPlacesScreen extends StatefulWidget {
  @override
  _AddPlacesState createState() => _AddPlacesState();
  const AddPlacesScreen({Key key, File image}) : super(key: key);
}

class _AddPlacesState extends State<AddPlacesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.green, 
          title: Text('Add Your Location'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: LocationWidget(),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    _image = null;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen()),
        );
    return Future.value(false);
  }
}

class LocationWidget extends StatefulWidget {
  @override
  LocationWidgetState createState() => LocationWidgetState();
}

class LocationWidgetState extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
            onTap: _choose,
            child: Container(
              width: 180,
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _image == null
                        ? AssetImage(pathAsset)
                        : FileImage(_image),
                    fit: BoxFit.fill,
                  )),
            )),
        Text('Click on image above to take picture'),
        TextField(
            controller: _lnamecontroller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Location Name',
              icon: Icon(Icons.location_on),
            )),
        TextField(
            controller: _mapcontroller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Latitude & Longitude',
              icon: Icon(Icons.location_searching),
            )),
        TextField(
          controller: _citycontroller,
          keyboardType: TextInputType.text,
          decoration:
              InputDecoration(labelText: 'City', icon: Icon(Icons.location_city)),
          
        ),
        TextField(
            controller: _statecontroller,
            keyboardType: TextInputType.text,
            decoration:
                InputDecoration(labelText: 'State', icon: Icon(Icons.map))),
        SizedBox(
          height: 10,
        ),
        TextField(
            controller: _ratingcontroller,
            keyboardType: TextInputType.phone,
            decoration:
                InputDecoration(labelText: 'Rating', icon: Icon(Icons.thumbs_up_down))),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          minWidth: 300,
          height: 50,
          child: Text('Add Location'),
          color: Colors.green,
          textColor: Colors.white,
          elevation: 15,
          onPressed: _onRegister,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void _choose() async {
    _image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
    //_image = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  void _onRegister() {
    print('onRegister Button from RegisterUser()');
    print(_image.toString());
    uploadData();
  }

  //void _onBackPress() {
   // _image = null;
   // print('onBackpress from RegisterUser');
   // Navigator.pushReplacement(context,
   //     MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  //}

  void uploadData() {
    _locationname = _lnamecontroller.text;
    _map = _mapcontroller.text;
    _city = _citycontroller.text;
    _state = _statecontroller.text;
    _rating = _ratingcontroller.text;

    if ((_locationname.isNotEmpty) &&
        (_map.isNotEmpty) &&
        (_image != null) && 
        (_state.isNotEmpty)&&
        (_rating.isNotEmpty)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Uploading in progress");
      pr.show();

      String base64Image = base64Encode(_image.readAsBytesSync());
      http.post(urlUpload, body: {
        "encoded_string": base64Image,
        "locationname": _locationname,
        "map": _map,
        "city": _city,
        "state": _state,
        "rating": _rating,

      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _image = null;
        _lnamecontroller.text = '';
        _mapcontroller.text = '';
        _citycontroller.text = '';
        _statecontroller.text = '';
        _ratingcontroller.text = '';
        pr.dismiss();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
      }).catchError((err) {
        print(err);
      });
    } else {
      Toast.show("Check your location information", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
}