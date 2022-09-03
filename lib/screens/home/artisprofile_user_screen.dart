import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/screens/auth/create_polling_screen.dart';
import 'package:anrear/screens/home/aristpolling_voting_screen.dart';
import 'package:anrear/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtisProfileUserScreen extends StatefulWidget {
  var artistdata;
  ArtisProfileUserScreen({Key? key, this.artistdata}) : super(key: key);

  @override
  State<ArtisProfileUserScreen> createState() => _ArtisProfileUserScreen();
}

class _ArtisProfileUserScreen extends State<ArtisProfileUserScreen> {
  late List like = widget.artistdata["fav"];
  @override
  Widget build(BuildContext context) {
    print(like.contains(globalUserid));
    print(widget.artistdata["fav"]);
    print(globalUserid);
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: GestureDetector(
                onTap: () {
                  // addfav(like, auth.currentUser!.uid, "users",
                  //     "${widget.artistdata["uid"]}");
                  UserType == ""
                      ? Get.to(ArtistVotingScreen())
                      : Get.to(CreatePollingScreen(
                          userModel: currentUserData,
                          firebaseUser: globalUserid,
                        ));
                },
                child: Container(
                    child: Image.asset(
                  'assets/slicing/polling.png',
                  color:
                      //  like.contains(auth.currentUser!.uid)
                      // ? Colors.black
                      // :
                      Colors.white,
                )),
              ),
            )
          ],
          centerTitle: true,
          title: Text(
            'Artist Profile',
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
                      Container(
                        width: res_width * 0.2,
                        height: res_width * 0.2,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: NetworkImage(
                                '${widget.artistdata["userImage"]}'),
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
                        height: res_height * 0.01,
                      ),
                      Text('${widget.artistdata["fullName"]}',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18)),
                      SizedBox(
                        height: res_height * 0.0075,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.grey,
                            size: 18,
                          ),
                          Text('California',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xff929292),
                                height: 1.5,
                              ))
                        ],
                      ),

                      // SizedBox(height: res_height * 0.0075),
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
                      //
                    ],
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  child: Text(
                    'Albums',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                // Container(
                //   width: res_width * 0.9,
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: [
                //         Column(
                //           children: [
                // ListView(
                //   children:
                // widget.artistdata["albums"].map((e) => Text(e)).toList(),
                // ),
                // ListView.builder(
                //   // scrollDirection: Axis.horizontal,
                //   shrinkWrap: true,
                //   itemCount: widget.artistdata["albums"].length,
                //   itemBuilder: (context, index) {
                //     return Container(
                //         width: res_width * 0.325,
                //         child: Image.asset('assets/slicing/poster2.png'));
                //   },
                // ),
                // Expanded(
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 15,
                //     itemBuilder: (BuildContext context, int index) => Card(
                //       child: Center(child: Text('Dummy Card Text')),
                //     ),
                //   ),
                // ),
                // Container(
                //     width: res_width * 0.325,
                //     child:

                //      Image.asset('assets/slicing/poster1.png')),
                //             Text(
                //               'Lorem Ipsum',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.normal,
                //                   fontSize: 16),
                //             )
                //           ],
                //         ),
                //         Column(
                //           children: [
                // Container(
                //     width: res_width * 0.325,
                //     child:
                //         Image.asset('assets/slicing/poster2.png')),
                //             Text(
                //               'Lorem Ipsum',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.normal,
                //                   fontSize: 16),
                //             )
                //           ],
                //         ),
                Column(
                  children: [
                    Container(
                        width: res_width * 0.325,
                        child: Image.asset('assets/slicing/poster3.png')),
                    Text(
                      'Lorem Ipsum',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    )
                  ],
                ),
                //         Column(
                //           children: [
                //             Container(
                //                 width: res_width * 0.325,
                //                 child:
                //                     Image.asset('assets/slicing/poster3.png')),
                //             Text(
                //               'Lorem Ipsum',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.normal,
                //                   fontSize: 16),
                //             )
                //           ],
                //         )
                //       ],
                //     ),
                //   ),
                // ),

                SizedBox(
                  height: res_height * 0.03,
                ),
                Container(
                  width: res_width * 0.9,
                  child: Text(
                    'Music Category',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: res_width * 0.35,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Loremsum',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: res_width * 0.35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Loremsum',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: res_width * 0.35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Loremsum',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.03,
                ),
                Container(
                  width: res_width * 0.9,
                  child: Text(
                    'Awards Winning',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                            width: res_width * 0.3,
                            child: Image.asset('assets/slicing/award.png')),
                        Container(
                            width: res_width * 0.3,
                            child: Image.asset('assets/slicing/award2.png')),
                        Container(
                            width: res_width * 0.3,
                            child: Image.asset('assets/slicing/award3.png')),
                        Container(
                            width: res_width * 0.3,
                            child: Image.asset('assets/slicing/award.png')),
                        Container(
                            width: res_width * 0.3,
                            child: Image.asset('assets/slicing/award2.png'))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.03,
                ),
                Container(
                  width: res_width * 0.9,
                  child: Text(
                    'Most Famous Music',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
