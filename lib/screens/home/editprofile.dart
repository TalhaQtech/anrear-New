import 'dart:typed_data';

import 'package:anrear/helper/bottomcontrller.dart';
import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/main.dart';
import 'package:anrear/models/usermodels.dart';
import 'package:anrear/screens/auth/login.dart';
import 'package:anrear/screens/home/drawer.dart';
import 'package:anrear/screens/home/notification.dart';
import 'package:anrear/screens/home/setting.dart';
import 'package:anrear/service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class editprofile extends StatefulWidget {
  editprofile({Key? key}) : super(key: key);

  @override
  State<editprofile> createState() => _ProfileScreen();
}

var name =
    TextEditingController(text: currentUserData.fullName ?? 'john@email.com');

class _ProfileScreen extends State<editprofile> {
  var description = TextEditingController(
    text: currentUserData.description ??
        'Lorem ipsum dolor sit amet consectetur adipiscing, eliteuismod laoreet dignissim mi quisque ullamcorper duis quis nisi.',
  );
  late TextEditingController userPhone = TextEditingController(
    text: currentUserData.userPhone,
  );

  Uint8List? image;
  void selectImage(ImageSource source) async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;

      // listimg.add(im);
      // print(listimg.length);
    });
  }

  var link;
  uploadimg() async {
    try {
      if (image != null) {
        UploadTask uploadTask = FirebaseStorage.instance
            .ref("userprofileimage")
            .child("userimg")
            .putData(image!);
        link = await uploadTask.snapshot.ref.getDownloadURL();
        print(link);
      } else
        link = currentUserData.userImage;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  final bottomctrl = Get.put(BottomController());

  update() async {
    try {
      await uploadimg();

      currentUserData.userPhone = userPhone.text.trim();
      currentUserData.fullName = name.text.trim();
      currentUserData.description = description.text.trim();
      setState(() {
        currentUserData.userImage = link;
      });
      print(currentUserData.userImage);

      await firestore_update("user", globalUserid, {
        "fullName": currentUserData.fullName,
        "userImage": link,
        "userPhone": currentUserData.userPhone,
        "description": currentUserData.description
      });
      // if (bottomctrl.navigationBarIndexValue != 2) {
      bottomctrl.navBarChange(2);
      // } else {
      Get.back();
      // }
    } catch (e) {
      EasyLoading.dismiss();

      print(e.toString());
      // Get.snackbar("Error", e.toString());
    }
  }

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
        // key: _key,
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          // leading: GestureDetector(
          //   behavior: HitTestBehavior.translucent,
          //   onTap: () {
          //     _key.currentState!.openDrawer();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(13.0),
          //     child:
          //         Container(child: Image.asset('assets/slicing/hamburger.png')),
          //   ),
          // ),
          // actions: [
          //   GestureDetector(
          //     behavior: HitTestBehavior.translucent,
          //     onTap: () {
          //       Get.to(() => NotificationScreen());
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.all(13.0),
          //       child: Container(
          //           child: Image.asset('assets/slicing/notfication.png')),
          //     ),
          //   )
          // ],
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    selectImage(ImageSource.gallery);
                    // if (image.isEmpty) {
                    //   await uploadimg(listimg);
                    // }
                    // setState(() {});
                  },
                  child: image == null
                      ? Stack(
                          children: [
                            Container(
                              width: res_width * 0.35,
                              height: res_width * 0.35,
                              decoration: BoxDecoration(
                                // color: const Color(0xff7c94b6),
                                // image: DecorationImage(
                                //     image: AssetImage(
                                //         "assets/slicing/avatarsidemenu.png"),
                                //     fit: BoxFit.contain,
                                //     scale: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                border: Border.all(
                                  color: kPrimaryColor,
                                  width: 4.0,
                                ),
                              ),
                              child: FittedBox(
                                child: Icon(
                                  Icons.person,
                                  color: kPrimaryColor,
                                  // size: Get.height ,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              // bottom: 0,
                              child: Icon(
                                Icons.add_a_photo,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                            ),
                            // IconButton(onPressed: (){}, icon: icon)
                          ],
                        )
                      :
                      // Container(
                      //     width: res_width * 0.35,
                      //     height: res_width * 0.35,
                      //     decoration: BoxDecoration(
                      //       // color: const Color(0xff7c94b6),
                      //       image: DecorationImage(
                      //         image: MemoryImage(image!),
                      //         fit: BoxFit.cover,
                      //       ),
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(100.0)),
                      //       border: Border.all(
                      //         color: kPrimaryColor,
                      //         width: 4.0,
                      //       ),
                      //     ),
                      // child: Image.memory(
                      //   image!,
                      //   fit: BoxFit.cover,
                      // ),
                      //   ),
                      // ),

                      Container(
                          width: res_width * 0.34,
                          height: res_width * 0.34,
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: DecorationImage(
                              image: MemoryImage(
                                image!,
                              ),
                              fit: BoxFit
                                  .cover, // NetworkImage(currentUserData.userImage ==
                              //         ""
                              //     ? "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"
                              //     : "${currentUserData.userImage}"),
                              // fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                            border: Border.all(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                          ),
                          // child: Image.memory(
                          //   image!,
                          //   height: 10,
                          // fit: BoxFit.contain,
                          // scale: ,
                          // ),
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
                      child: TextFormField(
                        controller: name,
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
                        currentUserData.userEmail ?? 'john@email.com',
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
                      child: TextFormField(
                        controller: userPhone,
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
                      child: TextFormField(
                        controller: description,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.01,
                ),
                // GestureDetector(
                //   behavior: HitTestBehavior.translucent,
                //   onTap: () {
                //     Get.to(() => SettingScreen());
                //   },
                //   child: Container(
                //     width: res_width * 0.9,
                //     decoration: BoxDecoration(
                //         color: kPrimaryColor,
                //         borderRadius: BorderRadius.circular(15)),
                //     child: Center(
                //         child: Padding(
                //       padding: const EdgeInsets.all(18.0),
                //       child: Text(
                //         'Setting',
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 17),
                //       ),
                //     )),
                //   ),
                // ),
                // SizedBox(
                //   height: res_height * 0.01,
                // ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    try {
                      EasyLoading.show();
                      await update();
                      EasyLoading.dismiss();
                    } on FirebaseException catch (e) {
                      Get.snackbar("Warrning", e.message.toString());
                    }

                    // Get.to(() => LoginScreen());
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
                        'Update',
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
