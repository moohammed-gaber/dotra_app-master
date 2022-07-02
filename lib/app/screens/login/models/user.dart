class User {
  User({
    this.id,
    this.identifierNum,
    this.name,
    this.lName,
    this.email,
    this.mobile,
    this.latitude,
    this.longitude,
    this.department,
    this.city,
    this.gender,
    this.nationalId,
    this.img,
    this.dateBirth,
    this.isConfirmed,
    this.userType,
  });

  int id;
  String identifierNum;
  String name;
  String lName;
  String email;
  String mobile;
  dynamic latitude;
  dynamic longitude;
  int department;
  int city;
  String gender;
  String nationalId;
  String img;
  DateTime dateBirth;
  int isConfirmed;
  int userType;

  factory User.fromJson(Map userData) {
    // print(user);
    // var userData = user['data'];

    return User(
      id: userData["id"],
      identifierNum: userData["identifier_num"],
      name: userData["name"],
      lName: userData["l_name"],
      email: userData["email"],
      mobile: userData["mobile"],
      latitude: userData["latitude"],
      longitude: userData["longitude"],
      department: userData["department"],
      city: userData["city"],
      gender: userData["gender"],
      nationalId: userData["national_id"],
      img: userData["img"],
      dateBirth:userData["date_birth"].runtimeType==String?DateTime.parse(userData["date_birth"]):userData["date_birth"],
      isConfirmed: userData["is_confirmed"],
      userType: userData["user_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "identifier_num": identifierNum,
        "name": name,
        "l_name": lName,
        "email": email,
        "mobile": mobile,
        "latitude": latitude,
        "longitude": longitude,
        "department": department,
        "city": city,
        "gender": gender,
        "national_id": nationalId,
        "img": img,
        "date_birth":
            "${dateBirth.year.toString().padLeft(4, '0')}-${dateBirth.month.toString().padLeft(2, '0')}-${dateBirth.day.toString().padLeft(2, '0')}",
        "is_confirmed": isConfirmed,
        "user_type": userType,
      };
}
