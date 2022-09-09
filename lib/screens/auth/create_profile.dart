import 'dart:typed_data';

import 'package:anrear/helper/colors.dart';
import 'package:anrear/main.dart';
import 'package:anrear/models/usermodels.dart';
import 'package:anrear/screens/auth/create_polling_screen.dart';
import 'package:anrear/screens/auth/forgot.dart';
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

  String? imageUrl;
  void selectImage(ImageSource source) async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
      // listimg.add(im);
      // print(listimg.length);
    });
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

  uploadData() async {
    if (Nationality.text == "" ||
        Dob.text == "" ||
        Description.text == "" ||
        fullName.text == "" ||
        image == null) {
      Get.snackbar("Incomplete Data", "Please fill all the fields");
    } else {
      try {
        EasyLoading.show();

        widget.userModel!.award = imagesUrls;
        widget.userModel!.userImage = imageUrl.toString();
        widget.userModel?.Nationality = Nationality.text.toString().trim();
        widget.userModel?.description = Description.text.trim().toString();
        widget.userModel?.dob = Dob.text.trim();
        widget.userModel?.fullName = fullName.text.trim();
        widget.userModel?.singup_step = 2;
        await firestore_set(
                "artist", widget.userModel!.uid, widget.userModel!.toMap())
            .then((value) {
          Get.to(CreatePollingScreen(
              userModel: widget.userModel, firebaseUser: widget.firebaseUser));
        });
        EasyLoading.dismiss();
      } catch (e) {
        EasyLoading.dismiss();
        print(e.toString());
        Get.snackbar("Error", e.toString());
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
                  selectImage(ImageSource.gallery);
                  if (listimg.isEmpty) {
                    await uploadimg(listimg);
                  }
                  // setState(() {});
                },
                child: image == null
                    ? Container(
                        width: res_width * 0.35,
                        height: res_width * 0.35,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: DecorationImage(
                            image: AssetImage("assets/slicing/girl.jpeg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          border: Border.all(
                            color: kPrimaryColor,
                            width: 4.0,
                          ),
                        ),
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
              Container(
                width: res_width * 0.9,
                child: TextFormField(
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
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: res_width * 0.2,
                                      height: res_width * 0.2,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(13))),
                                      child: Image.memory(
                                        listimg[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // selectImage(ImageSource.gallery);
                          await selectImage2(ImageSource.gallery, listimg);
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
                onTap: () async {
                  if(listimg.isNotEmpty){
                    Get.snackbar("Error", "Please select award winnigs ");
                  }
                  if (imagesUrls.isEmpty) {
                    await uploadimg(listimg);
                  }
                  print(imagesUrls.toString() + "asdas");
                  if (image != null)
                    uploadTask = FirebaseStorage.instance
                        .ref("profilepictures")
                        .child(widget.userModel!.uid.toString())
                        .putData(image!);
                  TaskSnapshot? snapshot = await uploadTask;

                  imageUrl = await snapshot!.ref.getDownloadURL();
                  await uploadData();
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
}
