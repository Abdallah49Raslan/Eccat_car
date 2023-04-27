import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:security/page/Iot/mainpage.dart';

import '../../Health Care/darkmode.dart';

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
                            decoration: const BoxDecoration(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //car icon in above of page
              Container(
                width: double.infinity,
                height: 370,
                decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://ezgo.txtsv.com/sites/default/files/styles/compress/public/_images/vehicle-thumbnails/EZGO_L6_Builder_v10_WHITE_0.png?itok=9rWD1cpk')),
                  ),
                ),
              ),

              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          top: 10, start: 20, bottom: 20),
                      //width: double.infinity,

                      child: const Text(
                        'specifications',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                      ),
                    ),

                    //location
                    Container(
                      height: 170,
                      width: 170,
                      margin: const EdgeInsets.only(left: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              width: 50,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.seekpng.com/png/full/14-144347_location-png-white-vector-free-library-location-icon.png'))),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: Container(
                            child: const Text(
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
                const SizedBox(
                  height: 30,
                ),

                //car status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 10),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const IoTPage()));
                      },
                      child: Container(
                        height: 170,
                        width: 170,
                        margin: const EdgeInsets.only(left: 20, top: 30),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://www.citypng.com/public/uploads/preview/supercar-sport-car-white-icon-hd-png-11637225474lauqmiukew.png'))),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                                child: Container(
                              //margin: EdgeInsets.only(top: 20),
                              child: const Text(
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
                      margin:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 10),
                    ),

                    //AI
                    Container(
                      height: 170,
                      width: 170,
                      margin: const EdgeInsets.only(left: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              // margin: EdgeInsets.only(top: 20),
                              width: 50,
                              // height: 50,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.seekpng.com/png/full/14-144347_location-png-white-vector-free-library-location-icon.png'))),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: Container(
                            child: const Text(
                              'AI ',
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

                //driver health
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 20,),
                    Container(
                      margin:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 10),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const HealthCareDriver()));
                      },
                      child: Container(
                        height: 170,
                        width: 170,
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://www.nashvillecares.org/wp-content/uploads/2021/11/ICON-HEART.png'))),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                                child: Container(
                              child: const Text(
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
