class performancePolingModel {
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
  List polling_location_im4;
  // int? singup_step;
  // String? userImage;
  // String? userPhone;
  // String? password;

  performancePolingModel({
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
    return {
      "uid": uid,
      "location": location,
      "location2": location2,
      "location3": location3,
      "location4": location4,
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
