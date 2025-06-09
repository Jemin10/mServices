class UserModel {
  String? uid;
  String? name;
  String? email;
  String? userType;
  String? serviceType;
  String? phoneNo;
  String? description;
  String? hourlyRate;
  String? experience;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.userType,
    this.serviceType,
    this.phoneNo,
    this.description,
    this.hourlyRate,
    this.experience,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"] ?? "",
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        userType: json["user_type"] ?? "",
        serviceType: json["service_type"] ?? "",
        phoneNo: json["phone_no"] ?? "",
        description: json["description"] ?? "",
        hourlyRate: json["hourly_rate"] ?? "",
        experience: json["experience"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "uid": uid ?? "",
        "name": name ?? "",
        "email": email ?? "",
        "user_type": userType ?? "",
        "service_type": serviceType ?? "",
        "phone_no": phoneNo ?? "",
        "description": description ?? "",
        "hourly_rate": hourlyRate ?? "",
        "experience": experience ?? "",
      };
}
