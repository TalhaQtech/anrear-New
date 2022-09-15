import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/models/FirebaseHelper.dart';
import 'package:anrear/screens/auth/forgot.dart';
import 'package:anrear/screens/auth/signup.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    // print('run');
    // Timer(Duration(seconds: 2), () => Get.to(() => HomeMainScreen()));
  }

  var Password = TextEditingController();
  var email = TextEditingController();
  var formkey = GlobalKey<FormState>();

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
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: res_height * 0.125,
                ),
                Hero(
                  tag: 'logoImage',
                  child: Container(
                      width: res_width * 0.4,
                      child: Image.asset('assets/slicing/logo.png')),
                ),
                SizedBox(
                  height: res_height * 0.05,
                ),
                Text(
                  'Login',
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
                    // validator: (val) => val!.isEmpty || !val.contains("@")
                    //     ? "Enter a valid emaill"
                    //     : null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field Required";
                      }
                      if (!value.contains("@")) {
                        return "Enter a valid emaill";
                      }
                      return null;
                    },
                    controller: email,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.email_outlined),
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
                    // validator: (value) {
                    validator: (val) => val!.isEmpty ? "Field Required" : null,
                    obscureText: !_passwordVisible,
                    controller: Password,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: "Password",
                        fillColor: Colors.white),
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
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ))),
                ),
                SizedBox(
                  height: res_height * 0.015,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    // if (UserType == "user") {
                    //   print(UserType);
                    //   UserCredential user =
                    //       await auth.signInWithEmailAndPassword(
                    //           email: email.text.trim(),
                    //           password: Password.text.trim());
                    //   print(user.user!.uid);
                    //   currentUserData =
                    //       await firestore_get("user", user.user!.uid);
                    //   print(currentUserData);
                    // }

                    // if (UserType == "artist") {
                    // if (email.text == "" || Password.text == "") {
                    //   Get.snackbar(
                    //       "Incomplete Data", "Please fill all the fields");
                    // } else {
                    if (formkey.currentState!.validate()) {
                      try {
                        EasyLoading.show();
                        UserCredential user =
                            await auth.signInWithEmailAndPassword(
                                email: email.text.trim(),
                                password: Password.text.trim());
                        // User? currentUser = await auth.currentUser;
                        globalUserid = user.user!.uid;
                        // print(currentUser!.uid);
                        // if (currentUser != null) {
                        // Logged In
                        currentUserData = await FirebaseHelper.getUserModelById(
                            user.user!.uid);
                        // currentUserData = thisUserModel;
                        Get.to(() => HomeMainScreen(
                              userModel: currentUserData,
                            ));
                        print(currentUserData!.fullName);
                        EasyLoading.dismiss();
                        // }
                      } on FirebaseAuthException catch (e) {
                        EasyLoading.dismiss();

                        print(e.message);
                        Get.snackbar("Warning", e.message.toString());
                      } catch (e) {
                        EasyLoading.dismiss();

                        print(e.toString());
                      }
                    }
                    // Get.to(() => HomeMainScreen());
                    // }
                    // }
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
                        'Login',
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
                Text(
                  'Login With',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: res_height * 0.02,
                ),
                Container(
                  width: res_width * 0.7,
                  height: 1,
                  color: Colors.white,
                ),
                SizedBox(
                  height: res_height * 0.02,
                ),
                Container(
                  width: res_width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: res_width * 0.15,
                          child: Image.asset('assets/slicing/fb.png')),
                      Container(
                          width: res_width * 0.15,
                          child: Image.asset('assets/slicing/googlr.png')),
                      Container(
                          width: res_width * 0.15,
                          child: Image.asset('assets/slicing/insta.png'))
                    ],
                  ),
                ),
                SizedBox(
                  height: res_height * 0.05,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.to(() => SignupScreen());
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ? ",
                            style: TextStyle(
                                // decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            'Signup',
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
                  height: res_height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
