import 'dart:async';

import 'package:anrear/screens/auth/selecttype_screen.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // defaultTransition: Transition.fadeIn,
      // transitionDuration: Duration(seconds: 1),
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'FiraSans'),
      home: SplashScree(),
    );
  }
}

class SplashScree extends StatefulWidget {
  const SplashScree({Key? key}) : super(key: key);

  @override
  State<SplashScree> createState() => _SplashScreeState();
}

class _SplashScreeState extends State<SplashScree> {
  @override
  void initState() {
    super.initState();
    print('run');
    Timer(Duration(seconds: 2), () => Get.to(() => SelectUserTypeScreen()));
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'logoImage',
              child: Container(
                  width: res_width * 0.4,
                  child: Image.asset('assets/slicing/logo.png')),
            )
          ],
        ),
      ),
    );
  }
}
