import 'dart:typed_data';

import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/main.dart';
import 'package:anrear/models/performancePollingModels.dart';
import 'package:anrear/models/usermodels.dart';
import 'package:anrear/screens/home/artistpolling_screen.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:anrear/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';

class CreatePollingScreen extends StatefulWidget {
  final UserModel? userModel;
  // var firebaseUser;
  CreatePollingScreen({
    Key? key,
    this.userModel,
  }) : super(key: key);

  @override
  State<CreatePollingScreen> createState() => _CreatePollingScreenState();
}

class _CreatePollingScreenState extends State<CreatePollingScreen> {
  var location = TextEditingController();
  var location2 = TextEditingController();
  var startDate = TextEditingController();
  var endDate = TextEditingController();
  var fullName = TextEditingController();
  List fbLinksControl = [];

  var fbitemCount = 1;
  TextEditingController _controllers = TextEditingController();

  var location3 = TextEditingController();

  var isvisible = false;

  var location4 = TextEditingController();

  DateTime? start;

  DateTime? end;

  var isvisible2 = false;

  // var _controllers2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    // print('run');
    // Timer(Duration(seconds: 2), () => Get.to(() => HomeMainScreen()));
  }

  Uint8List? image;
  List listimg = [];
  List listimg2 = [];
  List listimg3 = [];
  List listimg4 = [];
  var urls1 = [];
  var urls2 = [];
  var urls3 = [];
  var urls4 = [];
  // var locat3 = false;
  // var locat4 = false;

  selectImage(ImageSource source, listofimg) async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    if (im != null) {
      // print(im);
      setState(() {
        // image = im;
        listofimg.add(im);
        // print(listofimg);
      });
    }
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
      Get.snackbar("Error", "Please fill all the fields");
    } else if (start == null ||
        end == null ||
        DateTime.now().day > start!.day ||
        DateTime.now().month > start!.month ||
        DateTime.now().year > start!.year ||
        end!.day < start!.day ||
        end!.month < start!.month ||
        end!.year < start!.year) {
      Get.snackbar("Error", "Please select proper date");
    } else {
      EasyLoading.show();
      // if (listimg.isNotEmpty) {

      // }
      try {
        performancePolingModel newUser = await performancePolingModel(
            time: Timestamp.now(),
            youtubeurls: fbLinksControl.isNotEmpty
                ? fbLinksControl
                : [_controllers.text.trim()],
            location3:
                location3.text.trim() == "" ? "false" : location3.text.trim(),
            location4:
                location4.text.trim() == "" ? "false" : location4.text.trim(),
            polling_location_im3: locImgList3,
            polling_location_im4: locImgList4,
            polling_location_im2: locImgList2,
            polling_location_im: locImgList1,
            description: widget.userModel!.description,
            userImage: widget.userModel!.userImage,
            uid: widget.userModel!.uid,
            location: location.text.trim(),
            location2: location2.text.trim(),
            endDate: endDate.text.trim(),
            startDate: startDate.text.trim(),
            fullName: fullName.text.trim());
        await firestore_set(
          "PerformancePolling",
          currentUserData.uid,
          newUser.toMap(),
        );
        Get.to(() => HomeMainScreen(
              userModel: widget.userModel,
            ));
        EasyLoading.dismiss();
        Get.snackbar("successfully done ", "");
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

  // List<String> imagesUrls = [];
  List<String> imagesUrls2 = [];

  // uploadimg(listOfimg, imagesUrls) {
  //   listOfimg.forEach((listOfimg) async {
  //     print(listOfimg);
  //     try {
  //       EasyLoading.show();
  //       UploadTask uploadTask = FirebaseStorage.instance
  //           .ref("testimg")
  //           .child(uuid.v1().toString())
  //           .putData(listOfimg!);
  //       TaskSnapshot? snapshot = await uploadTask;
  //       // print(await uploadTask.snapshot.ref.getDownloadURL());
  //       // imagesUrls.add(await (await uploadTask).ref.getDownloadURL());
  //       imagesUrls.add(await uploadTask.snapshot.ref.getDownloadURL());
  //       // print(snapshot.ref.getDownloadURL());
  //       EasyLoading.dismiss();
  //     } catch (e) {
  //       EasyLoading.dismiss();

  //       print(e);
  //     }
  //   });
  //   print(imagesUrls);
  //   return imagesUrls;
  // }

// ye sahi hai
  Uint8List? locImg1;
  Uint8List? locImg2;
  Uint8List? locImg3;
  Uint8List? locImg4;
  List locImgList1 = [];
  List locImgList2 = [];

  List locImgList3 = [];
  List locImgList4 = [];
  selectImage1(
    ImageSource source,
  ) async {
    print(0);
    locImg1 = await pickImage(ImageSource.gallery);

    if (locImg1!.isNotEmpty) {
      print(locImg1);
    }
  }

  selectImage2(
    ImageSource source,
  ) async {
    print(0);
    locImg2 = await pickImage(ImageSource.gallery);

    if (locImg2!.isNotEmpty) {
      print(locImg2);
    }
  }

  selectImage3(
    ImageSource source,
  ) async {
    print(0);
    locImg3 = await pickImage(ImageSource.gallery);

    if (locImg3!.isNotEmpty) {
      print(locImg3);
    }
  }

  selectImage4(
    ImageSource source,
  ) async {
    print(0);
    locImg4 = await pickImage(ImageSource.gallery);

    if (locImg4!.isNotEmpty) {
      print(locImg4);
    }
  }

  upload_award(locimg) async {
    print(0);

    print("$locimg" + "im");
    print(1);
    final Reference reference = FirebaseStorage.instance
        .ref()
        .child("products")
        .child("product_${locimg.length}.png");
    ;
    print(2);
    String downloadURL;

    UploadTask uploadTask = reference.putData(locimg!);
    print(3);
    // var storageSnapshot = uploadTask.snapshot;
    print(4);
    downloadURL = await (await uploadTask).ref.getDownloadURL();
    //  downloadURL = await storageSnapshot.ref.getDownloadURL();
    // print(downloadUrl);
    return downloadURL;
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: 400,
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: locImgList1.length,
                          itemBuilder: (context, index) {
                            return locImgList1[index] != null
                                ? Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: res_width * 0.25,
                                          height: res_width * 0.9,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(2.0, 2.0),
                                                blurRadius: 2,
                                                // spreadRadius: 10,
                                                color: Colors.black26,
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              locImgList1[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 70,
                                        top: -11,
                                        child: IconButton(
                                            onPressed: () async {
                                              try {
                                                locImgList1
                                                    .remove(locImgList1[index]);
                                                setState(() {});
                                              } catch (e) {
                                                print(e);
                                              }

                                              // setState(() {});
                                            },
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ],
                                  )
                                : Container();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            EasyLoading.show();
                            await selectImage1(
                              ImageSource.gallery,
                            );
                            // await upload_award(locImg2, locImgList2);
                            locImgList1.add(await upload_award(locImg1));

                            setState(() {});
                            EasyLoading.dismiss();
                          } on FirebaseException catch (e) {
                            EasyLoading.dismiss();
                            Get.snackbar("Error", e.message.toString());
                            print(e.toString());
                          } catch (e) {
                            EasyLoading.dismiss();
                            print(e.toString());
                          }
                        },
                        child: Container(
                          width: res_width * 0.2,
                          height: res_width * 0.2,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.add_outlined,
                              color: Colors.white,
                              size: 33,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: res_height * 0.015,
              ),

              // Container(
              //   width: res_width * 0.9,
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         // Container(
              //         //     height: 100,
              //         //     child:
              //         // StreamBuilder<QuerySnapshot>(
              //         // stream: FirebaseFirestore.instance
              //         //     .collection("artist")
              //         //     .where(
              //         //       "uid",
              //         //       isEqualTo: globalUserid,
              //         //     )
              //         //     // .where("uid",
              //         //     //     isNotEqualTo: globalUserid)
              //         //     .snapshots(),
              //         // builder: (BuildContext context,
              //         //     AsyncSnapshot<QuerySnapshot> snapshot) {
              //         //   {
              //         //             return ListView.builder(
              //         //                 shrinkWrap: true,
              //         //                 scrollDirection: Axis.horizontal,
              //         //                 itemCount: snapshot.data?.docs.length,
              //         //                 itemBuilder: (context, index) {
              //         //                   return ListView.builder(
              //         //                     shrinkWrap: true,
              //         //                     scrollDirection: Axis.horizontal,
              //         //                     itemCount:
              //         //                         widget.userModel!.award!.length,
              //         //                     itemBuilder: (context, index) {
              //         //                       return widget.userModel?.award !=
              //         //                               null

              //         //                           : Container();
              //         //                     },
              //         //                   );
              //         //                 });
              //         //           }
              //         //         })),
              //         Container(
              //           // width: 400,
              //           height: 100,
              //           child: ListView.builder(
              //             shrinkWrap: true,
              //             scrollDirection: Axis.horizontal,
              //             itemCount: locImgList1.length,
              //             itemBuilder: (context, index) {
              //               return locImgList1[index] != null
              //                   ? Stack(
              //                       children: [
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Container(
              //                             width: res_width * 0.25,
              //                             height: res_width * 0.9,
              //                             decoration: BoxDecoration(
              //                               boxShadow: [
              //                                 BoxShadow(
              //                                   offset: Offset(2.0, 2.0),
              //                                   blurRadius: 2,
              //                                   // spreadRadius: 10,
              //                                   color: Colors.black26,
              //                                 ),
              //                               ],
              //                             ),
              //                             child: ClipRRect(
              //                               borderRadius:
              //                                   BorderRadius.circular(8.0),
              //                               child: Image.network(
              //                                 locImgList1[index],
              //                                 fit: BoxFit.cover,
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         Positioned(
              //                           right: 70,
              //                           top: -11,
              //                           child: IconButton(
              //                               onPressed: () async {
              //                                 try {
              //                                   locImgList1
              //                                       .remove(locImgList1[index]);
              //                                   setState(() {});
              //                                 } catch (e) {
              //                                   print(e);
              //                                 }

              //                                 // setState(() {});
              //                               },
              //                               icon: Icon(
              //                                 Icons.remove_circle,
              //                                 color: Colors.black,
              //                               )),
              //                         ),
              //                       ],
              //                     )
              //                   : Container();
              //             },
              //           ),
              //         ),
              //         GestureDetector(
              //           onTap: () async {
              //             // selectImage(ImageSource.gallery);
              //             try {
              //               EasyLoading.show();
              //               await selectImage2(
              //                 ImageSource.gallery,
              //               );

              //               print("uploading award");

              //               locImgList1.add(await upload_award(locImg1));

              //               // Get.snackbar("Error", "${e.message}");

              //               setState(() {});
              //               EasyLoading.dismiss();
              //             } on FirebaseException catch (e) {
              //               EasyLoading.dismiss();
              //               Get.snackbar("Error", e.message.toString());
              //               print(e.toString());
              //             } catch (e) {
              //               EasyLoading.dismiss();
              //               print(e.toString());
              //             }
              //           },
              //           child: Container(
              //             width: res_width * 0.2,
              //             height: res_width * 0.2,
              //             decoration: BoxDecoration(
              //                 color: kPrimaryColor,
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(13))),
              //             child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Icon(
              //                 Icons.add_outlined,
              //                 color: Colors.white,
              //                 size: 33,
              //               ),
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: 400,
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: locImgList2.length,
                          itemBuilder: (context, index) {
                            return locImgList2[index] != null
                                ? Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: res_width * 0.25,
                                          height: res_width * 0.9,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(2.0, 2.0),
                                                blurRadius: 2,
                                                // spreadRadius: 10,
                                                color: Colors.black26,
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              locImgList2[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 70,
                                        top: -11,
                                        child: IconButton(
                                            onPressed: () async {
                                              try {
                                                locImgList2
                                                    .remove(locImgList2[index]);
                                                setState(() {});
                                              } catch (e) {
                                                print(e);
                                              }

                                              // setState(() {});
                                            },
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ],
                                  )
                                : Container();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            EasyLoading.show();
                            await selectImage2(
                              ImageSource.gallery,
                            );
                            // await upload_award(locImg2, locImgList2);
                            locImgList2.add(await upload_award(locImg2));

                            setState(() {});
                            EasyLoading.dismiss();
                          } on FirebaseException catch (e) {
                            EasyLoading.dismiss();
                            Get.snackbar("Error", e.message.toString());
                            print(e.toString());
                          } catch (e) {
                            EasyLoading.dismiss();
                            print(e.toString());
                          }
                        },
                        child: Container(
                          width: res_width * 0.2,
                          height: res_width * 0.2,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.add_outlined,
                              color: Colors.white,
                              size: 33,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: res_height * 0.015,
              ),

              // locat3
              //     ?
              Visibility(
                visible: isvisible,
                child: Container(
                  width: res_width * 0.9,
                  child: TextFormField(
                    controller: location3,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Location 3",
                        fillColor: Colors.white),
                  ),
                ),
              )
              // : Container(),
              ,
              SizedBox(
                height: res_height * 0.015,
              ),
              // locat3
              //     ?
              Visibility(
                visible: isvisible,
                child: Container(
                  width: res_width * 0.9,
                  child: Text(
                    'Upload image of polling location',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              )
              // : Container(),
              ,
              SizedBox(
                height: res_height * 0.015,
              ),

              // locat3
              //     ?
              Visibility(
                visible: isvisible,
                child: Container(
                  width: res_width * 0.9,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: 400,
                          height: 100,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: locImgList3.length,
                            itemBuilder: (context, index) {
                              return locImgList3[index] != null
                                  ? Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: res_width * 0.25,
                                            height: res_width * 0.9,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(2.0, 2.0),
                                                  blurRadius: 2,
                                                  // spreadRadius: 10,
                                                  color: Colors.black26,
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                locImgList3[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 70,
                                          top: -11,
                                          child: IconButton(
                                              onPressed: () async {
                                                try {
                                                  locImgList3.remove(
                                                      locImgList3[index]);
                                                  setState(() {});
                                                } catch (e) {
                                                  print(e);
                                                }

                                                // setState(() {});
                                              },
                                              icon: Icon(
                                                Icons.remove_circle,
                                                color: Colors.black,
                                              )),
                                        ),
                                      ],
                                    )
                                  : Container();
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            // await selectImage(ImageSource.gallery, listimg3);
                            try {
                              EasyLoading.show();
                              await selectImage3(
                                ImageSource.gallery,
                              );
                              // await upload_award(locImg2, locImgList2);
                              locImgList3.add(await upload_award(locImg3));
                              setState(() {});
                              EasyLoading.dismiss();
                            } on FirebaseException catch (e) {
                              EasyLoading.dismiss();
                              Get.snackbar("Error", e.message.toString());
                              print(e.toString());
                            } catch (e) {
                              EasyLoading.dismiss();
                              print(e.toString());
                            }
                          },
                          child: Container(
                            width: res_width * 0.2,
                            height: res_width * 0.2,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add_outlined,
                                color: Colors.white,
                                size: 33,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              // : Container(),
              ,
              // locat4
              //     ?
              Visibility(
                visible: isvisible2,
                child: Container(
                  width: res_width * 0.9,
                  child: TextFormField(
                    controller: location4,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Location 4",
                        fillColor: Colors.white),
                  ),
                ),
              )
              // : Container(),
              // locat4
              //     ?
              ,
              Visibility(
                visible: isvisible2,
                child: SizedBox(
                  height: res_height * 0.015,
                ),
              )
              //     : Container(),
              // locat4
              // ?
              ,
              Visibility(
                visible: isvisible2,
                child: Container(
                  width: res_width * 0.9,
                  child: Text(
                    'Upload image of polling location',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              )
              //     : Container(),
              // locat4
              // ?
              ,
              Visibility(
                visible: isvisible2,
                child: SizedBox(
                  height: res_height * 0.015,
                ),
              )
              // : Container(),

              // locat4
              //     ?
              ,
              Visibility(
                visible: isvisible2,
                child: Container(
                  width: res_width * 0.9,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: 400,
                          height: 100,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: locImgList4.length,
                              itemBuilder: (context, index) {
                                return locImgList4[index] != null
                                    ? Stack(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: res_width * 0.25,
                                                height: res_width * 0.9,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(2.0, 2.0),
                                                      blurRadius: 2,
                                                      // spreadRadius: 10,
                                                      color: Colors.black26,
                                                    ),
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    locImgList4[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )),
                                          Positioned(
                                            right: 70,
                                            top: -11,
                                            child: IconButton(
                                                onPressed: () async {
                                                  try {
                                                    locImgList4.remove(
                                                        locImgList4[index]);
                                                    setState(() {});
                                                  } catch (e) {
                                                    print(e);
                                                  }

                                                  // setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ],
                                      )
                                    : Container();
                              }),
                        ),
                        GestureDetector(
                          onTap: () async {
                            // await selectImage(ImageSource.gallery, listimg4);
                            try {
                              EasyLoading.show();
                              await selectImage4(
                                ImageSource.gallery,
                              );
                              // await upload_award(locImg2, locImgList2);
                              locImgList4.add(await upload_award(locImg4));
                              setState(() {});
                              EasyLoading.dismiss();
                            } on FirebaseException catch (e) {
                              EasyLoading.dismiss();
                              Get.snackbar("Error", e.message.toString());
                              print(e.toString());
                            } catch (e) {
                              EasyLoading.dismiss();
                              print(e.toString());
                            }
                          },
                          child: Container(
                            width: res_width * 0.2,
                            height: res_width * 0.2,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add_outlined,
                                color: Colors.white,
                                size: 33,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              // : Container(),

              ,
              GestureDetector(
                onTap: () async {
                  // await uploadimg(listimg);

                  setState(() {
                    // locat3 = true;
                    // locat4 = true;
                    // isvisible = !isvisible;
                  });
                  // isvisible == true ? isvisible2 = !isvisible2 : isvisible;

                  if (isvisible == false) {
                    isvisible = true;
                  } else if (isvisible2 == false) {
                    // isvisible = true;

                    isvisible2 = true;
                  }
                  //  else if (isvisible == true && isvisible2 == false) {
                  //   isvisible == false;
                  // }
                  else if (isvisible2 == true && isvisible == true) {
                    isvisible = false;
                    isvisible2 = false;
                  }

                  print("is visible 1 $isvisible");
                  print("is visible 2 $isvisible2");
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
                      isvisible2 == true && isvisible == true
                          ? "Remove Location"
                          : 'Add Another Location',
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
                          // ElevatedButton(
                          //     onPressed: () async {
                          //       print("object");

                          // var start  =   await showDatePicker(
                          //       context: context,
                          //       initialDate: DateTime.now(),
                          //       firstDate: DateTime(2000),
                          //       lastDate: DateTime(2025),
                          //     );
                          //     },
                          //     child: Text("data")),
                          GestureDetector(
                            onTap: () async {
                              start = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025),
                              );
                              startDate.text =
                                  "${start?.toLocal()}".split(' ')[0];
                            },
                            child: TextFormField(
                              enabled: false,
                              controller: startDate,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.black),
                                  hintText: "$date",
                                  fillColor: Colors.white),
                            ),
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
                          GestureDetector(
                            onTap: () async {
                              end = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                              );
                              endDate.text = "${end?.toLocal()}".split(' ')[0];
                            },
                            child: TextFormField(
                              enabled: false,
                              controller: endDate,
                              decoration: InputDecoration(
                                  // enabled: false,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.black),
                                  hintText: "02-02-02",
                                  fillColor: Colors.white),
                            ),
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
              // SizedBox(
              //   height: res_height * 0.015,
              // ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: fbLinksControl.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: Get.width * 0.05),
                      child: Container(
                        width: res_width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "${fbLinksControl[index]}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      fbLinksControl
                                          .remove(fbLinksControl[index]);
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.remove_circle))
                              ],
                            )),
                      ),
                    );
                  }),
              // ListView.builder(
              //     shrinkWrap: true,
              //     physics: ScrollPhysics(),
              //     itemCount: fbitemCount,
              //     itemBuilder: (context, index) {
              //       _controllers.add(new TextEditingController());
              //       return Padding(
              //           padding: EdgeInsets.symmetric(
              //               vertical: 4.0, horizontal: Get.width * 0.05),
              //           child:
              //               // Container(
              //               // width: res_width * 0.9,
              //               // decoration: BoxDecoration(
              //               //     color: Colors.white,
              //               //     borderRadius:
              //               //         BorderRadius.all(Radius.circular(10))),
              //               //   child: Padding(
              //               //     padding: const EdgeInsets.all(8.0),
              //               //     child: Wrap(
              //               //       direction: Axis.horizontal,
              //               //       children: [
              //               //         Icon(
              //               //           Icons.facebook_outlined,
              //               // color: kPrimaryColor,
              //               // size: 40,
              //               //         ),
              //               //         SizedBox(
              //               //           width: 10,
              //               //         ),
              //               //         Container(
              //               //           height: res_height * 0.04,
              //               //           width: 1,
              //               //           color: Colors.grey,
              //               //         ),
              //               //         SizedBox(
              //               //           width: 10,
              //               //         ),

              //               //         // Text(
              //               //         //   'https://www.facebook.com',
              //               //         //   style: TextStyle(
              //               //         //       color: Colors.black, fontSize: 16),
              //               //         // )
              //               //       ],
              //               //     ),
              //               //   ),
              //               // ),
              Container(
                width: res_width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextField(
                  controller: _controllers,
                  // controller: _controllers.add( _controllers2,),
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Image.asset("assets/slicing/yt.png"),
                    ),
                    hintText: 'https://www.youtube.com',
                  ),
                ),
              ),
              //           ));
              //     }),
              SizedBox(
                height: res_height * 0.015,
              ),
              GestureDetector(
                onTap: () {
                  // print(_controllers[0].text);
                  // print(_controllers[1].text);
                  // for (var i = 0; i <= _controllers.length; i++) {
                  //   print(_controllers[i].text);
                  // }
                  // print(_controllers.toList());
                  if (_controllers.text.length > 0) {
                    fbLinksControl.add(_controllers.text);
                    _controllers.clear();
                    setState(() {});
                  }
                  // _controllers.forEach((element) {
                  //   fbLinksControl.add(element.text.toString());
                  // });
                  // print(fbLinksControl);

                  // setState(() {
                  //   fbitemCount++;
                  // });
                },
                child: Container(
                  width: res_width * 0.9,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Link",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.add_outlined,
                          color: Colors.white,
                          size: 17,
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    // if (urls1.isEmpty &&
                    //     urls2.isEmpty &&
                    //     urls3.isEmpty &&
                    //     urls4.isEmpty) {
                    //   await uploadimg(listimg2, urls2);
                    //   await uploadimg(listimg3, urls3);
                    //   await uploadimg(listimg4, urls4);
                    // }

                    print(urls1.toString() + "sadasdasda");
                    // }
                    // if (listimg2.isNotEmpty) {

                    // // }
                    // // if (listimg2.isNotEmpty) {
                    // if (listimg.isEmpty || listimg2.isEmpty) {
                    //   Get.snackbar("Error", "Please add 2 locations ");
                    // }
                    //  else if (listimg3.isEmpty && isvisible == true) {
                    //   Get.snackbar("Error", "Please add All 3 locations");

                    await uploadData();
                  } on FirebaseException catch (e) {
                    print(e);
                    Get.snackbar("Error", e.message.toString());
                  }

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
