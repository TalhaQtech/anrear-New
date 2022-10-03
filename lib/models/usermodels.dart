class UserModel {
  String? uid;
  String? Nationality;
  String? dob;
  String? description;
  String? fullName;
  String? userEmail;
  int? singup_step;
  List? award;
  String? userImage;
  String? userPhone;
  String? password;
  String? userType;
  List? musicCategorie;
  List? links;
  var time;

  UserModel(
      {required this.time,
      required this.musicCategorie,
      this.uid,
      required this.Nationality,
      required this.dob,
      required this.description,
      required this.userType,
      required this.award,
      this.password,
      this.fullName,
      this.userEmail,
      this.userImage,
      this.singup_step,
      required this.links,
      this.userPhone});

  UserModel.fromMap(Map<String, dynamic> map) {
    time = map["time"];
    links = map["links"];
    musicCategorie = map["musicCategorie"];
    award = map["award"];
    uid = map["uid"];
    Nationality = map["nationality"];
    dob = map["dob"];
    fullName = map["fullName"];
    description = map["description"];
    userPhone = map["userPhone"];
    userEmail = map["userEmail"];
    userImage = map["userImage"];
    userType = map["userType"];
    singup_step = map["singupStep"];
  }
  Map<String, dynamic> toMap() {
    return {
      "time": time,
      "musicCategorie": musicCategorie,
      "links": links,
      "award": award,
      "password": password,
      "userType": userType,
      "singupStep": singup_step,
      "uid": uid,
      "userPhone": userPhone,
      "fullName": fullName,
      "userEmail": userEmail,
      "userImage": userImage,
      "nationality": Nationality,
      "dob": dob,
      "description": description
    };
  }
}
