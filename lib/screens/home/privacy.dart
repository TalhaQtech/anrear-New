import 'package:anrear/helper/colors.dart';
import 'package:anrear/screens/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreen();
}

class _PrivacyScreen extends State<PrivacyScreen> {
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
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios)),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.all(13.0),
          //     child: Container(
          //         child: Image.asset('assets/slicing/notfication.png')),
          //   )
          // ],
          centerTitle: true,
          title: Text(
            'Privacy Policy',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Lorem ipsum dolor sit amet consectetur adipiscing elitridiculus, ad mus himenaeos nisl primis tellus diam netussociosqu, et torquent quam vitae platea donec leo. Dic-tumst ridiculus porta cum conubia penatibus nibh suscip-it habitasse libero, etiam eros torquent purus orci aeneansodales elementum, cure commodo dignissim facilisisaliquam magnis bibendum rutrum. Metus auctor arcu ul-tricies bibendum litora eleifend cras proin elementum ad,sapien egestas congue cum dapibus massa rhoncus mi.',
                          style: TextStyle(),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
                        child: Text(
                          'Lorem ipsum dolor sit amet consectetur adipiscing elitridiculus, ad mus himenaeos nisl primis tellus diam netussociosqu, et torquent quam vitae platea donec leo. Dic-tumst ridiculus porta cum conubia penatibus nibh suscip-it habitasse libero, etiam eros torquent purus orci aeneansodales elementum, cure commodo dignissim facilisisaliquam magnis bibendum rutrum. Metus auctor arcu ul-tricies bibendum litora eleifend cras proin elementum ad,sapien egestas congue cum dapibus massa rhoncus mi.',
                          style: TextStyle(),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 15),
                        child: Text(
                          'Lorem ipsum dolor sit amet consectetur adipiscing elitridiculus, ad mus himenaeos nisl primis tellus diam netussociosqu, et torquent quam vitae platea donec leo. Dic-tumst ridiculus porta cum conubia penatibus nibh suscip-it habitasse libero, etiam eros torquent purus orci aeneansodales elementum, cure commodo dignissim facilisisaliquam magnis bibendum rutrum. Metus auctor arcu ul-tricies bibendum litora eleifend cras proin elementum ad,sapien egestas congue cum dapibus massa rhoncus mi.',
                          style: TextStyle(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
