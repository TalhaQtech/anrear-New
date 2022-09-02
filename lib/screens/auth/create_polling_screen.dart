import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/models/performancePollingModels.dart';
import 'package:anrear/models/usermodels.dart';
import 'package:anrear/screens/auth/forgot.dart';
import 'package:anrear/screens/auth/login.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:anrear/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CreatePollingScreen extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  const CreatePollingScreen({Key? key, this.userModel, this.firebaseUser})
      : super(key: key);

  @override
  State<CreatePollingScreen> createState() => _CreatePollingScreenState();
}

class _CreatePollingScreenState extends State<CreatePollingScreen> {
  var location = TextEditingController();
  var location2 = TextEditingController();
  var startDate = TextEditingController();
  var endDate = TextEditingController();
  var fullName = TextEditingController();

  @override
  void initState() {
    super.initState();
    // print('run');
    // Timer(Duration(seconds: 2), () => Get.to(() => HomeMainScreen()));
  }

  uploadData() async {
    String locationc = location.text.trim();
    String location2c = location2.text.trim();
    String startDatec = startDate.text.trim();
    String endDatec = endDate.text.trim();
    String perNamec = fullName.text.trim();
    if (locationc == "" ||
        location2c == "" ||
        startDatec == "" ||
        endDatec == "" ||
        perNamec == "") {
      Get.snackbar("Incomplete Data", "Please fill all the fields");
    } else {
      try {
        EasyLoading.show();
        performancePolingModel newUser = await performancePolingModel(
            description: widget.userModel!.description,
            userImage: widget.userModel!.userImage,
            uid: widget.userModel!.uid,
            location: location.text.trim(),
            location2: location2.text.trim(),
            endDate: endDate.text.trim(),
            startDate: startDate.text.trim(),
            fullName: fullName.text.trim());
        await firestore_set(
            "PerformancePolling", globalUserid, newUser.toMap());
        Get.to(() => HomeMainScreen(
              userModel: widget.userModel,
            ));
        EasyLoading.dismiss();
        //     .than((value) {

        //   EasyLoading.dismiss();
        // });
      } catch (e) {
        print(e.toString());
        Get.snackbar("Error", e.toString());
        EasyLoading.dismiss();
      }
    }
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
                'Create Performance Polling',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: TextFormField(
                  controller: fullName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Performance Name",
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: TextFormField(
                  controller: location,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Location",
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: Text(
                  'Upload image of polling location',
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
                child: TextFormField(
                  controller: location2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Location 2",
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: Text(
                  'Upload image of polling location',
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
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Add Another Location',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                )),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: Text(
                  'Polling start and end date',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: res_width * 0.425,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: startDate,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.black),
                                hintText: "02/02/02",
                                fillColor: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: res_width * 0.425,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Date',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: endDate,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.black),
                                hintText: "02/02/02",
                                fillColor: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: Center(
                  child: Text(
                    'Upload most famous music youtube links',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
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
                onTap: () {
                  // Get.to(() => ForgotScreen());
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
                onTap: () {
                  uploadData();
                  // Get.to(() => HomeMainScreen());
                  // userModel: widget.userModel,
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











// import 'package:anrear/helper/colors.dart';
// import 'package:anrear/models/usermodels.dart';
// import 'package:anrear/screens/auth/forgot.dart';
// import 'package:anrear/screens/auth/login.dart';
// import 'package:anrear/screens/home/homemain.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';

// class CreatePollingScreen extends StatefulWidget {
//   final UserModel? userModel;
//   final User? firebaseUser;
//   const CreatePollingScreen({Key? key, this.userModel, this.firebaseUser})
//       : super(key: key);

//   @override
//   State<CreatePollingScreen> createState() => _CreatePollingScreenState();
// }

// class _CreatePollingScreenState extends State<CreatePollingScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // print('run');
//     // Timer(Duration(seconds: 2), () => Get.to(() => HomeMainScreen()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     double res_width = MediaQuery.of(context).size.width;
//     double res_height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/slicing/Bg.jpg"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: res_height * 0.11,
//               ),
//               Text(
//                 'Create Performance Polling',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 26),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 child: TextField(
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       hintStyle: TextStyle(color: Colors.grey),
//                       hintText: "Performance Name",
//                       fillColor: Colors.white),
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 child: TextField(
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       hintStyle: TextStyle(color: Colors.grey),
//                       hintText: "Location",
//                       fillColor: Colors.white),
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 child: Text(
//                   'Upload image of polling location',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17),
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: res_width * 0.2,
//                       height: res_width * 0.2,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(13))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(
//                           Icons.image_outlined,
//                           color: Colors.grey,
//                           size: 33,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: res_width * 0.2,
//                       height: res_width * 0.2,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(13))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(
//                           Icons.image_outlined,
//                           color: Colors.grey,
//                           size: 33,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: res_width * 0.2,
//                       height: res_width * 0.2,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(13))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(
//                           Icons.image_outlined,
//                           color: Colors.grey,
//                           size: 33,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: res_width * 0.2,
//                       height: res_width * 0.2,
//                       decoration: BoxDecoration(
//                           color: kPrimaryColor,
//                           borderRadius: BorderRadius.all(Radius.circular(13))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(
//                           Icons.add_outlined,
//                           color: Colors.white,
//                           size: 33,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 child: TextField(
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       hintStyle: TextStyle(color: Colors.grey),
//                       hintText: "Location 2",
//                       fillColor: Colors.white),
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 child: Text(
//                   'Upload image of polling location',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17),
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: res_width * 0.2,
//                       height: res_width * 0.2,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(13))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(
//                           Icons.image_outlined,
//                           color: Colors.grey,
//                           size: 33,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: res_width * 0.2,
//                       height: res_width * 0.2,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(13))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(
//                           Icons.image_outlined,
//                           color: Colors.grey,
//                           size: 33,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: res_width * 0.2,
//                       height: res_width * 0.2,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(13))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(
//                           Icons.image_outlined,
//                           color: Colors.grey,
//                           size: 33,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: res_width * 0.2,
//                       height: res_width * 0.2,
//                       decoration: BoxDecoration(
//                           color: kPrimaryColor,
//                           borderRadius: BorderRadius.all(Radius.circular(13))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Icon(
//                           Icons.add_outlined,
//                           color: Colors.white,
//                           size: 33,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 decoration: BoxDecoration(
//                     color: kPrimaryColor,
//                     borderRadius: BorderRadius.circular(15)),
//                 child: Center(
//                     child: Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Text(
//                     'Add Another Location',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 17),
//                   ),
//                 )),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 child: Text(
//                   'Polling start and end date',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17),
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: res_width * 0.425,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Start Date',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.normal,
//                                 fontSize: 16),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           TextField(
//                             decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 filled: true,
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 hintText: "02/02/02",
//                                 fillColor: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: res_width * 0.425,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'End Date',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.normal,
//                                 fontSize: 16),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           TextField(
//                             decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 filled: true,
//                                 hintStyle: TextStyle(color: Colors.black),
//                                 hintText: "02/02/02",
//                                 fillColor: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 child: Center(
//                   child: Text(
//                     'Upload most famous music youtube links',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               Container(
//                 width: res_width * 0.9,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.facebook_outlined,
//                         color: kPrimaryColor,
//                         size: 40,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         height: res_height * 0.04,
//                         width: 1,
//                         color: Colors.grey,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'https://www.facebook.com',
//                         style: TextStyle(color: Colors.black, fontSize: 16),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               GestureDetector(
//                 behavior: HitTestBehavior.translucent,
//                 onTap: () {
//                   // Get.to(() => ForgotScreen());
//                 },
//                 child: Container(
//                   width: res_width * 0.9,
//                   decoration: BoxDecoration(
//                       color: kPrimaryColor,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Center(
//                       child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: Icon(
//                       Icons.add_outlined,
//                       color: Colors.white,
//                       size: 17,
//                     ),
//                   )),
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.015,
//               ),
//               GestureDetector(
//                 behavior: HitTestBehavior.translucent,
//                 onTap: () {
//                   Get.to(() => HomeMainScreen());
//                 },
//                 child: Container(
//                   width: res_width * 0.9,
//                   decoration: BoxDecoration(
//                       color: kPrimaryColor,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Center(
//                       child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: Text(
//                       'Continue',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 17),
//                     ),
//                   )),
//                 ),
//               ),
//               SizedBox(
//                 height: res_height * 0.02,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
