import 'dart:convert';

import 'package:flutter_web_dashboard/utils/my_geo_hasher.dart';

RequestModel requestModelFromJson(String str) => RequestModel.fromJson(json.decode(str));
String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
  List<String> driverTokens;
  String? passengerId;
  String? jointId;
  String? passengerName;
  String? passengerImageUrl;
  String? passengerPhone;
  String? passengerRating;
  String? passengerCurrentAddress;
  bool? isAccepted;
  bool? isRideCompleted;
  String? isAcceptedById;
  String? isAcceptedByName;
  String? isAcceptedByImageUrl;
  String? isAcceptedByPhone;
  String? driverRating;
  String? fromAddress;
  String? toAddress;
  String? fromState;
  String? toState;
  String? selectedVehicle;
  double? distanceInKm;
  String? estimatedTime;
  String? estimatedFare;
  MyGeoPoint? passengerCurrentGeopoint;
  MyGeoPoint? driverCurrentGeopoint;
  MyGeoPoint? pickupGeopoint;
  MyGeoPoint? destinationGeopoint;
  int? numberOfSeats;
  int? utcMiliSeconds;
  DateTime? passengerRequestTime;
  String? fromStatePlaceID;
  String? toStatePlaceID;
  bool? isPickedUp;
  bool? isDroppedOff;
  bool notifyDriverStartRide;
  bool notifyDriverReached;
  bool isSchedulePackageRequest;
  String? randomId;
  String? notificationType;
  String? requestCancelBy;
  //
  String? requestType;
  int? requestDateTime;
  String? requestDate;
  DateTime? driverAcceptTime;
  String? requestTime;
  DateTime? startRideTime;
  DateTime? endRideTime;
  DateTime? pickupRideTime;
  DateTime? dropOffRideTime;

  double? batchEstimatedDistanceInKm;
  String? batchEstimatedTime;
  String? batchEstimatedFare;

  RequestModel({
    required this.driverTokens,
    this.passengerCurrentGeopoint,
    this.passengerCurrentAddress,
    this.passengerPhone,
    this.passengerRating,
    this.passengerImageUrl,
    this.driverCurrentGeopoint,
    this.passengerRequestTime,
    this.driverRating,
    this.driverAcceptTime,
    this.isAccepted,
    this.isRideCompleted,
    this.isAcceptedById,
    this.isAcceptedByName,
    this.isAcceptedByImageUrl,
    this.isAcceptedByPhone,
    this.passengerId,
    this.requestCancelBy,
    this.jointId,
    this.passengerName,
    this.fromAddress,
    this.toAddress,
    this.fromState,
    this.toState,
    this.selectedVehicle,
    this.distanceInKm,
    this.estimatedTime,
    this.estimatedFare,
    this.pickupGeopoint,
    this.destinationGeopoint,
    this.numberOfSeats,
    this.utcMiliSeconds,
    this.requestDateTime,
    this.requestTime,
    this.requestDate,
    this.fromStatePlaceID,
    this.toStatePlaceID,
    this.isPickedUp,
    this.isDroppedOff,
    this.notifyDriverStartRide = false,
    this.notifyDriverReached = false,
    this.randomId,
    this.notificationType,
    this.requestType,
    this.isSchedulePackageRequest = false,
    this.startRideTime,
    this.endRideTime,
    this.pickupRideTime,
    this.dropOffRideTime,
    this.batchEstimatedDistanceInKm,
    this.batchEstimatedTime,
    this.batchEstimatedFare,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
    driverTokens: json['driverTokens'] != null ? List<String>.from(json['driverTokens'].map((x) => x)) : [],
    passengerCurrentGeopoint: json['passengerCurrentGeopoint'] != null
        ? MyGeoPoint.fromJson(json["passengerCurrentGeopoint"])
        : MyGeoPoint(g: "", l: [0.0, 0.0]),
    passengerCurrentAddress: json['passengerCurrentAddress'] != null ? json["passengerCurrentAddress"] ?? "" : "",
    passengerPhone: json['passengerPhone'] != null ? json["passengerPhone"] ?? "" : "",
    driverCurrentGeopoint: json['driverCurrentGeopoint'] != null
        ? MyGeoPoint.fromJson(json["driverCurrentGeopoint"])
        : MyGeoPoint(g: "", l: [0.0, 0.0]),
    driverRating: json['driverRating'] != null ? json["driverRating"] ?? "" : "",
    isAccepted: json['isAccepted'] != null ? json["isAccepted"] ?? false : false,
    isRideCompleted: json['isRideCompleted'] != null ? json["isRideCompleted"] ?? false : false,
    isAcceptedById: json['isAcceptedById'] != null ? json["isAcceptedById"] ?? "" : "",
    isAcceptedByName: json['isAcceptedByName'] != null ? json["isAcceptedByName"] ?? "" : "",
    isAcceptedByImageUrl: json['isAcceptedByImageUrl'] != null ? json["isAcceptedByImageUrl"] ?? "" : "",
    isAcceptedByPhone: json['isAcceptedByPhone'] != null ? json["isAcceptedByPhone"] ?? "" : "",
    passengerId: json['passengerId'] != null ? json["passengerId"] ?? "" : "",
    jointId: json['jointId'] != null ? json["jointId"] ?? "" : "",
    passengerName: json['passengerName'] != null ? json["passengerName"] ?? "" : "",
    passengerRating: json['passengerRating'] != null ? json["passengerRating"] ?? "" : "",
    passengerImageUrl: json['passengerImageUrl'] != null ? json["passengerImageUrl"] ?? "" : "",
    fromAddress: json['fromAddress'] != null ? json["fromAddress"] ?? "" : "",
    toAddress: json['toAddress'] != null ? json["toAddress"] ?? "" : "",
    fromState: json['fromState'] != null ? json["fromState"] ?? "" : "",
    toState: json['toState'] != null ? json["toState"] ?? "" : "",
    requestCancelBy: json['requestCancelBy'] != null ? json["requestCancelBy"] ?? "" : "",
    selectedVehicle: json['selectedVehicle'] != null ? json["selectedVehicle"] ?? "" : "",
    distanceInKm: json["distanceInKm"] != null ? json["distanceInKm"].toDouble() ?? 0.0 : 0.0,
    estimatedTime: json['estimatedTime'] != null ? json["estimatedTime"] ?? "" : "",
    estimatedFare: json['estimatedFare'] != null ? json["estimatedFare"] ?? "" : "",
    numberOfSeats: json['numberOfSeats'] != null ? json["numberOfSeats"] ?? 0 : 0,
    utcMiliSeconds: json['utcMiliSeconds'] != null ? json["utcMiliSeconds"] ?? 0 : 0,
    pickupGeopoint: json['pickupGeopoint'] != null
        ? MyGeoPoint.fromJson(json["pickupGeopoint"])
        : MyGeoPoint(g: "", l: [0.0, 0.0]),
    destinationGeopoint: json['destinationGeopoint'] != null
        ? MyGeoPoint.fromJson(json["destinationGeopoint"])
        : MyGeoPoint(g: "", l: [0.0, 0.0]),
    requestDate: json['requestDate'] != null ? json["requestDate"] ?? "" : "",
    fromStatePlaceID: json['fromStatePlaceID'] != null ? json["fromStatePlaceID"] ?? "" : "",
    toStatePlaceID: json['toStatePlaceID'] != null ? json["toStatePlaceID"] ?? "" : "",
    randomId: json['toStatePlaceID'] != null ? json["toStatePlaceID"] ?? "" : "",
    notificationType: json['notificationType'] != null ? json["notificationType"] ?? "" : "",
    requestType: json['requestType'] != null ? json["requestType"] ?? "" : "",
    isPickedUp: json['isPickedUp'] != null ? json["isPickedUp"] ?? false : false,
    isDroppedOff: json['isDroppedOff'] != null ? json["isDroppedOff"] ?? false : false,
    notifyDriverStartRide: json['notifyDriverStartRide'] != null ? json["notifyDriverStartRide"] ?? false : false,
    notifyDriverReached: json['notifyDriverReached'] != null ? json["notifyDriverReached"] ?? false : false,
    isSchedulePackageRequest:
    json['isSchedulePackageRequest'] != null ? json["isSchedulePackageRequest"] ?? false : false,
    //+time
    driverAcceptTime: json["driverAcceptTime"] != null ? DateTime.parse(json["driverAcceptTime"]) : DateTime.now(),
    requestTime: json["requestTime"] != null ? json["requestTime"] ?? "" : "",
    passengerRequestTime:
    json["passengerRequestTime"] != null ? DateTime.parse(json["passengerRequestTime"]) : DateTime.now(),
    requestDateTime: json["requestDateTime"] != null
        ? json["requestDateTime"] ?? DateTime.now().millisecondsSinceEpoch
        : DateTime.now().millisecondsSinceEpoch,
    startRideTime: (json.containsKey('startRideTime') && json["startRideTime"] != null)
        ? DateTime.parse(json["startRideTime"])
        : DateTime(1989),
    endRideTime: json["endRideTime"] != null ? DateTime.parse(json["endRideTime"]) : DateTime(1989),
    pickupRideTime: json["pickupRideTime"] != null ? DateTime.parse(json["pickupRideTime"]) : DateTime(1989),
    dropOffRideTime: json["dropOffRideTime"] != null ? DateTime.parse(json["dropOffRideTime"]) : DateTime(1989),

    batchEstimatedDistanceInKm:
    json["batchEstimatedDistanceInKm"] != null ? json["batchEstimatedDistanceInKm"].toDouble() ?? 0.0 : 0.0,
    batchEstimatedTime: json['batchEstimatedTime'] != null ? json["batchEstimatedTime"] ?? "" : "",
    batchEstimatedFare: json['batchEstimatedFare'] != null ? json["batchEstimatedFare"] ?? "" : "",
  );

  Map<String, dynamic> toJson() => {
    "driverTokens": List<dynamic>.from(driverTokens.map((x) => x)),
    "passengerCurrentGeopoint": passengerCurrentGeopoint?.toJson() ?? MyGeoPoint(g: "g", l: [0.0, 0.0]),
    "passengerCurrentAddress": passengerCurrentAddress ?? "",
    "passengerPhone": passengerPhone ?? "",
    "passengerRating": passengerRating ?? "",
    "driverCurrentGeopoint": driverCurrentGeopoint?.toJson() ?? MyGeoPoint(g: "g", l: [0.0, 0.0]).toJson(),
    "driverRating": driverRating ?? "",
    "isAccepted": isAccepted ?? false,
    "isRideCompleted": isRideCompleted ?? false,
    "isAcceptedById": isAcceptedById ?? "",
    "isAcceptedByName": isAcceptedByName ?? "",
    "isAcceptedByImageUrl": isAcceptedByImageUrl ?? "",
    "isAcceptedByPhone": isAcceptedByPhone ?? "",
    "passengerId": passengerId ?? "",
    "jointId": jointId ?? "",
    "passengerName": passengerName ?? "",
    "passengerImageUrl": passengerImageUrl ?? "",
    "fromAddress": fromAddress ?? "",
    "toAddress": toAddress ?? "",
    "fromState": fromState ?? "",
    "toState": toState ?? "",
    "selectedVehicle": selectedVehicle ?? "",
    "distanceInKm": distanceInKm ?? 0.0,
    "estimatedTime": estimatedTime ?? "",
    "estimatedFare": estimatedFare ?? "",
    "numberOfSeats": numberOfSeats ?? 0,
    "utcMiliSeconds": utcMiliSeconds ?? 0,
    "pickupGeopoint": pickupGeopoint?.toJson() ?? MyGeoPoint(g: "g", l: [0.0, 0.0]).toJson(),
    "destinationGeopoint": destinationGeopoint?.toJson() ?? MyGeoPoint(g: "g", l: [0.0, 0.0]).toJson(),
    "requestDate": requestDate ?? "",
    "fromStatePlaceID": fromStatePlaceID ?? "",
    "toStatePlaceID": toStatePlaceID ?? "",
    "randomId": randomId ?? "",
    "notificationType": notificationType ?? "",
    "requestType": requestType ?? "",
    "isPickedUp": isPickedUp ?? false,
    "isDroppedOff": isDroppedOff ?? false,
    "isSchedulePackageRequest": isSchedulePackageRequest ,
    "notifyDriverStartRide": notifyDriverStartRide,
    "notifyDriverReached": notifyDriverReached,
    "requestCancelBy": requestCancelBy ?? "",
    //+time
    "passengerRequestTime": passengerRequestTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
    "driverAcceptTime": driverAcceptTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
    "startRideTime": startRideTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
    "endRideTime": endRideTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
    "pickupRideTime": pickupRideTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
    "dropOffRideTime": dropOffRideTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
    "requestDateTime": requestDateTime ?? 0,
    "requestTime": requestTime ?? "",

    "batchEstimatedDistanceInKm": batchEstimatedDistanceInKm ?? 0.0,
    "batchEstimatedTime": batchEstimatedTime ?? DateTime(1989).toIso8601String(),
    "batchEstimatedFare": batchEstimatedFare ?? "0",
  };
}

class MyGeoPoint {
  MyGeoPoint({
    required this.g,
    required this.l,
  });

  String g;
  List<double> l;

  factory MyGeoPoint.fromJson(Map<String, dynamic> json) => MyGeoPoint(
    g: json != null ? json["g"] : "",
    l: json != null ? List<double>.from(json["l"].map((x) => x.toDouble())) : [0.0, 0.0],
  );

  Map<String, dynamic> toJson() => {
    "g": GeoHash.encode(l[0], l[1]),
    "l": List<dynamic>.from(l.map((x) => x)),
  };
}
