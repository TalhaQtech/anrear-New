import 'dart:typed_data';

import 'package:anrear/helper/colors.dart';
import 'package:anrear/main.dart';
import 'package:anrear/models/usermodels.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:anrear/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileScreen extends StatefulWidget {
  final User? firebaseUser;
  final UserModel? userModel;
  const CreateProfileScreen({Key? key, this.firebaseUser, this.userModel})
      : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  UploadTask? uploadTask;
  Uint8List? image;
  List listimg = [];
  List listimg2 = [];
  List locImgList1 = [];

  String? imageUrl = "";

  var start;

  var locImg1 = [];

  selectImage1(
    ImageSource source,
  ) async {
    print(0);
    locImg1 = await pickImage(ImageSource.gallery);

    if (locImg1.isNotEmpty) {
      print(locImg1);
    }
  }

  void selectImage(ImageSource source) async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
      // listimg.add(im);
      // print(listimg.length);
    });
  }

  album_img_slect(
    ImageSource source,
  ) async {
    print(0);
    listimg2 = await pickImage(ImageSource.gallery);

    if (listimg2!.isNotEmpty) {
      print(listimg2);
    }
  }

  selectImage2(ImageSource source, listofimg) async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    if (im != null) {
      // print(im);
      setState(() {
        // image = im;
        listofimg.add(im);
        // listofimg = im;
        // print(listofimg.toString() + "asad");
      });
    }
  }

  List<String> imagesUrls = [];

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

  uploadimg(listOfimg) {
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
        print(imagesUrls);
      } catch (e) {
        EasyLoading.dismiss();

        print(e);
      }
    });
    print(imagesUrls);
    return imagesUrls;
  }

  @override
  void initState() {
    super.initState();
    // print('run');
    // Timer(Duration(seconds: 2), () => Get.to(() => HomeMainScreen()));
  }

  var Nationality = TextEditingController();
  var Dob = TextEditingController();
  var Description = TextEditingController();
  late var fullName = TextEditingController(text: widget.userModel!.fullName);
  // var urls1 = [];
  List text = [];
  TextEditingController _controller = TextEditingController();
  uploadData() async {
    if (Nationality.text == "" ||
        Dob.text == "" ||
        Description.text == "" ||
        fullName.text == "" ||
        image == null ||
        imageUrl == "") {
      print(2);
      Get.snackbar("Warning", "Please fill in all required fields ");
    } else if (musicCategorie.isEmpty) {
      Get.snackbar("Warning", "Please Select music categories");
    } else {
      try {
        EasyLoading.show();
        print("talha");
        widget.userModel!.award = imagesUrls;
        widget.userModel!.album = locImgList1;
        widget.userModel!.userImage = imageUrl.toString();
        widget.userModel?.Nationality = Nationality.text.toString().trim();
        widget.userModel?.description = Description.text.trim().toString();
        widget.userModel?.dob = Dob.text.trim();
        widget.userModel?.fullName = fullName.text.trim();
        widget.userModel?.singup_step = 2;
        widget.userModel?.links = _controller.text.length > 0 && text.isEmpty
            ? [_controller.text.toString().trim()]
            : text;
        if (text.isNotEmpty) widget.userModel?.links = text;
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
  }

  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () async {
            if (listimg.isEmpty) {
              await uploadimg(listimg);
            }
          },
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
                GestureDetector(
                  onTap: () async {
                    EasyLoading.show();
                    selectImage(ImageSource.gallery);
                    EasyLoading.dismiss();
                    if (listimg.isEmpty) {
                      EasyLoading.show();
                      await uploadimg(listimg);
                      EasyLoading.dismiss();
                    }
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
                          ],
                        )
                      : Container(
                          width: res_width * 0.35,
                          height: res_width * 0.35,
                          decoration: BoxDecoration(
                            // color: const Color(0xff7c94b6),
                            image: DecorationImage(
                              image: MemoryImage(image!),
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
                    Dob.text = "${start?.toLocal()}".split(' ')[0];
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
                        Container(
                          height: 100,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: listimg.length,
                            itemBuilder: (context, index) {
                              return listimg[index] != null
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
                                              child: Image.memory(
                                                listimg[index],
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
                                              onPressed: () {
                                                listimg[index];
                                                listimg.remove(listimg[index]);
                                                setState(() {});
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
                            // selectImage(ImageSource.gallery);
                            EasyLoading.show();
                            await selectImage2(ImageSource.gallery, listimg);
                            EasyLoading.dismiss();
                            if (listimg.isEmpty) {
                              await uploadimg(listimg);
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

                //new
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  child: Text(
                    'Albums',
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
                                                  locImgList1.remove(
                                                      locImgList1[index]);
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
                //new
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
                  onTap: () async {
                    if (listimg.isEmpty) {
                      await uploadimg(listimg);
                    }
                  },
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
                GestureDetector(
                  onTap: () async {
                    if (listimg.isEmpty) {
                      await uploadimg(listimg);
                    }
                  },
                  child: Container(
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
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    print("object");
                    // Get.to(() => ForgotScreen());
                    if (listimg.isEmpty) {
                      await uploadimg(listimg);
                    }
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
                    if (imagesUrls.isEmpty) {
                      print(3);
                      await uploadimg(listimg);
                      print(imagesUrls.toString() + "asdas");
                    }
                    if (image == null) {
                      print(4);

                      Get.snackbar("Error", "select user profile image");
                    } else if (listimg.isEmpty) {
                      print(6);

                      Get.snackbar("Error", "Please select award winnigs ");
                    } else {
                      try {
                        EasyLoading.show();
                        print(5);

                        uploadTask = FirebaseStorage.instance
                            .ref("profilepictures")
                            .child(widget.userModel!.uid.toString())
                            .putData(image!);
                        TaskSnapshot? snapshot = await uploadTask;

                        imageUrl = await snapshot!.ref.getDownloadURL();
                        await uploadData();
                        EasyLoading.dismiss();
                      } catch (e) {
                        EasyLoading.dismiss();
                        print(e);
                      }
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
      ),
    );
  }

  List musicCategorie = [];
  // String musicCategorie = "";
  GestureDetector musicCat(double res_width, txt) {
    return GestureDetector(
      onTap: () async {
        if (listimg.isEmpty) {
          await uploadimg(listimg);
        }
        // print(txt);
        // musicCategorie = txt;
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
