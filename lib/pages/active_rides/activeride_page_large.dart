import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/model/package_request_model.dart';
import 'package:flutter_web_dashboard/model/request_model.dart';

class ActiveRidelargeScreen extends StatelessWidget {
  ActiveRidelargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: active.withOpacity(.4), width: .5),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 6),
                          color: lightGrey.withOpacity(.1),
                          blurRadius: 12,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      child: Center(
                        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: ffstore.collection("ActiveRides").snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.connectionState == ConnectionState.active ||
                                snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Text('Error');
                              } else if (snapshot.hasData) {
                                if (snapshot.data!.docs.length > 0) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index) {
                                      bool type = snapshot.data!.docs[index]['isSchedulePackageRequest'];
                                      //true for package
                                      if (type) {
                                        PackageRequestModel packageRequestModel = PackageRequestModel.fromJson(
                                            snapshot.data!.docs[index].data() as Map<String, dynamic>);

                                        return PackageRequestCard(
                                            packageRequestModel: packageRequestModel,
                                            id: snapshot.data!.docs[index].id);
                                      } else {
                                        RequestModel rideRequestModel = RequestModel.fromJson(
                                            snapshot.data!.docs[index].data() as Map<String, dynamic>);
                                        return RideRequestCard(
                                            requestModel: rideRequestModel, id: snapshot.data!.docs[index].id);
                                      }
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: const Text(
                                      'No Recommendations For No',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }
                              } else {
                                log("in else of hasData done on home and: ${snapshot.connectionState} and"
                                    " snapshot.hasData: ${snapshot.hasData}");
                                return Center(child: const Text('No Recommendations For Now'));
                              }
                            } else {
                              log("in last else of ConnectionState.done and: ${snapshot.connectionState}");
                              return Center(child: Text('State: ${snapshot.connectionState}'));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RideRequestCard extends StatelessWidget {
  RequestModel? requestModel;
  String? id;

  RideRequestCard({Key? key, this.requestModel, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              // Container(
              //   child: Column(
              //     children: [
              //       Container(
              //         padding: EdgeInsets.all(8),
              //         decoration: BoxDecoration(
              //           color: KSecondaryColor,
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: Container(
              //           padding: EdgeInsets.all(3),
              //           decoration: BoxDecoration(
              //             color: KPrimaryColor,
              //             borderRadius: BorderRadius.circular(100),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 50,
              //         child: VerticalDivider(
              //           color: KBlackColor.withOpacity(0.2),
              //         ),
              //       ),
              //       Container(
              //         padding: EdgeInsets.all(8),
              //         decoration: BoxDecoration(
              //           color: KGreyColor,
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: Container(
              //           padding: EdgeInsets.all(3),
              //           decoration: BoxDecoration(
              //             color: KSecondaryColor,
              //             borderRadius: BorderRadius.circular(100),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Pickup location",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1.7,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${requestModel?.fromAddress ?? ""}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1.7,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Drop-off location",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1.7,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${requestModel?.toAddress ?? ""}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1.7,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 20),
          // buildRow(title: 'PickUp Location', subtitle: "${requestModel?.fromAddress ?? ""}"),
          // SizedBox(height: 20),
          // buildRow(title: 'Drop-Off-Location', subtitle: "${requestModel?.toAddress ?? ""}"),
          SizedBox(height: 20),
          buildRow(title: 'Passenger Name', subtitle: "${requestModel?.passengerName ?? ""}"),
          SizedBox(height: 20),
          buildRow(title: 'Driver Name', subtitle: "${requestModel?.isAcceptedByName ?? ""}"),
          SizedBox(height: 20),
          buildRow(title: 'Tpe of Ride', subtitle: "${requestModel?.selectedVehicle ?? ""}"),
          SizedBox(height: 20),
          buildRow(title: 'Date', subtitle: "${requestModel?.requestDate ?? ""}"),
          SizedBox(height: 20),
          buildRow(title: 'PickUpTime', subtitle: "${requestModel?.requestTime ?? ""}"),
          SizedBox(height: 20),
          buildRow(
              title: 'Distance',
              subtitle: " ${((requestModel?.distanceInKm ?? 0) * 0.62137).toStringAsFixed(2)} miles"),
          SizedBox(height: 20),
          buildRow(title: 'Price', subtitle: "${requestModel?.estimatedFare ?? ""}"),
        ],
      ),
    );
  }
}

class buildRow extends StatelessWidget {
  String title;
  String subtitle;
  buildRow({Key? key, required this.title, required this.subtitle, this.requestModel}) : super(key: key);

  final RequestModel? requestModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.7,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 22,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

class PackageRequestCard extends StatelessWidget {
  PackageRequestModel? packageRequestModel;
  String? id;

  PackageRequestCard({Key? key, this.packageRequestModel, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        // color: Colors.green,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              // Container(
              //   child: Column(
              //     children: [
              //       Container(
              //         padding: EdgeInsets.all(8),
              //         decoration: BoxDecoration(
              //           color: KSecondaryColor,
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: Container(
              //           padding: EdgeInsets.all(3),
              //           decoration: BoxDecoration(
              //             color: KPrimaryColor,
              //             borderRadius: BorderRadius.circular(100),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 50,
              //         child: VerticalDivider(
              //           color: KBlackColor.withOpacity(0.2),
              //         ),
              //       ),
              //       Container(
              //         padding: EdgeInsets.all(8),
              //         decoration: BoxDecoration(
              //           color: KGreyColor,
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: Container(
              //           padding: EdgeInsets.all(3),
              //           decoration: BoxDecoration(
              //             color: KSecondaryColor,
              //             borderRadius: BorderRadius.circular(100),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Pickup location",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1.7,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${packageRequestModel?.fromAddress ?? ""}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1.7,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Drop-off location",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1.7,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${packageRequestModel?.toAddress ?? ""}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1.7,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 20),
          // buildRow(title: 'PickUp Location', subtitle: "${packageRequestModel?.fromAddress ?? ""}"),
          // SizedBox(height: 20),
          // buildRow(title: 'Drop-Off-Location', subtitle: "${packageRequestModel?.toAddress ?? ""}"),
          SizedBox(height: 20),
          buildRow(title: 'Passenger Name', subtitle: "${packageRequestModel?.passengerName ?? ""}"),
          SizedBox(height: 20),
          buildRow(title: 'Driver Name', subtitle: "${packageRequestModel?.isAcceptedByName ?? ""}"),
          SizedBox(height: 20),
          buildRow(title: 'Tpe of Ride', subtitle: "${packageRequestModel?.selectedVehicle ?? ""}"),
          SizedBox(height: 20),
          buildRow(title: 'Date', subtitle: "${packageRequestModel?.requestDate ?? ""}"),
          SizedBox(height: 20),
          buildRow(title: 'PickUpTime', subtitle: "${packageRequestModel?.requestTime ?? ""}"),
          SizedBox(height: 20),
          buildRow(
              title: 'Distance',
              subtitle: " ${((packageRequestModel?.distanceInKm ?? 0) * 0.62137).toStringAsFixed(2)} miles"),
          SizedBox(height: 20),
          buildRow(title: 'Price', subtitle: "${packageRequestModel?.estimatedFare ?? ""}"),
        ],
      ),
    );
  }
}
