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
  var firebaseUser;
  CreatePollingScreen({Key? key, this.userModel, this.firebaseUser})
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
  List fbLinksControl = [];

  var fbitemCount = 1;
  TextEditingController _controllers = TextEditingController();

  var location3 = TextEditingController();

  var isvisible = false;

  var location4 = TextEditingController();

  DateTime? start;

  DateTime? end;

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
            youtubeurls: fbLinksControl,
            location3: location3.text.trim(),
            location4: location4.text.trim(),
            polling_location_im3: urls3,
            polling_location_im4: urls4,
            polling_location_im2: urls2,
            polling_location_im: urls1,
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

  uploadimg(listOfimg, imagesUrls) {
    listOfimg.forEach((listOfimg) async {
      print(listOfimg);
      try {
        EasyLoading.show();
        UploadTask uploadTask = FirebaseStorage.instance
            .ref("testimg")
            .child(uuid.v1().toString())
            .putData(listOfimg!);
        TaskSnapshot? snapshot = await uploadTask;
        // print(await uploadTask.snapshot.ref.getDownloadURL());
        // imagesUrls.add(await (await uploadTask).ref.getDownloadURL());
        imagesUrls.add(await uploadTask.snapshot.ref.getDownloadURL());
        // print(snapshot.ref.getDownloadURL());
        EasyLoading.dismiss();
      } catch (e) {
        EasyLoading.dismiss();

        print(e);
      }
    });
    print(imagesUrls);
    return imagesUrls;
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
                          itemCount: listimg.length,
                          itemBuilder: (context, index) {
                            print(listimg[index]);
                            return listimg[index] != null
                                ? Padding(
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
                                        child: Image.memory(
                                          listimg[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await selectImage(ImageSource.gallery, listimg);
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
                          itemCount: listimg2.length,
                          itemBuilder: (context, index) {
                            return listimg2[index] != null
                                ? Padding(
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
                                        child: Image.memory(
                                          listimg2[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await selectImage(ImageSource.gallery, listimg2);
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
                            itemCount: listimg3.length,
                            itemBuilder: (context, index) {
                              return listimg3[index] != null
                                  ? Padding(
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
                                          child: Image.memory(
                                            listimg3[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container();
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await selectImage(ImageSource.gallery, listimg3);
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
                visible: isvisible,
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
                visible: isvisible,
                child: SizedBox(
                  height: res_height * 0.015,
                ),
              )
              //     : Container(),
              // locat4
              // ?
              ,
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
              //     : Container(),
              // locat4
              // ?
              ,
              Visibility(
                visible: isvisible,
                child: SizedBox(
                  height: res_height * 0.015,
                ),
              )
              // : Container(),

              // locat4
              //     ?
              ,
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
                              itemCount: listimg4.length,
                              itemBuilder: (context, index) {
                                return listimg4[index] != null
                                    ? Padding(
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
                                            child: Image.memory(
                                              listimg4[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ))
                                    : Container();
                              }),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await selectImage(ImageSource.gallery, listimg4);
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
                  if (urls1.isEmpty &&
                      urls2.isEmpty &&
                      urls3.isEmpty &&
                      urls4.isEmpty) {
                    await uploadimg(listimg, urls1);
                    await uploadimg(listimg2, urls2);
                    await uploadimg(listimg3, urls3);
                    await uploadimg(listimg4, urls4);
                  }
                  setState(() {
                    // locat3 = true;
                    // locat4 = true;
                    isvisible = !isvisible;
                  });
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
                      'Add Another Location',
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
                              if (urls1.isEmpty &&
                                  urls2.isEmpty &&
                                  urls3.isEmpty &&
                                  urls4.isEmpty) {
                                await uploadimg(listimg, urls1);
                                await uploadimg(listimg2, urls2);
                                await uploadimg(listimg3, urls3);
                                await uploadimg(listimg4, urls4);
                              }

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
                              if (urls1 == null) {
                                urls1 = await uploadimg(listimg, urls1);
                                print(urls1.toString() + "sadasdasda");
                                // }
                                // if (listimg2.isNotEmpty) {
                                urls2 = await uploadimg(listimg2, urls2);
                                urls3 = await uploadimg(listimg3, urls3);
                                // // }
                                // // if (listimg2.isNotEmpty) {
                                urls4 = await uploadimg(listimg4, urls4);
                              }

                              end = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                              );
                              endDate.text = "${end!.toLocal()}".split(' ')[0];
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
                    if (urls1.isEmpty &&
                        urls2.isEmpty &&
                        urls3.isEmpty &&
                        urls4.isEmpty) {
                      await uploadimg(listimg, urls1);
                      await uploadimg(listimg2, urls2);
                      await uploadimg(listimg3, urls3);
                      await uploadimg(listimg4, urls4);
                    }

                    print(urls1.toString() + "sadasdasda");
                    // }
                    // if (listimg2.isNotEmpty) {

                    // // }
                    // // if (listimg2.isNotEmpty) {
                    if (listimg.isEmpty ||
                        listimg2.isEmpty ||
                        listimg3.isEmpty ||
                        listimg4.isEmpty) {
                      Get.snackbar("Error", "Please add All 4 locations");
                    } else {
                      await uploadData();
                    }
                  } catch (e) {
                    print(e);
                    Get.snackbar("Error", e.toString());
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
