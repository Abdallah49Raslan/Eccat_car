import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Authintication/login_page.dart';
import '../Health Care/darkmode.dart';
import '../Iot/mainpage.dart';
import '../User_Profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Desert extends StatefulWidget {
  const Desert({super.key});

  @override
  State<Desert> createState() => _DesertState();
}

class _DesertState extends State<Desert> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        //toolbarHeight: 80,
        elevation: 0,
      ),
      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          unselectedLabelStyle: TextStyle(color: Colors.white),
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.green,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.location_city,
                ),
                label: 'city'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'persons'),
            BottomNavigationBarItem(
                icon: Icon(Icons.heart_broken), label: 'home')
          ]),
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
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      //fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Mitsubishi_logo.svg/2381px-Mitsubishi_logo.svg.png'))),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.only(top: 20, left: 20),
                              width: 50,
                              height: 55,
                              color: Colors.black87,
                              child: Text(
                                'golf car model 2022',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
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
