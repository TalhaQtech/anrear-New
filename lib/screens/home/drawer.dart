import 'package:anrear/helper/bottomcontrller.dart';
import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/models/usermodels.dart';
import 'package:anrear/screens/auth/login.dart';
import 'package:anrear/screens/auth/selecttype_screen.dart';
import 'package:anrear/screens/home/artistpolling_screen.dart';
import 'package:anrear/screens/home/confirmed_location.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:anrear/screens/home/my_performance_polling.dart';
import 'package:anrear/screens/home/privacy.dart';
import 'package:anrear/screens/home/setting.dart';
import 'package:anrear/screens/home/terms.dart';
import 'package:anrear/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final bottomctrl = Get.put(BottomController());
  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(100), bottomRight: Radius.circular(100)),
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff47367a),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: res_height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13, right: 13),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: res_width * 0.1675,
                            height: res_width * 0.1675,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: DecorationImage(
                                image: NetworkImage(currentUserData.userImage ==
                                        ""
                                    ? "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"
                                    : "${currentUserData.userImage}"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${currentUserData.fullName}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text('${currentUserData.userEmail}',
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: res_height * 0.04,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (bottomctrl.navigationBarIndexValue != 2) {
                    bottomctrl.navBarChange(2);
                  } else {
                    Get.back();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset(
                                  "assets/slicing/home sidemenu.png"),
                            ),
                            onPressed: () {
                              if (bottomctrl.navigationBarIndexValue != 2) {
                                bottomctrl.navBarChange(2);
                              } else {
                                Get.back();
                              }
                            },
                          ),
                          Text(
                            'Home',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.4),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (bottomctrl.navigationBarIndexValue != 4) {
                    bottomctrl.navBarChange(4);
                  } else {
                    Get.back();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset(
                                  "assets/slicing/avatarsidemenu.png"),
                            ),
                            onPressed: () {
                              if (bottomctrl.navigationBarIndexValue != 4) {
                                bottomctrl.navBarChange(4);
                              } else {
                                Get.back();
                              }
                            },
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.4),
                      )
                    ],
                  ),
                ),
              ),
              if (UserType == "")
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (bottomctrl.navigationBarIndexValue != 3) {
                      bottomctrl.navBarChange(3);
                    } else {
                      Get.back();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Image.asset("assets/slicing/list.png"),
                              ),
                              onPressed: () {
                                if (bottomctrl.navigationBarIndexValue != 3) {
                                  bottomctrl.navBarChange(3);
                                } else {
                                  Get.back();
                                }
                              },
                            ),
                            Text(
                              'Polling Lists',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                        Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.4),
                        )
                      ],
                    ),
                  ),
                ),
              if (UserType == "artist")
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (bottomctrl.navigationBarIndexValue != 3) {
                      bottomctrl.navBarChange(3);
                    } else {
                      Get.back();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Image.asset(
                                  "assets/slicing/singer.png",
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (bottomctrl.navigationBarIndexValue != 3) {
                                  bottomctrl.navBarChange(3);
                                } else {
                                  Get.back();
                                }
                              },
                            ),
                            Text(
                              'Artist',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                        Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.4),
                        )
                      ],
                    ),
                  ),
                ),
              if (UserType == "artist")
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    // if (bottomctrl.navigationBarIndexValue != 3) {
                    //   bottomctrl.navBarChange(3);
                    // } else {
                    //   Get.back();
                    // }
                    try {
                      var data = await
                          //  FirebaseFirestore.instance
                          //     .collection("PerformancePolling")
                          //     .doc("${globalUserid}")
                          //     .get();
                          firestore_get(
                              "PerformancePolling", "${globalUserid}");
                      var Perform = data.data();
                      print("object ${Perform}");

                      Get.to(() => my_perfomance_polling(
                          performancePolling: Perform,
                       ));
                    } catch (e) {
                      Get.snackbar("Error", e.toString());
                    }
                    // Get.to(my_perfomance_polling());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Image.asset(
                                    "assets/slicing/performing .png"),
                              ),
                              onPressed: () {
                                // if (bottomctrl.navigationBarIndexValue != 3) {
                                //   bottomctrl.navBarChange(3);
                                // } else {
                                //   Get.back();
                                // }
                                // Get.to(my_perfomance_polling());
                              },
                            ),
                            Text(
                              'My Perfomance Polling',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                        Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.4),
                        )
                      ],
                    ),
                  ),
                ),
              if (UserType == "artist")
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (bottomctrl.navigationBarIndexValue != 3) {
                      bottomctrl.navBarChange(3);
                    } else {
                      Get.back();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Image.asset(
                                    "assets/slicing/add performing.png"),
                              ),
                              onPressed: () {
                                if (bottomctrl.navigationBarIndexValue != 3) {
                                  bottomctrl.navBarChange(3);
                                } else {
                                  Get.back();
                                }
                              },
                            ),
                            Text(
                              'Add Performance',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                        Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.4),
                        )
                      ],
                    ),
                  ),
                ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.to(() => ConfirmLocationScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset(
                                  "assets/slicing/confirmed location.png"),
                            ),
                            onPressed: () {
                              Get.to(() => ConfirmLocationScreen());
                            },
                          ),
                          Text(
                            'Confirm Locations',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.4),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.to(() => SettingScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset("assets/slicing/setting.png"),
                            ),
                            onPressed: () {
                              Get.to(() => SettingScreen());
                            },
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.4),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.to(() => TermsScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset(
                                  "assets/slicing/termcondiditon.png"),
                            ),
                            onPressed: () {
                              Get.to(() => TermsScreen());
                            },
                          ),
                          Text(
                            'Terms & Condition',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.4),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.to(() => PrivacyScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset(
                                  "assets/slicing/privacypolicy.png"),
                            ),
                            onPressed: () {
                              Get.to(() => PrivacyScreen());
                            },
                          ),
                          Text(
                            'Privacy Policy',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.4),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.to(() => SelectUserTypeScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset("assets/slicing/logout.png"),
                            ),
                            onPressed: () {
                              Get.to(() => LoginScreen());
                            },
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.4),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: res_height * 0.22,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Route scaleIn(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      var begin = 0.0;
      var end = 1.0;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return ScaleTransition(
        scale: animation.drive(tween),
        child: page,
      );
    },
  );
}
