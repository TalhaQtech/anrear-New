import 'package:anrear/helper/colors.dart';
import 'package:anrear/screens/auth/login.dart';
import 'package:anrear/screens/auth/newpassword.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OtpFieldController otpController = OtpFieldController();

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
            Hero(
              tag: 'logoImage',
              child: Container(
                  width: res_width * 0.4,
                  child: Image.asset('assets/slicing/logo.png')),
            ),
            SizedBox(
              height: res_height * 0.1,
            ),
            Text(
              'Enter OTP',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: res_height * 0.02,
            ),
            Container(
              width: res_width * 0.75,
              child: OTPTextField(
                  controller: otpController,
                  otpFieldStyle: OtpFieldStyle(
                    borderColor: Colors.white,
                    backgroundColor: Colors.white,
                    enabledBorderColor: Colors.white,
                    disabledBorderColor: Colors.white,
                  ),
                  length: 5,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 50,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 5,
                  style: TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  }),
            ),
            SizedBox(
              height: res_height * 0.015,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.to(() => NewPasswordScreen());
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
