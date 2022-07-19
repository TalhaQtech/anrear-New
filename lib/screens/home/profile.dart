import 'package:anrear/helper/colors.dart';
import 'package:anrear/screens/auth/login.dart';
import 'package:anrear/screens/home/drawer.dart';
import 'package:anrear/screens/home/notification.dart';
import 'package:anrear/screens/home/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
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
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: res_width * 0.34,
                  height: res_width * 0.34,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: AssetImage('assets/slicing/girl.jpeg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    border: Border.all(
                      color: kPrimaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.03,
                ),
                Container(
                  width: res_width * 0.9,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'John Doe',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.01,
                ),
                Container(
                  width: res_width * 0.9,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'john@email.com',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.01,
                ),
                Container(
                  width: res_width * 0.9,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '+123 321 213123',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.01,
                ),
                Container(
                  width: res_width * 0.9,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet consectetur adipiscing, eliteuismod laoreet dignissim mi quisque ullamcorper duis quis nisi.',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.01,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.to(() => SettingScreen());
                  },
                  child: Container(
                    width: res_width * 0.9,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Setting',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    )),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.01,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.to(() => LoginScreen());
                  },
                  child: Container(
                    width: res_width * 0.9,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    )),
                  ),
                ),
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
}
