import '../utils/my_geo_hasher.dart';

class PackageRequestModel {
  List<String> driverTokens;
  String? passengerId;
  String? jointId;
  String? passengerName;
  String? passengerImageUrl;
  String? passengerPhone;
  String? passengerRating;
  String? passengerCurrentAddress;
  String? isAcceptedById;
  String? isAcceptedByName;
  String? isAcceptedByImageUrl;
  String? isAcceptedByPhone;
  String? driverRating;
  String? fromAddress;
  String? toAddress;
  String? selectedVehicle;
  double? distanceInKm;
  String? estimatedTime;
  String? estimatedFare;
  bool? isAccepted;
  bool? isSchedulePackageRequest;
  bool? notifyDriverStartPackageRide;
  bool? notifyDriverReachedPackageRide;
  bool? isPickedUp;
  bool? isDroppedOff;
  bool? isRideCompleted;
  MyGeoPoint? passengerCurrentGeopoint;
  MyGeoPoint? driverCurrentGeopoint;
  MyGeoPoint? packagePickUpGeopPoint;
  MyGeoPoint? packageDestinationGeopoint;
  int? numberOfPackage;
  int? utcMiliSeconds;
  String? notificationType;
  String? requestType;
  String? fromState;
  String? toState;
  String? fromStatePlaceID;
  String? toStatePlaceID;
  String? requestDate;
  String? requestTime;
  int? requestDateTime;
  DateTime? startRideTime;
  DateTime? endRideTime;
  DateTime? pickupRideTime;
  DateTime? dropOffRideTime;
  DateTime? passengerRequestTime;
  DateTime? driverAcceptTime;

  double? batchEstimatedDistanceInKm;
  String? batchEstimatedTime;
  String? batchEstimatedFare;

  PackageRequestModel({
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
    this.isAcceptedById,
    this.isAcceptedByName,
    this.isAcceptedByImageUrl,
    this.isAcceptedByPhone,
    this.passengerId,
    this.jointId,
    this.passengerName,
    this.fromAddress,
    this.toAddress,
    this.selectedVehicle,
    this.distanceInKm,
    this.estimatedTime,
    this.estimatedFare,
    this.packagePickUpGeopPoint,
    this.packageDestinationGeopoint,
    this.numberOfPackage,
    this.utcMiliSeconds,
    this.requestDate,
    this.requestTime,
    this.notificationType,
    this.requestType,
    this.isSchedulePackageRequest,
    this.fromState,
    this.toState,
    this.notifyDriverStartPackageRide,
    this.notifyDriverReachedPackageRide,
    this.isPickedUp,
    this.isDroppedOff,
    this.isRideCompleted,
    this.fromStatePlaceID,
    this.toStatePlaceID,
    this.requestDateTime,
    this.startRideTime,
    this.endRideTime,
    this.pickupRideTime,
    this.dropOffRideTime,
    this.batchEstimatedDistanceInKm,
    this.batchEstimatedTime,
    this.batchEstimatedFare,
  });

