import 'dart:convert';

import 'package:clima/Screens/screen_1.dart';
import 'package:clima/Services/Location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    if(mounted){
      getLocation();
    }
    super.initState();
  }

  void getLocation() async {
    Location location = Location();
    location.getLocation();
    double lon = location.longitude;
    double lat = location.latitude;
    var api = "ypur_api";
    var apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}";
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'lat': lat.toString(), 'lon': lon.toString(), 'appid':api});
    var response=await http.get(url);
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Screen1()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.grey,
          size: 50,
        )
      ),
    );
  }
}
