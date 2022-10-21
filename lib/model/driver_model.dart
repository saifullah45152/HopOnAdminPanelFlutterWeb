import 'dart:convert';

DriverModel driverModelFromJson(String str) => DriverModel.fromJson(json.decode(str));

String driverModelToJson(DriverModel data) => json.encode(data.toJson());

class DriverModel {
  String? currentUserId;
  String? email;
  String? phone;
  String? imgUrl;
  String? firstName;
  String? lastName;
  String? homeAddress;
  int? ratingCount;
  double? balance;
  double? rating;
  double? ratingSum;
  String? gender;
  String? vehicleType;
  bool? isApproved;
  bool? isPhoneLinked;
  bool? isProfileComplete;
  String? fcmToken;
  DateTime? fcmCreatedAt;
  DateTime? accountCreatedAt;
  String? driverState;
  String? driverToState;

  List<String>? driverStateNToStateList;

  DriverModel({
    this.currentUserId,
    this.email,
    this.phone,
    this.imgUrl,
    this.firstName,
    this.lastName,
    this.homeAddress,
    this.ratingCount,
    this.balance,
    this.rating,
    this.ratingSum,
    this.gender,
    this.vehicleType,
    this.isApproved,
    this.isPhoneLinked,
    this.isProfileComplete,
    this.fcmToken,
    this.fcmCreatedAt,
    this.accountCreatedAt,
    this.driverState,
    this.driverToState,
    this.password,
    this.driverStateNToStateList,
  });

  String? password;

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
    currentUserId: json["currentUserId"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    imgUrl: json["imgUrl"] ?? "",
    firstName: json["firstName"] ?? "",
    lastName: json["lastName"] ?? "",
    homeAddress: json["homeAddress"] ?? "",
    ratingCount: json["ratingCount"] ?? 0,
    balance: json["balance"] ?? 0.0,
    rating: json["rating"].toDouble() ?? 0.0,
    ratingSum: json["ratingSum"].toDouble() ?? 0.0,
    gender: json["gender"] ?? "",
    vehicleType: json["vehicleType"] ?? "",
    driverState: json["driverState"] ?? "",
    driverToState: json["driverToState"] ?? "",
    password: json["password"] ?? "",
    isApproved: json["isApproved"] ?? false,
    isPhoneLinked: json["isPhoneLinked"] ?? false,
    isProfileComplete: json["isProfileComplete"] ?? false,
    fcmToken: json["fcmToken"] ?? "",
    fcmCreatedAt: json["fcmCreatedAt"] != null ? DateTime.parse(json["fcmCreatedAt"]) : DateTime.now(),
    accountCreatedAt: json["accountCreatedAt"] != null ? DateTime.parse(json["accountCreatedAt"]) : DateTime.now(),
    driverStateNToStateList: json["driverStateNToStateList"] != null
        ? List<String>.from(json['driverStateNToStateList'].map((x) => x))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "currentUserId": currentUserId ?? "",
    "email": email ?? "",
    "phone": phone ?? "",
    "imgUrl": imgUrl ?? "",
    "firstName": firstName ?? "",
    "lastName": lastName ?? "",
    "homeAddress": homeAddress ?? "",
    "ratingCount": ratingCount ?? 0,
    "balance": balance ?? 0.0,
    "rating": rating ?? 0.0,
    "ratingSum": ratingSum ?? 0.0,
    "gender": gender ?? "",
    "vehicleType": vehicleType ?? "",
    "driverState": driverState ?? "",
    "driverToState": driverToState ?? "",
    "password": password ?? "",
    "isApproved": isApproved ?? false,
    "isPhoneLinked": isPhoneLinked ?? false,
    "isProfileComplete": isProfileComplete ?? false,
    "fcmToken": fcmToken ?? "",
    "fcmCreatedAt": fcmCreatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    "accountCreatedAt": accountCreatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    "driverStateNToStateList": driverStateNToStateList ?? [],
  };
}
