import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

class my_perfomance_polling extends StatelessWidget {
  var performancePolling;
  my_perfomance_polling({Key? key, required this.performancePolling})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double res_width = Get.width;
    double res_height = Get.height;
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
                // Container(
                //   width: res_width * 0.9,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.all(Radius.circular(10))),
                //   child: Column(
                //     children: [
                //       SizedBox(
                //         height: res_height * 0.015,
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           Get.to(my_perfomance_polling());
                //         },
                //         child: Container(
                //           width: res_width * 0.16,
                //           height: res_width * 0.16,
                //           decoration: BoxDecoration(
                //             color: const Color(0xff7c94b6),
                //             // image: DecorationImage(
                //             // image: NetworkImage(
                //             //     "${widget.artistdata["userImage"]}"),
                //             // fit: BoxFit.cover,
                //             // ),
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(50.0)),
                //             border: Border.all(
                //               color: Color(0xffc88225),
                //               width: 2.0,
                //             ),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: res_height * 0.01,
                //       ),
                //       // Text(widget.artistdata["fullName"] ?? 'John Doe',
                //       //     style: TextStyle(
                //       //         fontWeight: FontWeight.normal, fontSize: 18)),
                //       SizedBox(
                //         height: res_height * 0.01,
                //       ),
                //       Container(
                //         width: res_width * 0.6,
                //         child: Center(
                //           child: Text('',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 fontSize: 13,
                //                 color: Color(0xff929292),
                //                 height: 1.5,
                //               )),
                //         ),
                //       ),
                //       SizedBox(
                //         height: res_height * 0.01,
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           // Get.to(ArtisProfileUserScreen(
                //           //   artistdata: widget.artistdata,
                //           // ));
                //         },
                //         child: Text(
                //           'View Profile',
                //           style: TextStyle(
                //               decoration: TextDecoration.underline,
                //               color: kPrimaryColor,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 16),
                //         ),
                //       ),
                //       SizedBox(
                //         height: res_height * 0.015,
                //       ),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: res_height * 0.015,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: currentUserData.links.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: Get.width * 0.05),
                        child: Container(
                          width: res_width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      print("${currentUserData.links[index]}");
                                      var url = currentUserData.links[index];
                                      // if (await launchUrl(url)) {
                                      try {
                                        EasyLoading.show();

                                        await launchUrlString(
                                            url.toString().trim());
                                        EasyLoading.dismiss();
                                      } on PlatformException catch (e) {
                                        EasyLoading.dismiss();

                                        Get.snackbar("Could not launch $url",
                                            e.message.toString());
                                      }
                                    },
                                    child: Text(
                                      '${currentUserData.links[index]}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                SizedBox(
                  height: res_height * 0.03,
                ),
                Text(
                  "Location Of Performance",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                // SizedBox(
                //   height: res_height * 0.03,
                // ),
                // SizedBox(
                //   height: res_height * 0.03,
                // ),
                // Text(
                //   "Location Of Performance",
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.white,
                //     // fontWeight: FontWeight.bold
                //   ),
                // ),
                SizedBox(
                  height: res_height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Start Date",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${performancePolling["startDate"]}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "End Date",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${performancePolling["endDate"]}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: res_height * 0.03,
                ),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    votebox(
                        "${performancePolling["location"]["location1"]}",
                        performancePolling["location"]["like"].length,
                        context,
                        performancePolling["polling_location_im"]),
                    votebox(
                        "${performancePolling["location2"]["location2"]}",
                        performancePolling["location2"]["like"].length,
                        context,
                        performancePolling["polling_location_im2"]),
                    if (performancePolling["location3"]["location3"] != "false")
                      votebox(
                          "${performancePolling["location3"]["location3"]}",
                          performancePolling["location3"]["like"].length,
                          context,
                          performancePolling["polling_location_im3"]),
                    if (performancePolling["location4"]["location4"] != "false")
                      votebox(
                          "${performancePolling["location4"]["location4"]}",
                          performancePolling["location4"]["like"].length,
                          context,
                          performancePolling["polling_location_im4"])
                    // votebox(
                    //     widget.performancePolling["location"]["location1"]
                    //         .toString(),
                    //     "${widget.performancePolling["location"]["like"].length.toString()}",
                    //     () async {
                    //   // print(
                    //   // widget.performancePolling["location"]["like"].length);
                    //   if (widget.performancePolling["location2"]["like"]
                    //           .contains(globalUserid) ||
                    //       widget.performancePolling["location3"]["like"]
                    //           .contains(globalUserid) ||
                    //       widget.performancePolling["location4"]["like"]
                    //           .contains(globalUserid)) {
                    //     Get.snackbar("Already voted", "");
                    //   } else {
                    //     if (!widget.performancePolling["location"]["like"]
                    //         .contains(globalUserid)) {
                    //       await firestore_update(
                    //           'PerformancePolling',
                    //           widget.performancePolling["uid"],
                    //           ({
                    //             "location.like":
                    //                 FieldValue.arrayUnion([globalUserid])
                    //           }));
                    //       Get.back();
                    //     }
                    //   }
                    // }),
                    // votebox(
                    //     widget.performancePolling["location2"]["location2"]
                    //         .toString(),
                    //     "${widget.performancePolling["location2"]["like"].length.toString()}",
                    //     () async {
                    //   if (widget.performancePolling["location"]["like"]
                    //           .contains(globalUserid) ||
                    //       widget.performancePolling["location3"]["like"]
                    //           .contains(globalUserid) ||
                    //       widget.performancePolling["location4"]["like"]
                    //           .contains(globalUserid)) {
                    //     Get.snackbar("Already voted", "");
                    //   } else {
                    //     if (!widget.performancePolling["location2"]["like"]
                    //         .contains(globalUserid)) {
                    //       await firestore_update(
                    //           'PerformancePolling',
                    //           widget.performancePolling["uid"],
                    //           ({
                    //             "location2.like":
                    //                 FieldValue.arrayUnion([globalUserid])
                    //           }));
                    //       Get.back();
                    //     }
                    //   }
                    // }),
                    // votebox(
                    //     widget.performancePolling["location3"]["location3"]
                    //         .toString(),
                    //     "${widget.performancePolling["location3"]["like"].length.toString()}",
                    //     () async {
                    //   if (widget.performancePolling["location2"]["like"]
                    //           .contains(globalUserid) ||
                    //       widget.performancePolling["location"]["like"]
                    //           .contains(globalUserid) ||
                    //       widget.performancePolling["location4"]["like"]
                    //           .contains(globalUserid)) {
                    //     Get.snackbar("Already voted", "");
                    //   } else {
                    //     if (!widget.performancePolling["location3"]["like"]
                    //         .contains(globalUserid)) {
                    //       await firestore_update(
                    //           'PerformancePolling',
                    //           widget.performancePolling["uid"],
                    //           ({
                    //             "location3.like":
                    //                 FieldValue.arrayUnion([globalUserid])
                    //           }));
                    //       Get.back();
                    //     }
                    //   }
                    // }),
                    // votebox(
                    //     widget.performancePolling["location4"]["location4"]
                    //         .toString(),
                    //     "${widget.performancePolling["location4"]["like"].length.toString()}",
                    //     () async {
                    //   if (widget.performancePolling["location2"]["like"]
                    //           .contains(globalUserid) ||
                    //       widget.performancePolling["location"]["like"]
                    //           .contains(globalUserid) ||
                    //       widget.performancePolling["location3"]["like"]
                    //           .contains(globalUserid)) {
                    //     Get.snackbar("Already voted", "");
                    //   } else {
                    //     if (!widget.performancePolling["location4"]["like"]
                    //         .contains(globalUserid)) {
                    //       await firestore_update(
                    //           'PerformancePolling',
                    //           widget.performancePolling["uid"],
                    //           ({
                    //             "location3.like":
                    //                 FieldValue.arrayUnion([globalUserid])
                    //           }));
                    //       Get.back();
                    //     }
                    //   }
                    // }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  votebox(location1, votes, context, List imageURL) {
    double res_width = Get.width;
    double res_height = Get.height;
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
              // Row(
              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   // crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text('${location1}',
              //         style: new TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black,
              //             fontSize: 17.0)),
              //     // Spacer(),
              //     SizedBox(
              //       width: Get.width * 0.09,
              //     ),
              //     GestureDetector(
              //       onTap: likeOnTap,
              //       child: Container(
              //           width: res_width * 0.075,
              //           child: Image.asset('assets/slicing/thumbsup.png')),
              //     )
              //   ],
              // ),
              Text('${location1}',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17.0)),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff150a35),
                    borderRadius: BorderRadius.circular(100)),
                child: CircularPercentIndicator(
                  radius: 45,
                  lineWidth: 5.0,
                  animation: true,
                  percent: double.parse("$votes") / 1000,
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
              10.heightBox,
              GestureDetector(
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (_) {
                        return imageDialog('My Image', imageURL, context);
                      });
                },
                child: Text(
                  "View Images",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Vx.black,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
              ),
              5.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}

Widget imageDialog(text, List path, context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
    ),
    child: Dialog(
      // backgroundColor: Colors.transparent,
      // elevation: 0,
      insetPadding: EdgeInsets.all(10),

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        width: Get.width * 0.9,
        height: 300,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: path.length,
            itemBuilder: (context, index) {
              // pat.length
              // print(l);
              // List l = path;
              // print(l);
              print(path[index]);

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                width: Get.width * 0.9,
                height: 300,
                child: Image.network(
                  // '${path[index]}',
                  path[index] ??
                      "https://firebasestorage.googleapis.com/v0/b/anrear-8e2f6.appspot.com/o/products%2Fproduct_39601.png?alt=media&token=0d8b7db4-8e00-487f-893a-96a17b8157bb",
                  fit: BoxFit.cover,
                ),
              );
            }),
      ),
    ),
  );
}
