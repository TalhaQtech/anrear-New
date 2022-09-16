import 'dart:math';

import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/screens/home/artisprofile_user_screen.dart';
import 'package:anrear/screens/home/artistpolling_screen.dart';
import 'package:anrear/screens/home/confirmed_location.dart';
import 'package:anrear/screens/home/drawer.dart';
import 'package:anrear/screens/home/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final selectionctrl = Get.put(SelectionController());
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/slicing/Bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        key: _key,
        drawer: NavDrawer(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _key.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child:
                  Container(child: Image.asset('assets/slicing/hamburger.png')),
            ),
          ),
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                    child: Image.asset('assets/slicing/notfication.png')),
              ),
            )
          ],
          centerTitle: true,
          title: Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  child: Text(
                    'Latest Artist',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  height: res_height * 0.16,
                  width: res_width * 0.94,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("artist")
                        .orderBy("time", descending: true)
                        // .where("uid",
                        //     isNotEqualTo: globalUserid,)
                        // .where("uid",
                        //     isNotEqualTo: globalUserid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      print(snapshot.hasData);
                      if (snapshot.hasError) {
                        return Center(child: CircularProgressIndicator());
                        // Handle errors
                      } else if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                        // Handle no data
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];
                            print(snapshot.data!.docs[index]["fullName"]);

                            if (data["uid"] != globalUserid)
                              return Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: latestArtist(
                                  res_width,
                                  "${data["fullName"]}",
                                  '${data["description"]}',
                                  '${data["userImage"]}',
                                ),
                              );
                            // ArtistBox(
                            //     '${data["fullName"]}',
                            //     '${data["userImage"]}',
                            //     '${data["description"]}',
                            //     data);
                            return Container();
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                    width: res_width * 0.9,
                    child: GetBuilder<SelectionController>(
                      builder: (_) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                selectionctrl.changeValue(0);
                              },
                              child: Container(
                                width: res_width * 0.4,
                                decoration: BoxDecoration(
                                    color: selectionctrl.selectionValue == 0
                                        ? bottomFabColor
                                        : Color(0xfffbbcb3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Text(
                                      'Artist List',
                                      style: TextStyle(
                                          color: selectionctrl.selectionValue ==
                                                  0
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: res_width * 0.02,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                selectionctrl.changeValue(1);
                              },
                              child: Container(
                                width: res_width * 0.4,
                                decoration: BoxDecoration(
                                    color: selectionctrl.selectionValue == 1
                                        ? bottomFabColor
                                        : Color(0xfffbbcb3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Text(
                                      'Polling',
                                      style: TextStyle(
                                          color: selectionctrl.selectionValue ==
                                                  1
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: res_width * 0.02,
                            ),

                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                selectionctrl.changeValue(2);
                              },
                              child: Container(
                                width: res_width * 0.51,
                                decoration: BoxDecoration(
                                    color: selectionctrl.selectionValue == 2
                                        ? bottomFabColor
                                        : Color(0xfffbbcb3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Text(
                                      'Confirm Location',
                                      style: TextStyle(
                                          color: selectionctrl.selectionValue ==
                                                  2
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // fcd6cf
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: res_height * 0.015,
                ),
                GetBuilder<SelectionController>(
                    builder: (_) => Column(
                          children: [
                            selectionctrl.selectionValue == 0
                                ? StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("artist")
                                        .orderBy("time", descending: true)
                                        // .where("uid",
                                        //     isNotEqualTo: globalUserid,)
                                        // .where("uid",
                                        //     isNotEqualTo: globalUserid)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      print(snapshot.hasData);
                                      if (snapshot.hasError) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                        // Handle errors
                                      } else if (!snapshot.hasData) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                        // Handle no data
                                      }
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                          physics: ScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            var data =
                                                snapshot.data!.docs[index];
                                            print(snapshot.data!.docs[index]
                                                ["fullName"]);

                                            if (data["uid"] != globalUserid)
                                              return ArtistBox(
                                                  '${data["fullName"]}',
                                                  '${data["userImage"]}',
                                                  '${data["description"]}',
                                                  data);
                                            return Container();
                                          },
                                        );
                                      }
                                      return Center(
                                          child: CircularProgressIndicator());
                                    },
                                  )

                                // Column(
                                //     children: [
                                //       ArtistBox(
                                //           'John Doe',
                                //           'assets/slicing/girl.jpeg',
                                //           'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                                //       ArtistBox(
                                //           'Andy Marshal',
                                //           'assets/slicing/girl.jpeg',
                                //           'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                                //       ArtistBox(
                                //           'Sarah Smith',
                                //           'assets/slicing/girl.jpeg',
                                //           'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                                //     ],
                                //   )

                                : selectionctrl.selectionValue == 1
                                    ? StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("PerformancePolling")
                                            // .where("uid",
                                            //     isNotEqualTo: globalUserid)
                                            .orderBy("time", descending: true)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          print(snapshot.hasData);
                                          if (snapshot.hasError) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                            // Handle errors
                                          } else if (!snapshot.hasData) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                            // Handle no data
                                          }

                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }

                                                var data =
                                                    snapshot.data!.docs[index];

                                                return PollingBox(
                                                    '${data["fullName"]}',
                                                    '${data["userImage"]}',
                                                    '${data["description"]}',
                                                    '${data["startDate"]}',
                                                    '${data["endDate"]}',
                                                    data);
                                                //  ArtistBox(
                                                //     '${data["fullName"]}',
                                                //     '${data["userImage"]}',
                                                //     '${data["description"]}',
                                                //     data);
                                              },
                                            );
                                          }
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      )

                                    //  Column(
                                    //     children: [
                                    // PollingBox(
                                    //     'John Doe',
                                    //     'assets/slicing/girl.jpeg',
                                    //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
                                    //     '2/2/2022',
                                    //     '2/2/2022'),
                                    //       PollingBox(
                                    //           'John Doe',
                                    //           'assets/slicing/girl.jpeg',
                                    //           'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
                                    //           '2/2/2022',
                                    //           '2/2/2022'),
                                    //     ],
                                    //   )
                                    : selectionctrl.selectionValue == 2
                                        ? StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection(
                                                    "PerformancePolling")
                                                .where("endDate",
                                                    isLessThan: "$date")
                                                // .orderBy("time",
                                                //     descending: true)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              DateTime.now();
                                              print(date);
                                              print(snapshot.hasData);
                                              if (snapshot.hasError) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                                // Handle errors
                                              }
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }

                                              if (snapshot.hasData) {
                                                return ListView.builder(
                                                  physics: ScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var data = snapshot
                                                        .data!.docs[index];
                                                    var loc1 = snapshot
                                                            .data!.docs[index]
                                                        ["location"]["like"];
                                                    var loc2 = snapshot
                                                            .data!.docs[index]
                                                        ["location2"]["like"];
                                                    var loc3 = snapshot
                                                            .data!.docs[index]
                                                        ["location3"]["like"];
                                                    var loc4 = snapshot
                                                            .data!.docs[index]
                                                        ["location4"]["like"];
                                                    // List list = []; //
                                                    // list.addAll([
                                                    //   loc1,
                                                    //   loc4,
                                                    //   loc2,
                                                    //   loc3
                                                    // ]);
                                                    int a = max(loc1.length,
                                                        loc2.length);
                                                    int b = max(loc3.length,
                                                        loc4.length);
                                                    int c = max(a, b);
                                                    // print(c);
                                                    if (c == loc1.length) {
                                                      print("obj 1");
                                                      print(loc1);
                                                      return ConfirmLocationBox(
                                                          '${data["fullName"]}',
                                                          '${data["userImage"]}',
                                                          '${data["description"]}',
                                                          '${snapshot.data!.docs[index]["location"]["location1"]}');
                                                    }
                                                    if (c == loc2.length) {
                                                      print("obj 2");
                                                      print(loc2);
                                                      return ConfirmLocationBox(
                                                          '${data["fullName"]}',
                                                          '${data["userImage"]}',
                                                          '${data["description"]}',
                                                          '${snapshot.data!.docs[index]["location2"]["location2"]}');
                                                    }
                                                    if (c == loc3.length) {
                                                      print("obj 3");
                                                      print(loc3);
                                                      return ConfirmLocationBox(
                                                          '${data["fullName"]}',
                                                          '${data["userImage"]}',
                                                          '${data["description"]}',
                                                          '${snapshot.data!.docs[index]["location3"]["location3"]}');
                                                    }
                                                    if (c == loc4.length) {
                                                      print("obj 4");
                                                      print(loc4);
                                                      return ConfirmLocationBox(
                                                          '${data["fullName"]}',
                                                          '${data["userImage"]}',
                                                          '${data["description"]}',
                                                          '${snapshot.data!.docs[index]["location4"]["location4"]}');
                                                    }

                                                    //  List should not be empty.
                                                    // print(list.reduce(
                                                    //     (curr, next) =>
                                                    //         curr > next
                                                    //             ? curr
                                                    //             : next));

                                                    // var confirm_location = list
                                                    //     .reduce((curr, next) =>
                                                    //         curr > next
                                                    //             ? curr
                                                    //             : next);
                                                    // print(confirm_location ==
                                                    //     snapshot.data!
                                                    //                 .docs[index]
                                                    //             ["location4"]
                                                    //         ["like"]);
                                                    // alllocation.reduce(
                                                    //     (value, element) {
                                                    //   print(value);
                                                    //   print(element.max);
                                                    // });

                                                    // print(snapshot
                                                    //     .data!
                                                    //     .docs[index]["location"]
                                                    //         ["like"]
                                                    //     .length);

                                                    return Container();
                                                    //  PollingBox(
                                                    //     '${data["fullName"]}',
                                                    //     '${data["userImage"]}',
                                                    //     '${data["description"]}',
                                                    //     '${data["startDate"]}',
                                                    //     '${data["endDate"]}',
                                                    //     data)
                                                    ;
                                                    //  ArtistBox(
                                                    //     '${data["fullName"]}',
                                                    //     '${data["userImage"]}',
                                                    //     '${data["description"]}',
                                                    //     data);
                                                  },
                                                );
                                              }
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                          )

                                        //  Column(
                                        //     children: [
                                        // ConfirmLocationBox(
                                        //     'John Doe',
                                        //     'assets/slicing/girl.jpeg',
                                        //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
                                        //     'Confirm'),
                                        //     ],
                                        //   )
                                        : Container(),
                          ],
                        )),
                SizedBox(
                  height: res_height * 0.135,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container latestArtist(double res_width, name, des, img) {
    return Container(
      width: res_width * 0.7,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 23, bottom: 23, left: 10, right: 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                    width: res_width * 0.45,
                    child: Text('$des',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xff929292),
                          height: 1.5,
                        )))
              ],
            ),
            Container(
              width: res_width * 0.18,
              height: res_width * 0.18,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: NetworkImage(
                      '${img ?? "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"}'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: Color(0xffc88225),
                  width: 2.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PollingBox(name, image, description, start, end, artist) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.025,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // Get.to(() => ArtistPollingScreen(
          //       data: artist,
          //     ));
        },
        child: Container(
          width: res_width * 0.94,
          // decoration: BoxDecoration(
          //     color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: res_width * 0.1675,
                    height: res_width * 0.1675,
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: Color(0xffc88225),
                        width: 2.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: res_width * 0.0235,
                  ),

                  // Container(
                  //     width: res_width * 0.225,
                  //     child: Center(child: Image.asset(image))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: res_height * 0.00075,
                      ),
                      Container(
                          width: res_width * 0.6,
                          child: Text(description,
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xff929292),
                                height: 1.5,
                              ))),
                      SizedBox(
                        height: res_height * 0.00075,
                      ),
                      Row(
                        children: [
                          Text('Start: ${start}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xff929292),
                                height: 1.5,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text('End: ${end}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xff929292),
                                height: 1.5,
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ConfirmLocationBox(name, image, description, status) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.to(() => ConfirmLocationScreen());
      },
      child: Container(
        width: res_width * 0.94,
        // decoration: BoxDecoration(
        //     color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: res_width * 0.1675,
                  height: res_width * 0.1675,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Color(0xffc88225),
                      width: 2.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: res_width * 0.0235,
                ),

                // Container(
                //     width: res_width * 0.225,
                //     child: Center(child: Image.asset(image))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: res_height * 0.00075,
                    ),
                    Container(
                      width: res_width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Performance Name',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                height: 1.5,
                              )),
                          // Spacer(),
                          Row(
                            children: [
                              Text('$status: ',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    height: 1.5,
                                  )),
                              Text('Confirm ',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.green,
                                    height: 1.5,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: res_height * 0.00075,
                    ),
                    Container(
                        width: res_width * 0.6,
                        child: Text(description,
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xff929292),
                              height: 1.5,
                            ))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ArtistBox(name, image, description, artist) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.025,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Get.to(() => ArtisProfileUserScreen(artistdata: artist));
        },
        child: Container(
          width: res_width * 0.94,
          // decoration: BoxDecoration(
          //     color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: res_width * 0.1675,
                    height: res_width * 0.1675,
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: DecorationImage(
                        image: NetworkImage(
                          image,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: Color(0xffc88225),
                        width: 2.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: res_width * 0.0235,
                  ),

                  // Container(
                  //     width: res_width * 0.225,
                  //     child: Center(child: Image.asset(image))),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: res_height * 0.00075,
                      ),
                      Container(
                          width: res_width * 0.6,
                          child: Text(description,
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xff929292),
                                height: 1.5,
                              )))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectionController extends GetxController {
  var selectionValue = 0;

  void changeValue(value) {
    selectionValue = value;
    update();
  }
}
