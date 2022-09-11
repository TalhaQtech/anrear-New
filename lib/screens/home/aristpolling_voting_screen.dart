import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/screens/home/artisprofile_user_screen.dart';
import 'package:anrear/screens/home/my_performance_polling.dart';
import 'package:anrear/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ArtistVotingScreen extends StatefulWidget {
  var performancePolling;
  var artistdata;
  ArtistVotingScreen(
      {Key? key, required this.performancePolling, required this.artistdata})
      : super(key: key);

  @override
  State<ArtistVotingScreen> createState() => _ArtistVotingScreen();
}

class _ArtistVotingScreen extends State<ArtistVotingScreen> {
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
          leading: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Artist Polling',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: res_width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: res_height * 0.015,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Get.to(my_perfomance_polling());
                        },
                        child: Container(
                          width: res_width * 0.16,
                          height: res_width * 0.16,
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${widget.artistdata["userImage"]}"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                              color: Color(0xffc88225),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: res_height * 0.01,
                      ),
                      Text(widget.artistdata["fullName"] ?? 'John Doe',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18)),
                      SizedBox(
                        height: res_height * 0.01,
                      ),
                      Container(
                        width: res_width * 0.6,
                        child: Center(
                          child: Text('${widget.artistdata["description"]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff929292),
                                height: 1.5,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: res_height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(ArtisProfileUserScreen(
                            artistdata: widget.artistdata,
                          ));
                        },
                        child: Text(
                          'View Profile',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: res_height * 0.015,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.facebook_outlined,
                          color: kPrimaryColor,
                          size: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: res_height * 0.04,
                          width: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'https://www.facebook.com',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.03,
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    votebox(
                        widget.performancePolling["location"]["location1"]
                            .toString(),
                        "${widget.performancePolling["location"]["like"].length.toString()}",
                        () async {
                      // print(
                      // widget.performancePolling["location"]["like"].length);
                      if (widget.performancePolling["location2"]["like"]
                              .contains(globalUserid) ||
                          widget.performancePolling["location3"]["like"]
                              .contains(globalUserid) ||
                          widget.performancePolling["location4"]["like"]
                              .contains(globalUserid)) {
                        Get.snackbar("Already voted", "");
                      } else {
                        if (!widget.performancePolling["location"]["like"]
                            .contains(globalUserid)) {
                          await firestore_update(
                              'PerformancePolling',
                              widget.performancePolling["uid"],
                              ({
                                "location.like":
                                    FieldValue.arrayUnion([globalUserid])
                              }));
                          Get.back();
                        }
                      }
                    }),
                    votebox(
                        widget.performancePolling["location2"]["location2"]
                            .toString(),
                        "${widget.performancePolling["location2"]["like"].length.toString()}",
                        () async {
                      if (widget.performancePolling["location"]["like"]
                              .contains(globalUserid) ||
                          widget.performancePolling["location3"]["like"]
                              .contains(globalUserid) ||
                          widget.performancePolling["location4"]["like"]
                              .contains(globalUserid)) {
                        Get.snackbar("Already voted", "");
                      } else {
                        if (!widget.performancePolling["location2"]["like"]
                            .contains(globalUserid)) {
                          await firestore_update(
                              'PerformancePolling',
                              widget.performancePolling["uid"],
                              ({
                                "location2.like":
                                    FieldValue.arrayUnion([globalUserid])
                              }));
                          Get.back();
                        }
                      }
                    }),
                    votebox(
                        widget.performancePolling["location3"]["location3"]
                            .toString(),
                        "${widget.performancePolling["location3"]["like"].length.toString()}",
                        () async {
                      if (widget.performancePolling["location2"]["like"]
                              .contains(globalUserid) ||
                          widget.performancePolling["location"]["like"]
                              .contains(globalUserid) ||
                          widget.performancePolling["location4"]["like"]
                              .contains(globalUserid)) {
                        Get.snackbar("Already voted", "");
                      } else {
                        if (!widget.performancePolling["location3"]["like"]
                            .contains(globalUserid)) {
                          await firestore_update(
                              'PerformancePolling',
                              widget.performancePolling["uid"],
                              ({
                                "location3.like":
                                    FieldValue.arrayUnion([globalUserid])
                              }));
                          Get.back();
                        }
                      }
                    }),
                    votebox(
                        widget.performancePolling["location4"]["location4"]
                            .toString(),
                        "${widget.performancePolling["location4"]["like"].length.toString()}",
                        () async {
                      if (widget.performancePolling["location2"]["like"]
                              .contains(globalUserid) ||
                          widget.performancePolling["location"]["like"]
                              .contains(globalUserid) ||
                          widget.performancePolling["location3"]["like"]
                              .contains(globalUserid)) {
                        Get.snackbar("Already voted", "");
                      } else {
                        if (!widget.performancePolling["location4"]["like"]
                            .contains(globalUserid)) {
                          await firestore_update(
                              'PerformancePolling',
                              widget.performancePolling["uid"],
                              ({
                                "location3.like":
                                    FieldValue.arrayUnion([globalUserid])
                              }));
                          Get.back();
                        }
                      }
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  votebox(location1, votes, likeOnTap) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return Container(
      width: res_width * 0.425,
      height: res_height * 0.2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${location1}',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 17.0)),
                  // Spacer(),
                  SizedBox(
                    width: Get.width * 0.09,
                  ),
                  GestureDetector(
                    onTap: likeOnTap,
                    child: Container(
                        width: res_width * 0.075,
                        child: Image.asset('assets/slicing/thumbsup.png')),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff150a35),
                    borderRadius: BorderRadius.circular(100)),
                child: CircularPercentIndicator(
                  radius: 45,
                  lineWidth: 5.0,
                  animation: true,
                  percent: 0.2,
                  center: new Text(
                    "${votes} Votes",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 13.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Color(0xffaa6b80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
