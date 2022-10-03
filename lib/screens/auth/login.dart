import 'package:anrear/helper/colors.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/models/FirebaseHelper.dart';
import 'package:anrear/models/usermodels.dart';
import 'package:anrear/screens/auth/create_profile.dart';
import 'package:anrear/screens/auth/forgot.dart';
import 'package:anrear/screens/auth/signup.dart';
import 'package:anrear/screens/home/homemain.dart';
import 'package:anrear/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    double res_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: res_height,
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
                        currentUserData = null;
                        currentUserData = await FirebaseHelper.getUserModelById(
                            user.user!.uid);
                        print(1);
                        print(currentUserData.singup_step);
                        // currentUserData = thisUserModel;
                        if (currentUserData.singup_step == 2) {
                          Get.to(() => HomeMainScreen(
                                userModel: currentUserData,
                              ));
                        } else if (currentUserData.singup_step == 1) {
                          Get.to(() => CreateProfileScreen(
                                firebaseUser: user.user!,
                                userModel: currentUserData,
                              ));
                        } else {
                          Get.to(() => HomeMainScreen(
                                userModel: currentUserData,
                              ));
                        }
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
                      GestureDetector(
                        onTap: () async {
                          try {
                            EasyLoading.show();
                            print(1);
                            await signInWithGoogle().then((value) async {
                              // print(value.toString());
                              print(2);
                              if (value.additionalUserInfo!.isNewUser) {
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
                                    uid: value.user!.uid,
                                    fullName: value.additionalUserInfo!
                                        .profile!["family_name"]
                                        .toString()
                                        .trim(),
                                    userEmail:
                                        value.user!.email.toString().trim(),
                                    userImage: "${value.user!.photoURL}",
                                    singup_step: UserType == "user" ? 0 : 1,
                                    userPhone: value.user!.phoneNumber
                                        .toString()
                                        .trim());
                                await firestore_set("$UserType",
                                    value.user!.uid, newUser.toMap());
                                currentUserData = newUser;
                                // print(currentUserData.singup_step + "asdas");
                                print(3);
                              } else {
                                print(4);
                                var data = await firestore_get(
                                    "${UserType}", "${value.user!.uid}");
                                print(5);
                                currentUserData =
                                    await FirebaseHelper.getUserModelById(
                                        value.user!.uid);
                              }

                              if (currentUserData.singup_step == 2) {
                                print(6);
                                Get.to(() => HomeMainScreen(
                                      userModel: currentUserData,
                                    ));
                              } else if (currentUserData.singup_step == 1) {
                                print(7);
                                Get.to(() => CreateProfileScreen(
                                      firebaseUser: value.user!,
                                      userModel: currentUserData,
                                    ));
                              } else if (currentUserData.singup_step == 0) {
                                print(8);
                                Get.to(() => HomeMainScreen(
                                      userModel: currentUserData,
                                    ));
                              }

                              // if (UserType == "user") {
                              //   Get.to(() => HomeMainScreen(
                              //         userModel: currentUserData,
                              //       ));
                              // }
                              // Get.to(CreateProfileScreen(
                              //   userModel: newUser,
                              //   firebaseUser: value.user!,
                              // ));
                              // print(value
                              //     .additionalUserInfo!.profile!["family_name"]);
                            });
                            EasyLoading.dismiss();
                          } on FirebaseException catch (e) {
                            EasyLoading.dismiss();
                            Get.snackbar("Warning", e.message.toString());
                          } catch (e) {
                            EasyLoading.dismiss();
                            print(e);
                          }

                          print("object");
                        },
                        child: Container(
                            width: res_width * 0.15,
                            child: Image.asset('assets/slicing/googlr.png')),
                      ),
                      Container(
                          width: res_width * 0.15,
                          child: Image.asset('assets/slicing/apple.png'))
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
