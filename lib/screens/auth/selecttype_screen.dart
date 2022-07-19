import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/screens/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SelectUserTypeScreen extends StatefulWidget {
  const SelectUserTypeScreen({Key? key}) : super(key: key);

  @override
  State<SelectUserTypeScreen> createState() => _SelectUserTypeScreenState();
}

class _SelectUserTypeScreenState extends State<SelectUserTypeScreen> {
  @override
  void initState() {
    super.initState();
    // print('run');
    // Timer(Duration(seconds: 2), () => Get.to(() => HomeMainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/slicing/Bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: res_height * 0.15,
            ),
            Hero(
              tag: 'logoImage',
              child: Container(
                  width: res_width * 0.4,
                  child: Image.asset('assets/slicing/logo.png')),
            ),
            SizedBox(
              height: res_height * 0.125,
            ),
            Text(
              'Select',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
            SizedBox(
              height: res_height * 0.015,
            ),
            GestureDetector(
              onTap: () {
                UserType = "user";
                Get.to(() => LoginScreen());
              },
              child: Container(
                width: res_width * 0.9,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Login As User',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                )),
              ),
            ),
            SizedBox(
              height: res_height * 0.015,
            ),
            GestureDetector(
              onTap: () {
                UserType = "artist";
                Get.to(() => LoginScreen());
              },
              child: Container(
                width: res_width * 0.9,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Login As Artist',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
