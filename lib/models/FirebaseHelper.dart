// import 'package:chat_app/models/UserModel.dart';
// import 'package:chat_app/models/firebase_service.dart';
import 'package:anrear/helper/helper.dart';
import 'package:anrear/models/usermodels.dart';
import 'package:anrear/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static Future<UserModel?> getUserModelById(String uid) async {
    UserModel? userModel;

    // DocumentSnapshot docSnap =
    //     await FirebaseFirestore.instance.collection("users").doc(uid).get();
    DocumentSnapshot docSnap = await firestore_get("$UserType", uid);

    if (docSnap.data() != null) {
      userModel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return userModel;
  }
}
