import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/model/driver_model.dart';
import 'package:flutter_web_dashboard/widgets/my_text_widget.dart';
import 'package:get/get.dart';

class ActiveDriverLargeScreen extends StatelessWidget {
  const ActiveDriverLargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
          physics: BouncingScrollPhysics(),
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: ffstore.collection(driverCollection).where("isApproved", isEqualTo: true).snapshots(),
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
                          DriverModel driverModel =
                              DriverModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);

                          return Container(
                            padding: EdgeInsets.all(10),
                            child: IntrinsicHeight(
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
                                          "${driverModel.imgUrl ?? ""}",
                                          fit: BoxFit.cover,
                                          height: 250,
                                          width: 250,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
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
                                          errorBuilder: (context, error, stackTrace) {
                                            return Center(
                                              child: SizedBox(
                                                height: 58,
                                                width: 58,
                                                child: Center(
                                                  child: CircularProgressIndicator(
                                                    valueColor: const AlwaysStoppedAnimation<Color>(
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
                                  SizedBox(width: 30),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        MyText(
                                          text: "${driverModel.firstName}${driverModel.lastName ?? ""} ",
                                          size: 30,
                                          weight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 14),
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
                                              text: "${driverModel.email}",
                                              size: 24,
                                              weight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 14),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/Vector - 2022-03-22T152702.484.png",
                                              color: Colors.black,
                                              height: 24,
                                            ),
                                            const SizedBox(width: 10),
                                            MyText(
                                              text: "${driverModel.phone}",
                                              size: 24,
                                              weight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 14),
                                        MyText(
                                          text: "Account Balance : ${driverModel.balance?.toStringAsFixed(2) ?? ""}",
                                          size: 30,
                                          weight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
