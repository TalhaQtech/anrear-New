class performancePolingModel {
  String? uid;
  String? location;
  String? location2;
  String? endDate;
  String fullName;
  String? startDate;
  String? description;
  String? userImage;
  List polling_location_im;
  List polling_location_im2;
  // int? singup_step;
  // String? userImage;
  // String? userPhone;
  // String? password;

  performancePolingModel({
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
      "endDate": endDate,
      "fullName": fullName,
      "startDate": startDate,
      "description": description,
      "userImage": userImage,
      "polling_location_im": polling_location_im,
      "polling_location_im2": polling_location_im2
    };
  }
}
