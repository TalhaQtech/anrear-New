import 'dart:typed_data';

import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/main.dart';
import 'package:anrear/models/usermodels.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:anrear/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';

class Edit_Artist_profile extends StatefulWidget {
  // final User? firebaseUser;
  final UserModel? userModel;
  const Edit_Artist_profile({Key? key, this.userModel}) : super(key: key);

  @override
  State<Edit_Artist_profile> createState() => _Edit_Artist_profileState();
}

class _Edit_Artist_profileState extends State<Edit_Artist_profile> {
  UploadTask? uploadTask;
  Uint8List? image;
  Uint8List? image2;

  String? artist_Profile_Image = "";

  var start;

  List musicCategorie = [];
  void selectImage(ImageSource source) async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      image2 = im;
      // listimg.add(im);
      // print(listimg.length);
    });
  }

  var awardWinning;
  selectImage2(
    ImageSource source,
  ) async {
    print(0);
    Uint8List im = await pickImage(ImageSource.gallery);

    if (im.isNotEmpty) {
      print(im);

      image = im;
    }
  }

  int r = 1;
  upload_award() async {
    r++;
    if (image != null) {
      print(1);
      UploadTask uploadTask =
          FirebaseStorage.instance.ref("awardimg").putData(image!);
      // currentUserData.award.add(await uploadTask.snapshot.ref.getDownloadURL());
      print(await uploadTask.snapshot.ref.getDownloadURL());
      var awardlink = (await uploadTask.snapshot.ref.getDownloadURL());
      print(2);

      await firestore_update("artist", "$globalUserid", {
        "award": FieldValue.arrayUnion([awardlink])
      });
      print(3);
    } else {
      print(null);
    }
  }

  // List listimg = [];
  late var Nationality =
      TextEditingController(text: widget.userModel!.Nationality);
  late var Dob = TextEditingController(text: widget.userModel!.dob);

  late var Description =
      TextEditingController(text: widget.userModel!.description);
  late var fullName = TextEditingController(text: widget.userModel!.fullName);
  // var urls1 = [];
  List text = [];
  List award = [];
  TextEditingController _controller = TextEditingController();
  uploadData() async {
    try {
      EasyLoading.show();
      print("talha");
      widget.userModel?.userImage = image2 != null
          ? artist_Profile_Image.toString()
          : currentUserData.userImage;
      widget.userModel?.Nationality = Nationality.text.toString().trim();
      widget.userModel?.description = Description.text.trim().toString();
      widget.userModel?.dob = Dob.text.trim();
      widget.userModel?.fullName = fullName.text.trim();
      widget.userModel?.singup_step = 2;
      widget.userModel?.award = award;
      widget.userModel?.links = _controller.text.length > 0 && text.isEmpty
          ? [_controller.text.toString().trim()]
          : text;
      // if (text.isNotEmpty) widget.userModel?.links = text;
      widget.userModel?.musicCategorie = musicCategorie;
      print("shakeel");

      print(widget.userModel);
      await firestore_set(
              "artist", widget.userModel!.uid, widget.userModel!.toMap())
          .then((value) {
        Get.to(() => HomeMainScreen(
              userModel: widget.userModel,
            ));
        // Get.to(CreatePollingScreen(
        //     userModel: widget.userModel, firebaseUser: widget.firebaseUser));
      });
      EasyLoading.dismiss();
    } on FirebaseException catch (e) {
      EasyLoading.dismiss();
      print(e.toString());
      Get.snackbar("Warning", e.message.toString());
    } catch (e) {
      EasyLoading.dismiss();
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    musicCategorie = currentUserData.musicCategorie;
    text = currentUserData.links;

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
                'Edit Profile',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              GestureDetector(
                onTap: () async {
                  EasyLoading.show();
                  selectImage(ImageSource.gallery);
                  EasyLoading.dismiss();

                  // setState(() {});
                },
                child: image2 == null
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
                        ],
                      )
                    : Container(
                        width: res_width * 0.35,
                        height: res_width * 0.35,
                        decoration: BoxDecoration(
                          // color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: MemoryImage(image2!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 4.0,
                          ),
                        ),
                        // child: Image.memory(
                        //   image!,
                        //   fit: BoxFit.cover,
                        // ),
                      ),
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
                      hintText: "Full Name",
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: TextFormField(
                  controller: Nationality,
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
              GestureDetector(
                onTap: () async {
                  // selectImage(ImageSource.gallery);
                  start = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1947),
                    lastDate: DateTime.now(),
                  );
                  // print("object");
                  // print(start > DateTime.now());
                  // print(2);
                  Dob.text = "${start!.toLocal()}".split(' ')[0];
                },
                child: Container(
                  width: res_width * 0.9,
                  child: TextFormField(
                    enabled: false,
                    onTap: () async {
                      // if (urls1.isEmpty &&
                      //     urls2.isEmpty &&
                      //     urls3.isEmpty &&
                      //     urls4.isEmpty) {
                      //   await uploadimg(listimg, urls1);
                      //   await uploadimg(listimg2, urls2);
                      //   await uploadimg(listimg3, urls3);
                      //   await uploadimg(listimg4, urls4);
                      // }

                      // start = await showDatePicker(
                      //   context: context,
                      //   initialDate: DateTime.now(),
                      //   firstDate: DateTime(1947),
                      //   lastDate: DateTime.now(),
                      // );
                      // // print("object");
                      // // print(start > DateTime.now());
                      // // print(2);
                      // Dob.text = "${start!.toLocal()}".split(' ')[0];
                    },
                    controller: Dob,
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
              ),
              SizedBox(
                height: res_height * 0.015,
              ),
              Container(
                width: res_width * 0.9,
                child: TextFormField(
                  controller: Description,
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //     height: 100,
                      //     child:
                      // StreamBuilder<QuerySnapshot>(
                      // stream: FirebaseFirestore.instance
                      //     .collection("artist")
                      //     .where(
                      //       "uid",
                      //       isEqualTo: globalUserid,
                      //     )
                      //     // .where("uid",
                      //     //     isNotEqualTo: globalUserid)
                      //     .snapshots(),
                      // builder: (BuildContext context,
                      //     AsyncSnapshot<QuerySnapshot> snapshot) {
                      //   {
                      //             return ListView.builder(
                      //                 shrinkWrap: true,
                      //                 scrollDirection: Axis.horizontal,
                      //                 itemCount: snapshot.data?.docs.length,
                      //                 itemBuilder: (context, index) {
                      //                   return ListView.builder(
                      //                     shrinkWrap: true,
                      //                     scrollDirection: Axis.horizontal,
                      //                     itemCount:
                      //                         widget.userModel!.award!.length,
                      //                     itemBuilder: (context, index) {
                      //                       return widget.userModel?.award !=
                      //                               null

                      //                           : Container();
                      //                     },
                      //                   );
                      //                 });
                      //           }
                      //         })),
                      Container(
                        height: 100,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("artist")
                                .where(
                                  "uid",
                                  isEqualTo: globalUserid,
                                )
                                // .where("uid",
                                //     isNotEqualTo: globalUserid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      // print(snapshot
                                      //     .data!.docs[index]["award"].length);
                                      {
                                        award =
                                            snapshot.data!.docs[index]["award"];
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: award.length,
                                            itemBuilder: (context, index) {
                                              return Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: res_width * 0.25,
                                                      height: res_width * 0.9,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset: Offset(
                                                                2.0, 2.0),
                                                            blurRadius: 2,
                                                            // spreadRadius: 10,
                                                            color:
                                                                Colors.black26,
                                                          ),
                                                        ],
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.network(
                                                          award[index],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    // bottom: 0,
                                                    right: 70,
                                                    top: -11,
                                                    // left: ,
                                                    child: IconButton(
                                                        onPressed: () async {
                                                          try {
                                                            EasyLoading.show();
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "artist")
                                                                .doc(
                                                                    globalUserid)
                                                                .update({
                                                              "award": FieldValue
                                                                  .arrayRemove([
                                                                award[index]
                                                              ])
                                                            });
                                                            EasyLoading
                                                                .dismiss();
                                                          } catch (e) {
                                                            EasyLoading
                                                                .dismiss();

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
                                              );

                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                    "${award[index]}"),
                                              );
                                            });
                                      }
                                    });
                              }
                              return Container();
                            }),
                      ),

                      GestureDetector(
                        onTap: () async {
                          // selectImage(ImageSource.gallery);
                          try {
                            EasyLoading.show();
                            await selectImage2(
                              ImageSource.gallery,
                            );
                            //     .then((val) async {
                            //   await upload_award();
                            // });
                            await upload_award();
                            EasyLoading.dismiss();
                          } on FirebaseException catch (e) {
                            EasyLoading.dismiss();

                            Get.snackbar("Error", e.message.toString());
                            print(e.toString());
                          } catch (e) {
                            EasyLoading.dismiss();

                            print(e.toString());
                          }

                          // if (listimg.isEmpty) {
                          //   await uploadimg(listimg);
                          // }
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
                      musicCat(res_width, "Pop"),
                      musicCat(res_width, "Hip-Hop"),
                      musicCat(res_width, "Rock"),

                      // Container(
                      //   width: res_width * 0.35,
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(15)),
                      //   child: Center(
                      //       child: Padding(
                      //     padding: const EdgeInsets.all(18.0),
                      //     child: Text(
                      //       'Hip-Hop',
                      //       style: TextStyle(
                      //           color: kPrimaryColor,
                      //           fontWeight: FontWeight.normal,
                      //           fontSize: 17),
                      //     ),
                      //   )),
                      // ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // Container(
                      //   width: res_width * 0.35,
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(15)),
                      //   child: Center(
                      //       child: Padding(
                      //     padding: const EdgeInsets.all(18.0),
                      //     child: Text(
                      //       'Rock',
                      //       style: TextStyle(
                      //           color: kPrimaryColor,
                      //           fontWeight: FontWeight.normal,
                      //           fontSize: 17),
                      //     ),
                      //   )),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: res_height * 0.04,
              ),
              GestureDetector(
                onTap: () async {},
                child: Container(
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
              ),
              // SizedBox(
              //   height: res_height * 0.015,
              // ),
              Container(
                // height: 100,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: text.length,
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
                                    "${text[index]}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        text.remove(text[index]);
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.remove_circle))
                                ],
                              )
                              // Row(
                              //   children: [
                              // Icon(
                              //   Icons.facebook_outlined,
                              //   color: kPrimaryColor,
                              //   size: 40,
                              // // ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              // Container(
                              //   height: res_height * 0.04,
                              //   width: 1,
                              //   color: Colors.grey,
                              // ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),

                              //   ],
                              // ),
                              ),
                        ),
                      );
                    }),
              ),
              Container(
                  width: res_width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: "https://www.youtube.com"),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ))),
              SizedBox(
                height: res_height * 0.015,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  print("object");
                  // Get.to(() => ForgotScreen());

                  if (_controller.text.length > 0) {
                    text.add(_controller.text);
                    _controller.clear();
                    setState(() {});
                  }
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
                          "Add link",
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
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  try {
                    EasyLoading.show();
                    print(5);
                    if (image2 != null) {
                      uploadTask = FirebaseStorage.instance
                          .ref("profilepictures")
                          .child(widget.userModel!.uid.toString())
                          .putData(image2!);
                      TaskSnapshot? snapshot = await uploadTask;

                      artist_Profile_Image =
                          await snapshot!.ref.getDownloadURL();
                    }
                    await uploadData();
                    EasyLoading.dismiss();
                  } on FirebaseException catch (e) {
                    EasyLoading.dismiss();
                    Get.snackbar("Error", "${e.message}");
                    print(e);
                  } catch (e) {
                    print(e);
                  }

                  // await uploadData();
                  // Get.to(() => CreatePollingScreen());
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

  // String musicCategorie = "";
  GestureDetector musicCat(double res_width, txt) {
    return GestureDetector(
      onTap: () async {
        // print(txt);
        // musicCategorie = txt;
        // musicCategorie.
        // musicCategorie.contains(currentUserData.musicCategorie);
        // print(currentUserData.musicCategorie);
        // musicCategorie = currentUserData.musicCategorie;
        setState(() {});
        if (!musicCategorie.contains(txt))
          musicCategorie.add(txt);
        else {
          musicCategorie.remove(txt);
        }
        // l.remove(txt);
        print(musicCategorie);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          width: res_width * 0.4,
          decoration: BoxDecoration(
              color:
                  musicCategorie.contains(txt) ? kPrimaryColor : Colors.white,
              borderRadius: BorderRadius.circular(6)),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              '$txt',
              style: TextStyle(
                  color: musicCategorie.contains(txt)
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 17),
            ),
          )),
        ),
      ),
    );
  }
}
