import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

class ActiveRides extends StatelessWidget {
  const ActiveRides({Key? key}) : super(key: key);

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
                  padding: const EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 30),
                  child: Container(
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 600),
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Active Drivers",
                              weight: FontWeight.bold,
                              size: 20,
                            ),
                            SizedBox(height: 20),
                            const ActiveRidesPart()   ,
                          ],
                        ),
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
}


class ActiveRidesPart extends StatelessWidget {
  const ActiveRidesPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: ffstore.collection("HopOnTimeSlot").snapshots(),
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
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Map data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  log(" Map is $data");
                  return Container(
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white60,
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
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            height: 110,
                            width: 110,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                "https://images.unsplash.com/photo-1661439387743-6679e95fa650?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Name ",
                              weight: FontWeight.bold,
                              size: 16,
                            ),
                            SizedBox(height: 6),
                            CustomText(
                              text: "Phone Number ",
                              weight: FontWeight.bold,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
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
    );
  }
}
