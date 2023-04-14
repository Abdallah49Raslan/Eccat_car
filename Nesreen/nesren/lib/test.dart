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
  final database = FirebaseDatabase.instance.reference();
  num? displaytemp;
  String displayheartRat = "";
  String displayoximeter = "";
  String displayalcohol = "";
  late StreamSubscription outputstream;

  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    outputstream = database.child('output').onValue.listen((event) {
      final num? temp = event.snapshot.child('temp').value as num;
      final Object? heartRate = event.snapshot.child('heartRate').value;
      final Object? oximeter = event.snapshot.child('oximeter').value;
      final Object? alcohol = event.snapshot.child('alcohol').value;

      setState(() {
        displaytemp = temp!;
        displayheartRat = '$heartRate';
        displayoximeter = '$oximeter';
        displayalcohol = '$alcohol';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final TestButtonREf = database.child("TestNow");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: redColor,
          title: Text("HealthCare",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        body: Column(
          children: [
            Container(
                width: double.infinity,
                height: (550),
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                child: GridView.count(
                  childAspectRatio: 2.2,
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    buildGridCard(
                      label: "Driver",
                      title1: "Heart Rate",
                      title2: "Temperature",
                      title3: "Oximeter",
                      title4: "Alcohol",
                      icon1: 'assets/icons/heart-rate.svg',
                      icon2:
                          'assets/icons/temperature-high-solid-svgrepo-com.svg',
                      icon3: 'assets/icons/oxi3.png',
                      icon4: 'assets/icons/alcohol.png',
                      value1: '$displayheartRat',
                      value2: '$displaytemp',
                      value3: '$displayoximeter',
                      value4: '$displayalcohol',
                    ),
                    buildGridCard(
                      label: "Passenger 1",
                      title1: "Heart Rate",
                      title2: "Temperature",
                      title3: "Oximeter",
                      title4: "",
                      icon1: 'assets/icons/heart-rate.svg',
                      icon2:
                          'assets/icons/temperature-high-solid-svgrepo-com.svg',
                      icon3: 'assets/icons/oxi3.png',
                      icon4: '',
                      value1: '$displayheartRat',
                      value2: '$displaytemp',
                      value3: '$displayoximeter',
                      value4: '',
                    ),
                    buildGridCard(
                      label: "Passenger 2",
                      title1: "Heart Rate",
                      title2: "Temperature",
                      title3: "Oximeter",
                      title4: "",
                      icon1: 'assets/icons/heart-rate.svg',
                      icon2:
                          'assets/icons/temperature-high-solid-svgrepo-com.svg',
                      icon3: 'assets/icons/oxi3.png',
                      icon4: '',
                      value1: '$displayheartRat',
                      value2: '$displaytemp',
                      value3: '$displayoximeter',
                      value4: '',
                    ),
                  ],
                ))
          ],
        ));
  }

  Widget buildGridCard({
    String? label,
    String? title1,
    String? title2,
    String? title3,
    String? title4,
    String? icon1,
    String? icon2,
    String? icon3,
    String? icon4,
    String? value1,
    String? value2,
    String? value3,
    String? value4,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border.all(color: primaryColor, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Text(label!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.white54)),
          SizedBox(
            height: 10,
          ),

          //first sensor===================================================================

          Row(
            children: [
              SvgPicture.asset(icon1!,
                  height: 20, width: 20, color: Colors.white),
              Text(
                title1!,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                width: 70,
              ),
              Text(
                value1!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Text(
                "Normal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),

          //second sensor=============================================================
          Row(
            children: [
              SvgPicture.asset(icon2!,
                  height: 25, width: 25, color: Colors.white),
              Text(
                title2!,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                value2!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              //TemperatureCondition()
              Text(
                "Normal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              )
            ],
          ),

          SizedBox(
            height: 5,
          ),

          //Third sensor===================================================================

          Row(
            children: [
              Image.asset(
                icon3!,
                height: 30,
                width: 30,
                color: Colors.white,
              ),
              Text(
                title3!,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                width: 80,
              ),
              Text(
                value3!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Text(
                "Normal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              )
            ],
          ),

          SizedBox(
            height: 5,
          ),

          //fourth sensor===================================================================

          Row(
            children: [
              Image.asset(icon4!, height: 22, width: 22, color: Colors.white),
              Text(
                title4!,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                width: 90,
              ),
              Text(
                value4!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Text(
                "Normal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              )
            ],
          ),

          SizedBox(
            width: 40,
          ),
        ],
      ),
    );

    /*Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: primaryColor)),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Text(
                        lable1!,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        lable2!,
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
                              dis!,
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
                              info!,
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
                icon!,
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ],
        )
        );*/
  }

  void deactivate() {
    outputstream.cancel();
    super.deactivate();
  }
}
