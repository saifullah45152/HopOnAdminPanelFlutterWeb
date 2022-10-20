import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/model/package_request_model.dart';
import 'package:flutter_web_dashboard/model/request_model.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecordPage extends StatelessWidget {
  RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
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
                        stream: ffstore.collection("RideRecord").snapshots(),
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
    );
  }

  Rx<DateTime> taskDateTime = DateTime.now().obs;
  RxString selectedTime = DateTime.now().toString().obs;

  selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != taskDateTime) {
      // setState(() async {
      print("Inside Time Picker ");
      taskDateTime = DateTime(
        taskDateTime.value.year,
        taskDateTime.value.month,
        taskDateTime.value.day,
        timeOfDay.hour,
        timeOfDay.minute,
      ).obs;
      selectedTime.value = taskDateTime.value.toString();

      log("Selected time  is $taskDateTime");
      log("Selected time from => selectedTime.value  is ${selectedTime.value}");
      log(" Time after parsing ${DateFormat('jm').format(DateTime.parse(selectedTime.value))}");

      if (selectedTime.value != null && selectedTime.value != "") {
        await ffstore.collection("HopOnTimeSlot").add({
          'time': DateFormat('jm').format(DateTime.parse(selectedTime.value)),
        });
        Get.snackbar(
          "Success",
          "Time Added Successfully",
          duration: Duration(seconds: 4),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        log(" Date not selected ");
      }
      // });
    }
  }
}

class RideRequestCard extends StatelessWidget {
  RequestModel? requestModel;
  String? id;
  RideRequestCard({Key? key, this.requestModel, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * 0.6,
                child: Text(
                  "Pickup location",
                  style: BlackSmallTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: Get.width * 0.7,
                child: Text(
                  "${requestModel?.fromAddress ?? ""}",
                  style: BlackSmallTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width * 0.6,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Drop-off location",
                  style: BlackSmallTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: Get.width * 0.7,
                child: Text(
                  "${requestModel?.toAddress ?? ""}",
                  style: BlackSmallTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          SizedBox(height: 30.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ListTile(
                  visualDensity: VisualDensity(
                    vertical: -4,
                  ),
                  leading: Text(
                    "Type of ride",
                    style: BlackSmallDarkStyle,
                  ),
                  trailing: Text(
                    "Ride Request ",
                    style: BlackSmallDarkStyle,
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(
                    vertical: -4,
                  ),
                  leading: Text(
                    "${requestModel?.selectedVehicle ?? ""}",
                    style: BlackSmallDarkStyle,
                  ),
                  trailing: Text(
                    "${requestModel?.numberOfSeats ?? ""}",
                    style: BlackSmallDarkStyle,
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(
                    vertical: -4,
                  ),
                  leading: Text(
                    "Date",
                    style: BlackSmallDarkStyle,
                  ),
                  trailing: Text(
                    "Time",
                    style: BlackSmallDarkStyle,
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(
                    vertical: -4,
                  ),
                  leading: Text(
                    "${requestModel?.requestDate ?? ""}",
                    style: BlackSmallDarkStyle,
                  ),
                  trailing: Text(
                    "${requestModel?.requestTime ?? ""}",
                    style: BlackSmallDarkStyle,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Est. Distance",
                      style: BlackSmallTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                            child: Text(
                          "${((requestModel?.distanceInKm ?? 0) * 0.62137).toStringAsFixed(2)} miles",

                          // "${requestModel?.distanceInKm ?? 0.0} Km",
                          style: BlackSmallTextStyle,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Est. Time",
                      style: BlackSmallTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                            // width: Get.width * 0.2,
                            child: Text(
                          "${requestModel?.estimatedTime}",
                          style: BlackSmallTextStyle,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Est. Price",
                      style: BlackSmallTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          // width: Get.width * 0.2,
                          child: Text(
                            "${requestModel?.estimatedFare}",
                            style: BlackSmallTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Text(
                  "Pickup Time",
                  style: BlackSmallTextStyle,
                ),
                trailing: Container(
                  width: 90,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "${requestModel!.requestTime}",
                        style: BlackSmallTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25.h),
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
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: KSecondaryColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: KPrimaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        child: VerticalDivider(
                          color: KBlackColor.withOpacity(0.2),
                        )),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: KGreyColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: KSecondaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width * 0.6,
                    child: Text(
                      "Pickup location",
                      style: BlackSmallTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: Get.width * 0.7,
                    child: Text(
                      "${packageRequestModel?.fromAddress ?? ""}",
                      style: BlackSmallTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: Get.width * 0.6,
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Drop-off location",
                      style: BlackSmallTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: Get.width * 0.7,
                    child: Text(
                      "${packageRequestModel?.toAddress ?? ""}",
                      style: BlackSmallTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 30.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ListTile(
                  visualDensity: VisualDensity(
                    vertical: -4,
                  ),
                  leading: Text(
                    "Type of ride",
                    style: BlackSmallDarkStyle,
                  ),
                  trailing: Text(
                    "Package Request ",
                    style: BlackSmallDarkStyle,
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(
                    vertical: -4,
                  ),
                  leading: Text(
                    "${packageRequestModel?.selectedVehicle ?? ""}",
                    style: BlackSmallDarkStyle,
                  ),
                  trailing: Text(
                    "${packageRequestModel?.numberOfPackage ?? ""}",
                    style: BlackSmallDarkStyle,
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(
                    vertical: -4,
                  ),
                  leading: Text(
                    "Date",
                    style: BlackSmallDarkStyle,
                  ),
                  trailing: Text(
                    "Time",
                    style: BlackSmallDarkStyle,
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(
                    vertical: -4,
                  ),
                  leading: Text(
                    "${packageRequestModel?.requestDate ?? ""}",
                    style: BlackSmallDarkStyle,
                  ),
                  trailing: Text(
                    "${packageRequestModel?.requestTime ?? ""}",
                    style: BlackSmallDarkStyle,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Est. Distance",
                      style: BlackSmallTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                            // width: Get.width * 0.2,
                            child: Text(
                          "${packageRequestModel?.distanceInKm ?? 0.0} Km",
                          style: BlackSmallTextStyle,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Est. Time",
                      style: BlackSmallTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                            // width: Get.width * 0.2,
                            child: Text(
                          "${packageRequestModel?.estimatedTime}",
                          style: BlackSmallTextStyle,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Est. Price",
                      style: BlackSmallTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          // width: Get.width * 0.2,
                          child: Text(
                            "${double.parse(packageRequestModel?.estimatedFare ?? "").toStringAsFixed(2)}",
                            style: BlackSmallTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Text(
                  "Pickup Time",
                  style: BlackSmallTextStyle,
                ),
                trailing: Container(
                  width: 90,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "${packageRequestModel!.requestTime ?? ""}",
                        style: BlackSmallTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }
}
