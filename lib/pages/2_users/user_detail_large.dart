import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/model/driver_model.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:flutter_web_dashboard/widgets/my_text_widget.dart';
import 'package:get/get.dart';

class UserDetailLarge extends StatelessWidget {
  DriverModel? driverModel;

  UserDetailLarge({Key? key, this.driverModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        log("Inside WillPopScope");
        // Navigator.push(context, MaterialPageRoute(builder: (context) => new SiteLayout()));

        // Navigator.pushNamed(context, RoutesName.OVERVIEW_PAGE);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => new OverviewPage()));
        return true;
      },
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          margin: EdgeInsets.all(25),
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
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(30, 60, 30, 30),
            physics: BouncingScrollPhysics(),
            children: [
              // CircleAvatar(
              //   radius: 80,
              //   backgroundImage: NetworkImage(
              //     "${driverModel?.imgUrl ?? ""}",
              //   ),
              // ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 6,
                              color: Colors.black.withOpacity(0.16),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            "${driverModel?.imgUrl ?? ""}",
                            fit: BoxFit.cover,
                            height: 250,
                            width: 250,
                            loadingBuilder:
                                (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: SizedBox(
                                  height: 58,
                                  width: 58,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<
                                              Color>(
                                        kSecondaryColor,
                                      ),
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
                                                  .toInt()
                                          : null,
                                    ),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: SizedBox(
                                  height: 58,
                                  width: 58,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<
                                              Color>(
                                        kSecondaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MyText(
                            text:
                                "${driverModel?.firstName}${driverModel?.lastName ?? ""} ",
                            size: 30,
                            weight: FontWeight.w700,
                            color: Colors.black,
                            paddingBottom: 30,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/Vector - 2022-03-31T133502.452.png",
                                color: Colors.black,
                                // height: 15.h,
                                height: 24,
                              ),
                              const SizedBox(width: 10),
                              MyText(
                                text: "${driverModel?.email}",
                                size: 24,
                                weight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/Vector - 2022-03-22T152702.484.png",
                                color: Colors.black,
                                height: 24,
                              ),
                              const SizedBox(width: 10),
                              MyText(
                                text: "${driverModel?.phone}",
                                size: 24,
                                weight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: ffstore
                    .collection(driverCollection)
                    .doc(driverModel!.currentUserId)
                    .collection("VerificationDocuments")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState ==
                      ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.docs.length > 0) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            Map data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                            return Container(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Get.height * 0.04),
                                  //+Inspection
                                  CustomText(
                                    text: "Driver Inspection",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(height: Get.height * 0.04),
                                  ImageWidget(
                                      imgUrl: '${data['inspection']}'),
                                  SizedBox(height: Get.height * 0.04),
                                  //+Insurance
                                  CustomText(
                                    text: "Driver Insurance",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(height: Get.height * 0.04),
                                  ImageWidget(
                                      imgUrl: '${data['insurance']}'),
                                  SizedBox(height: Get.height * 0.04),
                                  //+licence
                                  CustomText(
                                    text: "Driver License",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(height: Get.height * 0.04),
                                  ImageWidget(imgUrl: '${data['license']}'),

                                  SizedBox(height: Get.height * 0.04),
                                  //+plate
                                  CustomText(
                                    text: "Driver Plate ",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(height: Get.height * 0.04),
                                  ImageWidget(imgUrl: '${data['plate']}'),

                                  SizedBox(height: Get.height * 0.04),
                                  //+registration
                                  CustomText(
                                    text: "Driver Registration ",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(height: Get.height * 0.04),
                                  ImageWidget(
                                      imgUrl: '${data['registration']}'),

                                  SizedBox(height: Get.height * 0.04),
                                  //+self
                                  CustomText(
                                    text: "Driver Self ",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(height: Get.height * 0.04),
                                  ImageWidget(imgUrl: '${data['self']}'),
                                  SizedBox(height: Get.height * 0.04),
                                  //+social
                                  CustomText(
                                    text: "Driver Social ",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(height: Get.height * 0.04),
                                  ImageWidget(imgUrl: '${data['social']}'),
                                  SizedBox(height: Get.height * 0.04),
                                  //+Button
                                  SizedBox(height: Get.height * 0.06),
                                  InkWell(
                                    onTap: () {
                                      log("Driver Accepted or rejected ");
                                      ffstore
                                          .collection(driverCollection)
                                          .doc(driverModel!.currentUserId)
                                          .update({'isApproved': true});
                                      Get.snackbar(
                                        "Success",
                                        "Users approved successfully",
                                        duration: Duration(seconds: 4),
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: active,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      alignment: Alignment.center,
                                      width: double.maxFinite,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16),
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
                      return Center(
                          child: const Text('No Recommendations For Now'));
                    }
                  } else {
                    log("in last else of ConnectionState.done and: ${snapshot.connectionState}");
                    return Center(
                        child: Text('State: ${snapshot.connectionState}'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key, required this.imgUrl}) : super(key: key);

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: Get.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imgUrl,
          fit: BoxFit.cover,
          height: 58,
          width: 58,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return ClipOval(
              child: SizedBox(
                height: 58,
                width: 58,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      kSecondaryColor,
                    ),
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!.toInt()
                        : null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
