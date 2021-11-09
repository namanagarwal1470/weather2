import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class data extends StatefulWidget {
  data({Key? key}) : super(key: key);

  @override
  _dataState createState() => _dataState();
}

class _dataState extends State<data> {
  int temperature = 0;
  String location = 'London';
  int woeid = 44418;
  String weather = 'clear';
  String searchapiurl =
      'https://www.metaweather.com/api/location/search/?query=';
  String locationapiurl = 'https://www.metaweather.com/api/location/';
  void fetchsearch(String input) async {
    var endpoint = Uri.parse(searchapiurl + input);
    var searchresult = await http.get(endpoint);
    var result = json.decode(searchresult.body);
    print(result);
    setState(() {
      location = result[0]["title"];
      woeid = result[0]["woeid"];
    });
  }

  void fetchlocation() async {
    var endpoint = Uri.parse(locationapiurl + woeid.toString());
    var locationresult = await http.get(endpoint);
    var result = json.decode(locationresult.body);
    var consolatedweather = result["consolidated_weather"];
    var data = consolatedweather[0];

    setState(() {
      temperature = data["the_temp"].round();
      weather = data["weather_state_name"]
          .replaceAll(' ', '')
          .toString()
          .toLowerCase();
    });
  }

  void onTextFieldSubmitted(String input) {
    fetchsearch(input);
    fetchlocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/$weather.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                        width: 300,
                        child: TextField(
                          onSubmitted: (String input) {
                            onTextFieldSubmitted(input);
                          },
                          style: TextStyle(color: Colors.white, fontSize: 25),
                          decoration: InputDecoration(
                              hintText: 'search another location',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.white)),
                        )),
                    SizedBox(height: 100, width: 100),
                    Center(
                      child: Text(
                        temperature.toString() + 'C',
                        style: TextStyle(color: Colors.white, fontSize: 60),
                      ),
                    ),
                    Center(
                      child: Text(
                        location,
                        style: TextStyle(color: Colors.white, fontSize: 60),
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
