import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/bar_chart.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/revenue_info.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';

class RevenueSectionSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12),
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        children: [
          // Container(
          //   height: 260,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       CustomText(
          //         text: "Revenue Chart",
          //         size: 20,
          //         weight: FontWeight.bold,
          //         color: lightGrey,
          //       ),
          //       Container(width: 600, height: 200, child: SimpleBarChart.withSampleData()),
          //     ],
          //   ),
          // ),

          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: ffstore.collection("HopOnEarnings").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    int previousCount = snapshot.data != null ? snapshot.data!.docs.length : 0;

                    log("inside home stream builder");
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      log("inside home stream builder in waiting state");
                      return RevenueInfo(
                        title: "HOP ON Go",
                        amount: "$previousCount",
                      );
                    } else if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        log("inside home has data and ${snapshot.data!.docs.length}");
                        log("inside home has data and ${snapshot.data!.docs.length}");
                        if (snapshot.data!.docs.length > 0) {
                          return RevenueInfo(
                            title: "HOP ON Go",
                            amount: "${snapshot.data!.docs[0]['HopOnGo']}",
                          );
                        } else {
                          return RevenueInfo(
                            title: "HOP ON Go",
                            amount: "0",
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
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: ffstore.collection("HopOnEarnings").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    int previousCount = snapshot.data != null ? snapshot.data!.docs.length : 0;

                    log("inside home stream builder");
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      log("inside home stream builder in waiting state");
                      return   RevenueInfo(
                        title: "HOP ON X",
                        amount: "$previousCount",
                      );
                    } else if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        log("inside home has data and ${snapshot.data!.docs.length}");
                        log("inside home has data and ${snapshot.data!.docs.length}");
                        if (snapshot.data!.docs.length > 0) {
                          return RevenueInfo(
                            title: "HOP ON X",
                            amount: "${snapshot.data!.docs[0]['HopOnX']}",
                          );
                        } else {
                          return RevenueInfo(
                            title: "HOP ON Go",
                            amount: "0",
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
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: ffstore.collection("HopOnEarnings").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    int previousCount = snapshot.data != null ? snapshot.data!.docs.length : 0;

                    log("inside home stream builder");
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      log("inside home stream builder in waiting state");
                      return   RevenueInfo(
                        title: "HOP ON XL",
                        amount: "$previousCount",
                      );;
                    } else if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        log("inside home has data and ${snapshot.data!.docs.length}");
                        log("inside home has data and ${snapshot.data!.docs.length}");
                        if (snapshot.data!.docs.length > 0) {
                          return RevenueInfo(
                            title: "HOP ON XL",
                            amount: "${snapshot.data!.docs[0]['HopOnXL']}",
                          );
                        } else {
                          return RevenueInfo(
                            title: "HOP ON XL",
                            amount: "0",
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

                // Row(
                //   children: [
                //     RevenueInfo(
                //       title: "Toda\'s revenue",
                //       amount: "230",
                //     ),
                //     RevenueInfo(
                //       title: "Last 7 days",
                //       amount: "1,100",
                //     ),
                //   ],
                // ),
                // Row(
                //   children: [
                //     RevenueInfo(
                //       title: "Last 30 days",
                //       amount: "3,230",
                //     ),
                //     RevenueInfo(
                //       title: "Last 12 months",
                //       amount: "11,300",
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
