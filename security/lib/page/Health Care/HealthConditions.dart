import 'dart:async';
import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:security/core/globalvariables.dart';
import 'package:security/core/colors.dart';
import 'package:security/page/Health Care/darkmode.dart';

Widget DTemperatureCondition() {
  if (Ddisplaytemp == null || Ddisplaytemp == 0) {
    return Text(".........",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  } else if (36 <= Ddisplaytemp! && Ddisplaytemp! <= 37.2) {
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

Widget P1TemperatureCondition() {
  if (P1displaytemp == null || P1displaytemp! == 0) {
    return Text(".........",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  } else if (36 <= P1displaytemp! && P1displaytemp! <= 37.2) {
    P1temp = "Normal";
    return Text('$P1temp',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ));
  } else {
    P1temp = "Abnormal";
    return Text('$P1temp',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0XFFC6372A),
        ));
  }
}

Widget P2TemperatureCondition() {
  if (P2displaytemp == null || P2displaytemp == 0) {
    return Text(".........",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  } else if (36 <= P2displaytemp! && P2displaytemp! <= 37.2) {
    P2temp = "Normal";
    return Text('$P2temp',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ));
  } else {
    P2temp = "Abnormal";
    return Text('$P2temp',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0XFFC6372A),
        ));
  }
}

Widget DHeartRateCondition() {
  if (DdisplayheartRat == null || DdisplayheartRat == 0) {
    return Text(".........",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  } else if (60 <= DdisplayheartRat! && DdisplayheartRat! <= 100) {
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

Widget P1HeartRateCondition() {
  if (P1displayheartRate == null || P1displayheartRate == 0) {
    return Text(".........",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  } else if (60 <= P1displayheartRate! && P1displayheartRate! <= 100) {
    P1heart = " Normal";
    return Text('$P1heart',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ));
  } else {
    P1heart = "Abnormal";
    return Text('$P1heart',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0XFFC6372A),
        ));
  }
}

Widget P2HeartRateCondition() {
  if (P2displayheartRate == null || P2displayheartRate == 0) {
    return Text(".........",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  } else if (60 <= P2displayheartRate! && P2displayheartRate! <= 100) {
    P2heart = " Normal";
    return Text('$P2heart',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ));
  } else {
    P2heart = "Abnormal";
    return Text('$P2heart',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0XFFC6372A),
        ));
  }
}

Widget DOximeterCondition() {
  if (Ddisplayoximeter == null || Ddisplayoximeter == 0) {
    return Text(".........",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  } else if (90 <= Ddisplayoximeter! && Ddisplayoximeter! <= 100) {
    Driveroxi = "Normal";
    return Text('$Driveroxi',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ));
  } else {
    Driveroxi = "Abnormal";
    return Text('$Driveroxi',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0XFFC6372A),
        ));
  }
}

Widget P1OximeterCondition() {
  if (P1displayoximeter == null || P1displayoximeter == 0) {
    return Text(".........",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  } else if (90 <= P1displayoximeter! && P1displayoximeter! <= 100) {
    P1oxi = "Normal";
    return Text('$P1oxi',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ));
  } else {
    P1oxi = "Abnormal";
    return Text('$P1oxi',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0XFFC6372A),
        ));
  }
}

Widget P2OximeterCondition() {
  if (P2displayoximeter == null || P2displayoximeter == 0) {
    return Text(".........",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  } else if (90 <= P2displayoximeter! && P2displayoximeter! <= 100) {
    P2oxi = "Normal";
    return Text('$P2oxi',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ));
  } else {
    P2oxi = "Abnormal";
    return Text('$P2oxi',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0XFFC6372A),
        ));
  }
}
