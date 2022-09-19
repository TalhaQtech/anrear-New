import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/models/FirebaseHelper.dart';
import 'package:anrear/models/usermodels.dart';
import 'package:anrear/screens/auth/create_profile.dart';
import 'package:anrear/screens/auth/login.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:anrear/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    // print('run');
    // Timer(Duration(seco
    //nds: 2), () => Get.to(() => HomeMainScreen()));
  }

  var Password = TextEditingController();
  TextEditingController email = TextEditingController();
  var formkey = GlobalKey<FormState>();

  var phone = TextEditingController();

  var fullName = TextEditingController();

  var confirmPassword = TextEditingController();

  usersingup() async {
    try {
      EasyLoading.show();
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: Password.text.trim());
      UserModel newUser = UserModel(
          time: Timestamp.now(),
          musicCategorie: [],
          links: [],
          award: [],
          userType: UserType,
          Nationality: "",
          description: "",
          dob: "",
          password: Password.text.trim(),
          uid: credential.user!.uid,
          fullName: fullName.text.trim(),
          userEmail: email.text.trim(),
          userImage: "",
          singup_step: 1,
          userPhone: phone.text.trim());
      await firestore_set("user", credential.user!.uid, newUser.toMap())
          .then((value) async {
        print("New User Created!");
        UserCredential user = await auth.signInWithEmailAndPassword(
            email: newUser.userEmail.toString().trim(),
            password: newUser.password.toString().trim());
        globalUserid = user.user!.uid;
        // print(currentUser!.uid);
        // if (currentUser != null) {
        // Logged In
        currentUserData =
            await FirebaseHelper.getUserModelById(globalUserid.toString());
        print("New User Created! and login");
        print(currentUserData.fullName);
        Get.to(HomeMainScreen(
          userModel: currentUserData,
        ));
      });
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

      print(e.message);
      Get.snackbar("Warning", e.message.toString());
    } catch (e) {
      EasyLoading.dismiss();

      print(e.toString());
    }
  }

  signup() async {
    UserCredential? credential;

    try {
      EasyLoading.show();

      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: Password.text.trim());
      globalUserid = credential.user!.uid;
      UserModel newUser = UserModel(
          time: Timestamp.now(),
          musicCategorie: [],
          links: [],
          award: [],
          userType: UserType,
          Nationality: "",
          description: "",
          dob: "",
          password: Password.text.trim(),
          uid: credential.user!.uid,
          fullName: fullName.text.trim(),
          userEmail: email.text.trim(),
          userImage: "",
          singup_step: 1,
          userPhone: phone.text.trim());
      await firestore_set("artist", globalUserid, newUser.toMap())
          .then((value) async {
        print("New User Created!");
        UserCredential user = await auth.signInWithEmailAndPassword(
            email: newUser.userEmail.toString().trim(),
            password: newUser.password.toString().trim());
        globalUserid = user.user!.uid;
        // print(currentUser!.uid);
        // if (currentUser != null) {
        // Logged In
        currentUserData = await FirebaseHelper.getUserModelById(user.user!.uid);
        print("New User Created! and login");
        Get.to(CreateProfileScreen(
            userModel: currentUserData, firebaseUser: credential!.user!));
      });

      EasyLoading.dismiss();
      // Get.to(() => CreateProfileScreen());
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

      print(e.message);
      Get.snackbar("Warning", e.message.toString());
    } catch (e) {
      EasyLoading.dismiss();

      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: res_height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/slicing/Bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
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
                  height: res_height * 0.04,
                ),
                Text(
                  'Signup',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  child: TextFormField(
                    validator: (val) => val!.isEmpty ? "Field Required" : null,
                    controller: fullName,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
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
                    validator: (val) => val!.isEmpty || !val.contains("@")
                        ? "Enter a valid eamil"
                        : null,
                    controller: email,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Email Address",
                        fillColor: Colors.white),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only
                    validator: (val) => val!.isEmpty ? "Field Required" : null,
                    controller: phone,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Phone Number",
                        fillColor: Colors.white),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    validator: (val) => val!.isEmpty ? "Field Required" : null,
                    controller: Password,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            // color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Password",
                        fillColor: Colors.white),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                Container(
                  width: res_width * 0.9,
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    controller: confirmPassword,
                    validator: (validator) {
                      if (validator!.isEmpty) return 'Field Required';
                      if (validator != Password.text)
                        return 'The passwords do not match';
                      return null;
                    },
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Confirm Password",
                        fillColor: Colors.white),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    if (UserType == "artist") {
                      if (formkey.currentState!.validate()) await signup();
                      // Get.to(() => CreateProfileScreen());
                    } else {
                      if (formkey.currentState!.validate()) await usersingup();
                      // Get.to(() => HomeMainScreen());
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
                      child: Text(
                        'Signup',
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
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.to(() => LoginScreen());
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ? ",
                            style: TextStyle(
                                // decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            'Signin',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: res_height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
