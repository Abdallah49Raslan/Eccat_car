import 'dart:async';
import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_two/constants.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  String Driverheart = "";
  String Drivertemp = "";
  String Driveroximeter = "";
  final database = FirebaseDatabase.instance.reference();
  num? displaytemp;
  num? displayheartRat;
  num? displayoximeter;

  late StreamSubscription outputstream;

  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    outputstream = database.child('output').onValue.listen((event) {
      final num? temp = event.snapshot.child('temp').value as num;
      final num? heartRate = event.snapshot.child('heartRate').value as num;
      final num? oximeter = event.snapshot.child('oximeter').value as num;

      setState(() {
        displaytemp = temp!;
        displayheartRat = heartRate!;
        displayoximeter = oximeter!;
      });
    });
  }

  Widget TemperatureCondition() {
    if (displaytemp == null) {
      return Text("",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ));
    } else if (36 <= displaytemp! && displaytemp! <= 37.2) {
      Drivertemp = "Normal";
      return Text('$Drivertemp',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ));
    } else {
      Drivertemp = "Abnormal";
      return Text('$Drivertemp',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0XFFC6372A),
          ));
    }
  }

  Widget HeartRateCondition() {
    if (displayheartRat == null) {
      return Text("",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ));
    } else if (60 <= displayheartRat! && displayheartRat! <= 100) {
      Driverheart = " Normal";
      return Text('$Driverheart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ));
    } else {
      Driverheart = "Abnormal";
      return Text('$Driverheart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0XFFC6372A),
          ));
    }
  }

  Widget OximeterCondition() {
    if (displayheartRat == null) {
      return Text("",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ));
    } else if (90 <= displayoximeter! && displayoximeter! <= 100) {
      Driveroximeter = "Normal";
      return Text('$Driveroximeter',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ));
    } else {
      Driveroximeter = "Abnormal";
      return Text('$Driveroximeter',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0XFFC6372A),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("HealthCare",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        body: Column(children: [
          Container(
              width: double.infinity,
              height: (550),
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              /* decoration: BoxDecoration(
                image: DecorationImage(
                    // fit: BoxFit.fill,
                    image: AssetImage("assets/icons/Car.png")),
              ),*/
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.3,
                ),
                children: [
                  Container(
                    padding: EdgeInsets.all(13),
                    color: Colors.white10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Heart Rate",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Text(
                              '$displayheartRat',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "BPM",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Normal",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "60  : 100\nNormal",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ])
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 6,
                    child: SvgPicture.asset(
                      "assets/icons/heart-rate.svg",
                      height: 30,
                      width: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ))
        ]));
  }

  void deactivate() {
    outputstream.cancel();
    super.deactivate();
  }
}
