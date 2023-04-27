import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:security/core/colors.dart';
import 'package:security/core/globalvariables.dart';
import 'package:security/page/Health Care/HealthConditions.dart';
import 'package:security/page/Health Care/DriverGrid.dart';
import 'package:security/page/Health Care/Passenger1Grid.dart';
import 'package:security/page/Health Care/Passenger2Grid.dart';

class HealthCareDriver extends StatefulWidget {
  const HealthCareDriver({super.key});

  @override
  State<HealthCareDriver> createState() => _darkmodeState();
}

class _darkmodeState extends State<HealthCareDriver> {
  final database = FirebaseDatabase.instance.reference();
  late StreamSubscription outputstream;

  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    //Driver values
    outputstream = database.child('output').onValue.listen((event) {
      final num? temp = event.snapshot.child('temp').value as num;
      final num? heartRate = event.snapshot.child('heartRate').value as num;
      final num? oximeter = event.snapshot.child('oximeter').value as num;
      final Object? alcohol = event.snapshot.child('alcohol').value;
      //Passenger1 values
      final num? P1heartRate =
          event.snapshot.child('passenger1heartRate').value as num;
      final num? P1temperature =
          event.snapshot.child('passenger1temperature').value as num;
      final num? P1oximeter =
          event.snapshot.child('passenger1oximeter').value as num;
      //Passenger2 values
      final num? P2heartRate =
          event.snapshot.child('passenger2heartRate').value as num;
      final num? P2temperature =
          event.snapshot.child('passenger2temperature').value as num;
      final num? P2oximeter =
          event.snapshot.child('passenger2oximeter').value as num;

      setState(() {
        Ddisplaytemp = temp!;
        DdisplayheartRat = heartRate!;
        Ddisplayoximeter = oximeter!;
        displayalcohol = '$alcohol';
//
        P1displaytemp = P1temperature!;
        P1displayheartRate = P1heartRate!;
        P1displayoximeter = P1oximeter!;
//
        P2displaytemp = P2temperature!;
        P2displayheartRate = P2heartRate!;
        P2displayoximeter = P2oximeter!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final TestButtonREf = database.child("TestNow");
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text("HealthCare",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: (650),
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                    // fit: BoxFit.fill,
                    image: AssetImage("assets/icons/Car.png")),
              ),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                children: [
                  //Driver Screen
                  drivergrid(),
                  //Passenger1 Screen
                  passenger1grid(),
                  //Passenger2 Screen
                  passenger2grid()
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
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(width: 2, color: Color(0XFFC6372A)))),
                ),
              ),
            ))
          ],
        ));
  }

  void deactivate() {
    outputstream.cancel();
    super.deactivate();
  }
}
