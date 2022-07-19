import 'package:anrear/helper/colors.dart';
import 'package:anrear/screens/auth/login.dart';
import 'package:anrear/screens/home/changepassword.dart';
import 'package:anrear/screens/home/notification.dart';
import 'package:anrear/screens/home/privacy.dart';
import 'package:anrear/screens/home/terms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  bool switchnot = true;

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
            'Setting',
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
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 6, bottom: 6, left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Notification',
                            style: TextStyle(fontSize: 17),
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              activeColor: Colors.green,
                              value: switchnot,
                              onChanged: (value) {
                                setState(() {
                                  switchnot = value;
                                });
                              },
                            ),
                          ),
                        ],
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
                    Get.to(() => TermsScreen());
                  },
                  child: Container(
                    width: res_width * 0.9,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Terms & Condition',
                              style: TextStyle(fontSize: 17),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          ],
                        ),
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
                    Get.to(() => PrivacyScreen());
                  },
                  child: Container(
                    width: res_width * 0.9,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Privacy Policy',
                              style: TextStyle(fontSize: 17),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          ],
                        ),
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
                    Get.to(() => ChangePasswordScreen());
                  },
                  child: Container(
                    width: res_width * 0.9,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Change Password',
                              style: TextStyle(fontSize: 17),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