  factory PackageRequestModel.fromJson(Map<String, dynamic> json) => PackageRequestModel(
        driverTokens: List<String>.from(json['driverTokens'].map((x) => x)),
        passengerCurrentGeopoint: MyGeoPoint.fromJson(json["passengerCurrentGeopoint"]),
        passengerCurrentAddress: json["passengerCurrentAddress"] ?? "",
        passengerPhone: json["passengerPhone"] ?? "",
        driverCurrentGeopoint: MyGeoPoint.fromJson(json["driverCurrentGeopoint"]),
        passengerRequestTime: DateTime.parse(json["passengerRequestTime"]),
        driverAcceptTime: DateTime.parse(json["driverAcceptTime"]),
        driverRating: json["driverRating"] ?? "",
        isAccepted: json["isAccepted"] ?? false,
        isSchedulePackageRequest: json["isSchedulePackageRequest"] ?? true,
        notifyDriverStartPackageRide: json["notifyDriverStartPackageRide"] ?? false,
        notifyDriverReachedPackageRide: json["notifyDriverReachedPackageRide"] ?? false,
        isPickedUp: json["isPickedUp"] ?? false,
        isDroppedOff: json["isDroppedOff"] ?? false,
        isRideCompleted: json["isRideCompleted"] ?? false,
        isAcceptedById: json["isAcceptedById"] ?? "",
        isAcceptedByName: json["isAcceptedByName"] ?? "",
        isAcceptedByImageUrl: json["isAcceptedByImageUrl"] ?? "",
        isAcceptedByPhone: json["isAcceptedByPhone"] ?? "",
        passengerId: json["passengerId"] ?? "",
        jointId: json["jointId"] ?? "",
        passengerName: json["passengerName"] ?? "",
        passengerRating: json["passengerRating"] ?? "",
        passengerImageUrl: json["passengerImageUrl"] ?? "",
        fromAddress: json["fromAddress"] ?? "",
        toAddress: json["toAddress"] ?? "",
        selectedVehicle: json["selectedVehicle"] ?? "",
        distanceInKm: json["distanceInKm"].toDouble() ?? 0.0,
        estimatedTime: json["estimatedTime"] ?? "",
        estimatedFare: json["estimatedFare"] ?? "",
        packagePickUpGeopPoint: json["packagePickUpGeopPoint"] != null
            ? MyGeoPoint.fromJson(json["packagePickUpGeopPoint"])
            : MyGeoPoint(g: "", l: [0.0, 0.0]),
        packageDestinationGeopoint: json["packageDestinationGeopoint"] != null
            ? MyGeoPoint.fromJson(json["packageDestinationGeopoint"])
            : MyGeoPoint(g: "", l: [0.0, 0.0]),
        numberOfPackage: json["numberOfPackage"] ?? 1,
        utcMiliSeconds: json["utcMiliSeconds"] ?? 1,
        requestDate: json["requestDate"] ?? "",
        requestTime: json["requestTime"] ?? "",
        notificationType: json["notificationType"] ?? "",
        requestType: json["requestType"] ?? "",
        fromState: json["fromState"] ?? "",
        toState: json["toState"] ?? "",
        fromStatePlaceID: json["fromStatePlaceID"] ?? "",
        toStatePlaceID: json["toStatePlaceID"] ?? "",
        requestDateTime: json["requestDateTime"] ?? 0,
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
        "passengerRequestTime": passengerRequestTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
        "driverAcceptTime": driverAcceptTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
        "driverRating": driverRating ?? "",
        "isAccepted": isAccepted ?? false,
        "notifyDriverStartPackageRide": notifyDriverStartPackageRide ?? false,
        "notifyDriverReachedPackageRide": notifyDriverReachedPackageRide ?? false,
        "isPickedUp": isPickedUp ?? false,
        "isDroppedOff": isDroppedOff ?? false,
        "isRideCompleted": isRideCompleted ?? false,
        "isSchedulePackageRequest": isSchedulePackageRequest ?? true,
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
        "selectedVehicle": selectedVehicle ?? "",
        "distanceInKm": distanceInKm ?? 0.0,
        "requestDateTime": requestDateTime ?? 0.0,
        "estimatedTime": estimatedTime ?? "",
        "estimatedFare": estimatedFare ?? "",
        "numberOfPackage": numberOfPackage ?? "",
        "utcMiliSeconds": utcMiliSeconds ?? 0,
        "requestDate": requestDate ?? "",
        "requestTime": requestTime ?? "",
        "packagePickUpGeopPoint": packagePickUpGeopPoint?.toJson() ?? MyGeoPoint(g: "g", l: [0.0, 0.0]).toJson(),
        "packageDestinationGeopoint":
            packageDestinationGeopoint?.toJson() ?? MyGeoPoint(g: "g", l: [0.0, 0.0]).toJson(),
        "notificationType": notificationType ?? "",
        "requestType": requestType ?? "",
        "fromState": fromState ?? "",
        "toState": toState ?? "",
        "fromStatePlaceID": fromStatePlaceID ?? "",
        "toStatePlaceID": toStatePlaceID ?? "",
        "startRideTime": startRideTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
        "endRideTime": endRideTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
        "pickupRideTime": pickupRideTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
        "dropOffRideTime": dropOffRideTime?.toIso8601String() ?? DateTime(1989).toIso8601String(),
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
        g: json["g"] != null ? json["g"] : "",
        l: List<double>.from(json["l"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "g": GeoHash.encode(l[0], l[1]),
        "l": List<dynamic>.from(l.map((x) => x)),
      };
}
