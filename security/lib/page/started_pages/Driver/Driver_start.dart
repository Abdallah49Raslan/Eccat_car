import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DriverStartPage extends StatefulWidget {
  const DriverStartPage({super.key});

  @override
  State<DriverStartPage> createState() => _DriverStartPageState();
}

class _DriverStartPageState extends State<DriverStartPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 370,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Container(
                  margin: EdgeInsets.only(top: 60),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        //fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://ezgo.txtsv.com/sites/default/files/styles/compress/public/_images/vehicle-thumbnails/EZGO_L6_Builder_v10_WHITE_0.png?itok=9rWD1cpk')),
                  ),
                ),
              ),
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          top: 10, start: 20, bottom: 20),
                      //width: double.infinity,

                      child: Text(
                        'specifications',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                      height: 170,
                      width: 170,
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              // margin: EdgeInsets.only(top: 20),
                              width: 50,
                              // height: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.seekpng.com/png/full/14-144347_location-png-white-vector-free-library-location-icon.png'))),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: Container(
                            child: Text(
                              'current location',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(20, 20, 0, 10),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('iot');
                      },
                      child: Container(
                        height: 170,
                        width: 170,
                        margin: EdgeInsets.only(left: 20, top: 30),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                //  margin: EdgeInsets.only(top: 20),
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://www.citypng.com/public/uploads/preview/supercar-sport-car-white-icon-hd-png-11637225474lauqmiukew.png'))),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                                child: Container(
                              //margin: EdgeInsets.only(top: 20),
                              child: Text(
                                'car status',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ]),
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 10),
                    ),
                    Container(
                      height: 170,
                      width: 170,
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              // margin: EdgeInsets.only(top: 20),
                              width: 50,
                              // height: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.seekpng.com/png/full/14-144347_location-png-white-vector-free-library-location-icon.png'))),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: Container(
                            child: Text(
                              'current location',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 10),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('darkmode');
                      },
                      child: Container(
                        height: 170,
                        width: 170,
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                // margin: EdgeInsets.only(top: 20),
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://www.nashvillecares.org/wp-content/uploads/2021/11/ICON-HEART.png'))),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                                child: Container(
                              child: Text(
                                'driver health',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
