import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/screens/home/drawer.dart';
import 'package:anrear/screens/home/edit_artist_profile.dart';
import 'package:anrear/screens/home/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ArtistProfileScreen extends StatefulWidget {
  const ArtistProfileScreen({Key? key}) : super(key: key);

  @override
  State<ArtistProfileScreen> createState() => _ArtistProfileScreen();
}

class _ArtistProfileScreen extends State<ArtistProfileScreen> {
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
              padding: const EdgeInsets.all(16.0),
              child:
                  Container(child: Image.asset('assets/slicing/hamburger.png')),
            ),
          ),
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.to(() => Edit_Artist_profile(
                      userModel: currentUserData,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(child: Image.asset('assets/slicing/edit.png')),
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
                  // decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: res_height * 0.015,
                      ),
                      Container(
                        width: res_width * 0.3,
                        height: res_width * 0.3,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: NetworkImage('${currentUserData.userImage}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 4.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: res_height * 0.01,
                      ),
                      Text('${currentUserData.fullName}'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white)),
                      SizedBox(
                        height: res_height * 0.0075,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.white,
                            size: 18,
                          ),
                          Text(currentUserData.Nationality ?? 'California',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white,
                                height: 1.5,
                              ))
                        ],
                      ),

                      // SizedBox(height: res_height * 0.0075),
                      Container(
                        width: res_width * 0.6,
                        child: Center(
                          child: Text('${currentUserData.description}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
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
                        fontSize: 20),
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
                          height: Get.height * 0.19,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: currentUserData.album.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                          height: 100,
                                          width: res_width * 0.325,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(2.0, 2.0),
                                                blurRadius: 2,
                                                // spreadRadius: 10,
                                                color: Colors.black26,
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              '${currentUserData.album[index]}',
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                    ),
                                    // Text(
                                    //   'Lorem Ipsum',
                                    //   style: TextStyle(
                                    //       color: Colors.white,
                                    //       fontWeight: FontWeight.normal,
                                    //       fontSize: 16),
                                    // )
                                  ],
                                );
                              }),
                        ),

                        // Column(
                        //   children: [
                        //     Container(
                        //         width: res_width * 0.325,
                        //         child:
                        //             Image.asset('assets/slicing/poster2.png')),
                        //     Text(
                        //       'Lorem Ipsum',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 16),
                        //     )
                        //   ],
                        // ),
                        // Column(
                        //   children: [
                        //     Container(
                        //         width: res_width * 0.325,
                        //         child:
                        //             Image.asset('assets/slicing/poster3.png')),
                        //     Text(
                        //       'Lorem Ipsum',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 16),
                        //     )
                        //   ],
                        // ),
                        // Column(
                        //   children: [
                        //     Container(
                        //         width: res_width * 0.325,
                        //         child:
                        //             Image.asset('assets/slicing/poster3.png')),
                        //     Text(
                        //       'Lorem Ipsum',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 16),
                        //     )
                        //   ],
                        // )
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

                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      // height: Get.height * 0.25,
                      height: 60,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: currentUserData.musicCategorie.length,
                          itemBuilder: (context, index) {
                            return musicCat(res_width,
                                '${currentUserData.musicCategorie[index].toString()}');
                          }),
                    ),
                  ),
                ),

                // Container(
                //   width: res_width * 0.9,
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: [
                //         Container(
                //           width: res_width * 0.35,
                //           decoration: BoxDecoration(
                //               color: kPrimaryColor,
                //               borderRadius: BorderRadius.circular(15)),
                //           child: Center(
                //               child: Padding(
                //             padding: const EdgeInsets.all(18.0),
                //             child: Text(
                //               'Loremsum',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.normal,
                //                   fontSize: 15),
                //             ),
                //           )),
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         Container(
                //           width: res_width * 0.35,
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(15)),
                //           child: Center(
                //               child: Padding(
                //             padding: const EdgeInsets.all(18.0),
                //             child: Text(
                //               'Loremsum',
                //               style: TextStyle(
                //                   color: kPrimaryColor,
                //                   fontWeight: FontWeight.normal,
                //                   fontSize: 15),
                //             ),
                //           )),
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         Container(
                //           width: res_width * 0.35,
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(15)),
                //           child: Center(
                //               child: Padding(
                //             padding: const EdgeInsets.all(18.0),
                //             child: Text(
                //               'Loremsum',
                //               style: TextStyle(
                //                   color: kPrimaryColor,
                //                   fontWeight: FontWeight.normal,
                //                   fontSize: 15),
                //             ),
                //           )),
                //         ),
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
                          height: Get.height * 0.25,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: currentUserData.award.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                          height: 100,
                                          width: res_width * 0.325,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(2.0, 2.0),
                                                blurRadius: 2,
                                                // spreadRadius: 10,
                                                color: Colors.black26,
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              '${currentUserData.award[index]}',
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                    ),
                                    // Text(
                                    //   'Lorem Ipsum',
                                    //   style: TextStyle(
                                    //       color: Colors.white,
                                    //       fontWeight: FontWeight.normal,
                                    //       fontSize: 16),
                                    // )
                                  ],
                                );
                              }),
                        ),

                        // Container(
                        //     width: res_width * 0.3,
                        //     child: Image.asset('assets/slicing/award.png')),
                        // Container(
                        //     width: res_width * 0.3,
                        //     child: Image.asset('assets/slicing/award2.png')),
                        // Container(
                        //     width: res_width * 0.3,
                        //     child: Image.asset('assets/slicing/award3.png')),
                        // Container(
                        //     width: res_width * 0.3,
                        //     child: Image.asset('assets/slicing/award.png')),
                        // Container(
                        //     width: res_width * 0.3,
                        //     child: Image.asset('assets/slicing/award2.png'))
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: res_height * 0.03,
                // ),
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
                                // Icon(
                                //   Icons.facebook_outlined,
                                //   color: kPrimaryColor,
                                //   size: 40,
                                // ),
                                // SizedBox(
                                //   width: 10,
                                // ),
                                // Container(
                                //   height: res_height * 0.04,
                                //   width: 1,
                                //   color: Colors.grey,
                                // ),
                                // SizedBox(
                                //   width: 10,
                                // ),

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
                                      } catch (e) {
                                        EasyLoading.dismiss();
                                        print(e);
                                        // Get.snackbar("Could not launch $url",
                                        //     e.toString());
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
                  height: res_height * 0.06,
                ),
                // SizedBox(
                //   height: res_height * 0.015,
                // ),
                // Container(
                //   width: res_width * 0.9,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.all(Radius.circular(10))),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Row(
                //       children: [
                //         Icon(
                //           Icons.facebook_outlined,
                //           color: kPrimaryColor,
                //           size: 40,
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         Container(
                //           height: res_height * 0.04,
                //           width: 1,
                //           color: Colors.grey,
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         Text(
                //           'https://www.facebook.com',
                //           style: TextStyle(color: Colors.black, fontSize: 16),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: res_height * 0.125,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List musicCategorie = currentUserData.musicCategorie;

  GestureDetector musicCat(double res_width, txt) {
    return GestureDetector(
      onTap: () {
        print(txt);
        // musicCategorie = txt;
        // setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          width: res_width * 0.4,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 2,
                  // spreadRadius: 10,
                  color: Colors.black26,
                ),
              ],
              color:
                  //  musicCategorie == txt ? kPrimaryColor :
                  Colors.white,
              borderRadius: BorderRadius.circular(6)),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              '$txt',
              style: TextStyle(
                  color:
                      //  musicCategorie == txt ? Colors.white :
                      Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 17),
            ),
          )),
        ),
      ),
    );
  }
}
