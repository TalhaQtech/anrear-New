import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmLocationScreen extends StatefulWidget {
  const ConfirmLocationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreen();
}

class _ConfirmLocationScreen extends State<ConfirmLocationScreen> {
  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/slicing/Bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.all(13.0),
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios)),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.all(13.0),
          //     child: Container(
          //         child: Image.asset('assets/slicing/notfication.png')),
          //   )
          // ],
          centerTitle: true,

          title: Text(
            'Confirmed Locations',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("PerformancePolling")
                      .where("endDate", isLessThan: "2022-09-22")
                      // .orderBy("time",
                      //     descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    DateTime.now();
                    // print(date);
                    print(snapshot.hasData);
                    if (snapshot.hasError) {
                      return Center(child: CircularProgressIndicator());
                      // Handle errors
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          var loc1 =
                              snapshot.data!.docs[index]["location"]["like"];
                          var loc2 =
                              snapshot.data!.docs[index]["location2"]["like"];
                          var loc3 =
                              snapshot.data!.docs[index]["location3"]["like"];
                          var loc4 =
                              snapshot.data!.docs[index]["location4"]["like"];
                          // List list = []; //
                          // list.addAll([
                          //   loc1,
                          //   loc4,
                          //   loc2,
                          //   loc3
                          // ]);
                          int a = max(loc1.length, loc2.length);
                          int b = max(loc3.length, loc4.length);
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
                          // ConfirmLocationBox(
                          //         '${data["fullName"]}',
                          //         '${data["userImage"]}',
                          //         '${data["description"]}',
                          //         'Confirm')

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
                    return Center(child: CircularProgressIndicator());
                  },
                )

                // ConfirmLocationBox(
                //     'John Doe',
                //     'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
                //     'Confirm'),
                // ConfirmLocationBox(
                //     'John Doe',
                //     'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
                //     'Confirm'),
                ,
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

  ConfirmLocationBox(name, image, description, status) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return Container(
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
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
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
    );
  }
}
