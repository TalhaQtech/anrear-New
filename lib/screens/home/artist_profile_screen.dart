import 'package:anrear/helper/colors.dart';
import 'package:anrear/screens/home/drawer.dart';
import 'package:anrear/screens/home/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                            image: AssetImage('assets/slicing/girl.jpeg'),
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
                      Text('John Doe',
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
                          Text('California',
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
                          child: Text(
                              'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
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
                        Column(
                          children: [
                            Container(
                                width: res_width * 0.325,
                                child:
                                    Image.asset('assets/slicing/poster1.png')),
                            Text(
                              'Lorem Ipsum',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                width: res_width * 0.325,
                                child:
                                    Image.asset('assets/slicing/poster2.png')),
                            Text(
                              'Lorem Ipsum',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                width: res_width * 0.325,
                                child:
                                    Image.asset('assets/slicing/poster3.png')),
                            Text(
                              'Lorem Ipsum',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                width: res_width * 0.325,
                                child:
                                    Image.asset('assets/slicing/poster3.png')),
                            Text(
                              'Lorem Ipsum',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            )
                          ],
                        )
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
                          width: res_width * 0.35,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              'Loremsum',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17),
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
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              'Loremsum',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17),
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
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              'Loremsum',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17),
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
                        fontSize: 20),
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
                  height: res_height * 0.125,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
