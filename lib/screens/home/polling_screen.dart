import 'package:anrear/helper/helper.dart';
import 'package:anrear/screens/auth/create_polling_screen.dart';
import 'package:anrear/screens/home/aristpolling_voting_screen.dart';
import 'package:anrear/screens/home/artistpolling_screen.dart';
import 'package:anrear/screens/home/drawer.dart';
import 'package:anrear/screens/home/notification.dart';
import 'package:anrear/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class PollingsScreen extends StatefulWidget {
  const PollingsScreen({Key? key}) : super(key: key);

  @override
  State<PollingsScreen> createState() => _PollingsScreen();
}

class _PollingsScreen extends State<PollingsScreen> {
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
        backgroundColor: Colors.transparent,
        key: _key,
        drawer: NavDrawer(),
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
            'Pollings',
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
                      // .where("uid",
                      //     isNotEqualTo: globalUserid)
                      .orderBy("time", descending: true)
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
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          var data = snapshot.data!.docs[index];

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
                    return Center(child: CircularProgressIndicator());
                  },
                )

                // ArtistBox('John Doe', 'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                // ArtistBox('Andy Marshal', 'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                // ArtistBox('Sarah Smith', 'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                // ArtistBox('John Doe', 'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                // ArtistBox('John Doe', 'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                // ArtistBox('Andy Marshal', 'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                // ArtistBox('Sarah Smith', 'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                // ArtistBox(
                //     'John Doe',
                //     'assets/slicing/girl.jpeg',
                //     'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
                //     ),
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

  PollingBox(name, image, description, start, end, artist) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.025,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        // onTap: () {
        //   // Get.to(() => ArtistPollingScreen(
        //   //       data: artist,
        //   //     ));

        // },

        onTap: () async {
          // addfav(like, auth.currentUser!.uid, "users",
          //     "${widget.artistdata["uid"]}");

          if (UserType == "user") {
            try {
              var data = await FirebaseFirestore.instance
                  .collection("PerformancePolling")
                  .doc("${artist["uid"]}")
                  .get();
              var Perform = data.data();
              print(" ${Perform}");
              if (Perform != null) {
                if (DateTime.parse(data["endDate"]).day > DateTime.now().day) {
                  Get.to(() => ArtistVotingScreen(
                      performancePolling: Perform, artistdata: artist));
                } else {
                  Get.snackbar("This Artist is closed pollings ", "");
                }
              } else {
                Get.snackbar("This Artist is not create pollings ", "");
              }
            } on FirebaseException catch (e) {
              Get.snackbar("Error", e.message.toString());
            }
            // Get.to(ArtistPollingScreen(
            //   data: widget.artistdata,
            // ));
          }
          if (UserType == "artist") {
            EasyLoading.show();
            var data = await firestore_get("PerformancePolling", globalUserid);
            var Perform = data.data();
            EasyLoading.dismiss();
            print(Perform);
            // print(DateTime.parse(data["endDate"]).day);
            if (Perform != null) {
              if (DateTime.parse(data["endDate"]).day > DateTime.now().day) {
                Get.snackbar("You have Already created pollings", "");
              } else {
                Get.to(CreatePollingScreen(
                  userModel: currentUserData,
                  // firebaseUser: globalUserid,
                ));
              }
            } else {
              Get.to(CreatePollingScreen(
                userModel: currentUserData,
              ));
            }
            // Get.to(CreatePollingScreen(
            //   userModel: currentUserData,
            // ));
          }
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
}
