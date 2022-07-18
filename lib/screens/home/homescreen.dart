import 'package:anrear/helper/colors.dart';
import 'package:anrear/screens/home/artistpolling_screen.dart';
import 'package:anrear/screens/home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final selectionctrl = Get.put(SelectionController());

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
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                  child: Image.asset('assets/slicing/notfication.png')),
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
                  width: res_width * 0.94,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: res_width * 0.7,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 23, bottom: 23, left: 10, right: 10),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'John Doe',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                    Container(
                                        width: res_width * 0.45,
                                        child: Text(
                                            'Lorem ipsum dolor sit amet, adipi scing elit.',
                                            style: TextStyle(
                                              fontSize: 13,
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
                                      image: AssetImage(
                                          'assets/slicing/girl.jpeg'),
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: res_width * 0.05,
                        ),
                        Container(
                          width: res_width * 0.7,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 23, bottom: 23, left: 10, right: 10),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'John Doe',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                    Container(
                                        width: res_width * 0.45,
                                        child: Text(
                                            'Lorem ipsum dolor sit amet, adipi scing elit.',
                                            style: TextStyle(
                                              fontSize: 13,
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
                                      image: AssetImage(
                                          'assets/slicing/girl.jpeg'),
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
                              ],
                            ),
                          ),
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
                    child: GetBuilder<SelectionController>(
                      builder: (_) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
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
                                        BorderRadius.all(Radius.circular(25))),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      'Artist List',
                                      style: TextStyle(
                                          color: selectionctrl.selectionValue ==
                                                  0
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: res_width * 0.02,
                            ),
                            GestureDetector(
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
                                        BorderRadius.all(Radius.circular(25))),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      'Polling',
                                      style: TextStyle(
                                          color: selectionctrl.selectionValue ==
                                                  1
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: res_width * 0.02,
                            ),

                            GestureDetector(
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
                                        BorderRadius.all(Radius.circular(25))),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      'Confirm Location',
                                      style: TextStyle(
                                          color: selectionctrl.selectionValue ==
                                                  2
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
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
                                ? Column(
                                    children: [
                                      ArtistBox(
                                          'John Doe',
                                          'assets/slicing/girl.jpeg',
                                          'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                                      ArtistBox(
                                          'Andy Marshal',
                                          'assets/slicing/girl.jpeg',
                                          'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                                      ArtistBox(
                                          'Sarah Smith',
                                          'assets/slicing/girl.jpeg',
                                          'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.'),
                                    ],
                                  )
                                : selectionctrl.selectionValue == 1
                                    ? Column(
                                        children: [
                                          PollingBox(
                                              'John Doe',
                                              'assets/slicing/girl.jpeg',
                                              'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
                                              '2/2/2022',
                                              '2/2/2022'),
                                          PollingBox(
                                              'John Doe',
                                              'assets/slicing/girl.jpeg',
                                              'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
                                              '2/2/2022',
                                              '2/2/2022'),
                                        ],
                                      )
                                    : selectionctrl.selectionValue == 2
                                        ? Column(
                                            children: [
                                              ConfirmLocationBox(
                                                  'John Doe',
                                                  'assets/slicing/girl.jpeg',
                                                  'Lorem ipsum dolor sit amet, adipi scing elit. dipi scing elit.',
                                                  'Confirm'),
                                            ],
                                          )
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

  PollingBox(name, image, description, start, end) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Get.to(() => ArtistPollingScreen());
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
                      image: AssetImage(image),
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
                          fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                    SizedBox(
                      height: res_height * 0.00075,
                    ),
                    Container(
                        width: res_width * 0.6,
                        child: Text(description,
                            style: TextStyle(
                              fontSize: 13,
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
                              fontSize: 12,
                              color: Color(0xff929292),
                              height: 1.5,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Text('End: ${end}',
                            style: TextStyle(
                              fontSize: 12,
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
                    image: AssetImage(image),
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
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
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
                            Text('Location 1: ',
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
                            fontSize: 13,
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

  ArtistBox(name, image, description) {
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
                    image: AssetImage(image),
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
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  ),
                  SizedBox(
                    height: res_height * 0.00075,
                  ),
                  Container(
                      width: res_width * 0.6,
                      child: Text(description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff929292),
                            height: 1.5,
                          )))
                ],
              )
            ],
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
