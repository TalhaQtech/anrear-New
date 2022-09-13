import 'package:cloud_firestore/cloud_firestore.dart';

class performancePolingModel {
  var time;
  String? uid;
  String? location;
  String? location2;
  String? location3;
  String? location4;
  String? endDate;
  String fullName;
  String? startDate;
  String? description;
  String? userImage;
  List polling_location_im;
  List polling_location_im2;
  List polling_location_im3;
  List youtubeurls;

  List polling_location_im4;
  // int? singup_step;
  // String? userImage;
  // String? userPhone;
  // String? password;

  performancePolingModel({
    required this.youtubeurls,
    required this.location3,
    required this.location4,
    required this.polling_location_im3,
    required this.polling_location_im4,
    required this.polling_location_im,
    required this.polling_location_im2,
    required this.description,
    required this.userImage,
    required this.uid,
    required this.location,
    required this.time,
    required this.location2,
    required this.endDate,
    required this.startDate,
    required this.fullName,
    // this.userEmail,
    // this.userImage,
    // this.singup_step,
    // this.userPhone
  });

  // performancePolingModel.fromMap(Map<String, dynamic> map) {
  //   uid = map["uid"];
  //   // fullName = map["fullname"];
  //   // userEmail = map["userEmail"];
  //   userImage = map["userImage"];
  // }
  Map<String, dynamic> toMap() {
    SetOptions(merge: true);
    return {
      "time": time,
      "youtubeUrls": youtubeurls,
      "uid": uid,
      "location": {"location1": location, "like": []},
      // "location.like": [],
      "location2": {"location2": location2, "like": []},
      // "location2.like": [],
      "location3": {"location3": location3, "like": []},
      // "location3.like": [],
      "location4": {"location4": location4, "like": []},
      // "location4.like": [],
      "endDate": endDate,
      "fullName": fullName,
      "startDate": startDate,
      "description": description,
      "userImage": userImage,
      "polling_location_im": polling_location_im,
      "polling_location_im2": polling_location_im2,
      "polling_location_im3": polling_location_im,
      "polling_location_im4": polling_location_im2
    };
  }
}
