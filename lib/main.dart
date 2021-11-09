import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      '/': (context) => loadpage(),
      'home': (context) => data(),
    });
  }
}

class loadpage extends StatefulWidget {
  @override
  _loadpageState createState() => _loadpageState();
}

class _loadpageState extends State<loadpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/weatherimage.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 140,
              width: 30,
            ),
            Center(
                child: Text(
              "Weather",
              style: TextStyle(color: Colors.white, fontSize: 80),
            )),
            SizedBox(
              height: 5,
              width: 30,
            ),
            Center(
                child: Text(
              "App",
              style: TextStyle(color: Colors.white, fontSize: 70),
            )),
            SizedBox(
              height: 60,
              width: 30,
            ),
            Container(
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: Ink(
                    child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  color: Colors.white,
                  splashColor: Colors.blue,
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pushNamed(context, 'home');
                  },
                ))),
          ],
        ),
      ),
    );
  }
}
