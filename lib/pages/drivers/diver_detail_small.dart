import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/model/driver_model.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

class DriverDetailSmall extends StatelessWidget {
  DriverModel? driverModel;
  DriverDetailSmall({Key? key, this.driverModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.all(30),
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: active.withOpacity(.4),
              width: .5,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12,
              ),
            ],
          ),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                    "${driverModel?.imgUrl ?? ""}",
                  ),
                ),
                SizedBox(height: Get.height * 0.04),
                Row(
                  children: [
                    SizedBox(width: 5),
                    CustomText(
                      text: "${driverModel?.firstName}${driverModel?.lastName ?? ""} ",
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.04),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      Image.asset(
                        "assets/images/Vector - 2022-03-31T133502.452.png",
                        color: Color(0xff121132),
                        // height: 15.h,
                        height: 15,
                      ),
                      const SizedBox(width: 7),
                      CustomText(
                        text: "${driverModel?.email}",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.04),
                Row(
                  children: [
                    SizedBox(width: 5),
                    Image.asset(
                      "assets/images/Vector - 2022-03-22T152702.484.png",
                      color: Color(0xff121132),
                      height: 15,
                    ),
                    const SizedBox(width: 7),
                    CustomText(
                      text: "${driverModel?.phone}",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: ffstore
                      .collection(driverCollection)
                      .doc(driverModel!.currentUserId)
                      .collection("VerificationDocuments")
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    log("inside home stream builder");
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      log("inside home stream builder in waiting state");
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        log("inside home has data and ${snapshot.data!.docs.length}");
                        log("inside home has data and ${snapshot.data!.docs.length}");
                        if (snapshot.data!.docs.length > 0) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              Map data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                              log(" inspection img url is ${data['inspection']}");

                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: Get.height * 0.04),
                                    //+Inspection
                                    CustomText(
                                      text: "Driver Inspection",
                                      size: 18,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    Container(
                                      height: 150,
                                      width: Get.width,
                                      child: Image.network(
                                        "${data['inspection']}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    //+Insurance
                                    CustomText(
                                      text: "Driver Insurance",
                                      size: 18,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    Container(
                                      height: 150,
                                      width: Get.width,
                                      child: Image.network(
                                        "${data['insurance']}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    //+licence
                                    CustomText(
                                      text: "Driver License",
                                      size: 18,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    Container(
                                      height: 150,
                                      width: Get.width,
                                      child: Image.network(
                                        "${data['license']}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    //+plate
                                    CustomText(
                                      text: "Driver Plate ",
                                      size: 18,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    Container(
                                      height: 150,
                                      width: Get.width,
                                      child: Image.network(
                                        "${data['plate']}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    //+registration
                                    CustomText(
                                      text: "Driver Registration ",
                                      size: 18,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    Container(
                                      height: 150,
                                      width: Get.width,
                                      child: Image.network(
                                        "${data['registration']}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    //+self
                                    CustomText(
                                      text: "Driver Self ",
                                      size: 18,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    Container(
                                      height: 150,
                                      width: Get.width,
                                      child: Image.network(
                                        "${data['self']}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    //+social
                                    CustomText(
                                      text: "Driver Social ",
                                      size: 18,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    Container(
                                      height: 150,
                                      width: Get.width,
                                      child: Image.network(
                                        "${data['social']}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                    //+Button

                                    SizedBox(height: Get.height * 0.06),
                                    InkWell(
                                      onTap: () {
                                        log("Driver Accepted or rejected ");
                                      },
                                      child: Container(
                                        decoration:
                                        BoxDecoration(color: active, borderRadius: BorderRadius.circular(20)),
                                        alignment: Alignment.center,
                                        width: double.maxFinite,
                                        padding: EdgeInsets.symmetric(vertical: 16),
                                        child: CustomText(
                                          text: "Accept",
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: const Text(
                              'No Recommendations For Now',
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
              ],
            ),
          ),
        ),
      )
    );
  }
}