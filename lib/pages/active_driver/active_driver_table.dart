import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

/// Example without datasource
class ActiveDriverTable extends StatefulWidget {
  @override
  State<ActiveDriverTable> createState() => _ActiveDriverTableState();
}

class _ActiveDriverTableState extends State<ActiveDriverTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                                        width:110,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Image.network(
                                            "https://images.unsplash.com/photo-1661439387743-6679e95fa650?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Get.width*0.16),
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

                              Container(
                                width: Get.width * 0.9,
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Image.network(
                                              "https://images.unsplash.com/photo-1661439387743-6679e95fa650?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: Container(
                                      width: Get.width * 0.34,
                                      child: Text(
                                        "",
                                        // style: BlackSmallStyle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: Get.width * 0.35,
                                        child: Text(
                                          "  widget.driver",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        width: Get.width * 0.35,
                                        child: Text(
                                          "widget.phoneNumber",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Text(
                                    "Pending",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
