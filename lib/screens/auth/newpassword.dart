import 'package:anrear/helper/colors.dart';
import 'package:anrear/screens/auth/login.dart';
import 'package:anrear/screens/auth/otpscreen.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
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
              height: res_height * 0.11,
            ),
            Container(
                width: res_width * 0.4,
                child: Image.asset('assets/slicing/logo.png')),
            SizedBox(
              height: res_height * 0.1,
            ),
            Text(
              'New Password',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: res_height * 0.02,
            ),
            Container(
              width: res_width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Password",
                    fillColor: Colors.white),
              ),
            ),
            SizedBox(
              height: res_height * 0.015,
            ),
            Container(
              width: res_width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Confirm Password",
                    fillColor: Colors.white),
              ),
            ),
            SizedBox(
              height: res_height * 0.015,
            ),
            GestureDetector(
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
                    'Continue',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                )),
              ),
            ),
            SizedBox(
              height: res_height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
