import 'dart:async';
import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_two/constants.dart';

class FireTwo extends StatefulWidget {
  const FireTwo({super.key});

  @override
  State<FireTwo> createState() => _FireTwoState();
}

class _FireTwoState extends State<FireTwo> {
  final database = FirebaseDatabase.instance.reference();
  String displaytemp = "";
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
      final Object? temp = event.snapshot.child('temp').value;
      final Object? heartRate = event.snapshot.child('heartRate').value;
      final Object? oximeter = event.snapshot.child('oximeter').value;
      final Object? alcohol = event.snapshot.child('alcohol').value;

      setState(() {
        displaytemp = '$displaytemp';
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
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                    // fit: BoxFit.fill,
                    image: AssetImage("assets/icons/Car.png")),
              ),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      border: Border.all(color: primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Text(" Driver",
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
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/heart-rate.svg",
                                    height: 20, width: 20, color: Colors.white),
                                Text(
                                  " Heart Rate",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displayheartRat',
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
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        //second sensor=============================================================
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/temperature-high-solid-svgrepo-com.svg",
                                    height: 25,
                                    width: 25,
                                    color: Colors.white),
                                Text(
                                  " Temperature",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displaytemp',
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
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        //Third sensor===================================================================
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icons/oxi3.png",
                                  height: 30,
                                  width: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Oximeter",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displayoximeter',
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
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        //fourth sensor===================================================================
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/icons/alcohol.png",
                                    height: 22, width: 22, color: Colors.white),
                                Text(
                                  " Alcohol",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displayalcohol',
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      border: Border.all(color: primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Text(" Passenger 1",
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
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/heart-rate.svg",
                                    height: 20, width: 20, color: Colors.white),
                                Text(
                                  " Heart Rate",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displayheartRat',
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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //second sensor=============================================================
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/temperature-high-solid-svgrepo-com.svg",
                                    height: 25,
                                    width: 25,
                                    color: Colors.white),
                                Text(
                                  " Temperature",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displaytemp',
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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //Third sensor===================================================================
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icons/oxi3.png",
                                  height: 30,
                                  width: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Oximeter",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displayoximeter',
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      border: Border.all(color: primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Text(" Passenger 2",
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
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/heart-rate.svg",
                                    height: 20, width: 20, color: Colors.white),
                                Text(
                                  " Heart Rate",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displayheartRat',
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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //second sensor=============================================================
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/temperature-high-solid-svgrepo-com.svg",
                                    height: 25,
                                    width: 25,
                                    color: Colors.white),
                                Text(
                                  " Temperature",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displaytemp',
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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //Third sensor===================================================================
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icons/oxi3.png",
                                  height: 30,
                                  width: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Oximeter",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displayoximeter',
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      border: Border.all(color: primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Text(" Passenger 3",
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
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/heart-rate.svg",
                                    height: 20, width: 20, color: Colors.white),
                                Text(
                                  " Heart Rate",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displayheartRat',
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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //second sensor=============================================================
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/temperature-high-solid-svgrepo-com.svg",
                                    height: 25,
                                    width: 25,
                                    color: Colors.white),
                                Text(
                                  " Temperature",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displaytemp',
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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //Third sensor===================================================================
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icons/oxi3.png",
                                  height: 30,
                                  width: 30,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Oximeter",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '$displayoximeter',
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    TestButtonREf.set({'TestButton': 'on'});
                  },
                  child: Text(
                    "Test Now",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0XFFFF5368),
                      padding: EdgeInsets.all(10),
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ));
  }
}
