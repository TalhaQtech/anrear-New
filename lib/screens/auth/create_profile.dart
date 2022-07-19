import 'package:anrear/helper/colors.dart';
import 'package:anrear/screens/auth/create_polling_screen.dart';
import 'package:anrear/screens/auth/forgot.dart';
import 'package:anrear/screens/auth/login.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
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
      body: SingleChildScrollView(
        child: Container(
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
              Text(
                'Create Profile',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.35,
                height: res_width * 0.35,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: AssetImage("assets/slicing/girl.jpeg"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  border: Border.all(
                    color: kPrimaryColor,
                    width: 4.0,
                  ),
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
                      hintText: "Full Name",
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
                      hintText: "Nationality",
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
                      hintText: "Dob",
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: TextField(
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Description",
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: Text(
                  'Award Winning',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: res_width * 0.2,
                      height: res_width * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image_outlined,
                          color: Colors.grey,
                          size: 33,
                        ),
                      ),
                    ),
                    Container(
                      width: res_width * 0.2,
                      height: res_width * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image_outlined,
                          color: Colors.grey,
                          size: 33,
                        ),
                      ),
                    ),
                    Container(
                      width: res_width * 0.2,
                      height: res_width * 0.2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image_outlined,
                          color: Colors.grey,
                          size: 33,
                        ),
                      ),
                    ),
                    Container(
                      width: res_width * 0.2,
                      height: res_width * 0.2,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add_outlined,
                          color: Colors.white,
                          size: 33,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: Text(
                  'Music Category',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
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
                height: res_height * 0.02,
              ),
              Container(
                width: res_width * 0.9,
                child: Center(
                  child: Text(
                    'Upload most famous music youtube links',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
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
                height: res_height * 0.015,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.to(() => ForgotScreen());
                },
                child: Container(
                  width: res_width * 0.9,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Icon(
                      Icons.add_outlined,
                      color: Colors.white,
                      size: 17,
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.to(() => CreatePollingScreen());
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
      ),
    );
  }
}
