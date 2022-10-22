import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/pages/overview/widgets/info_card.dart';

import 'info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: ffstore.collection("ActiveRides").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              log("inside home stream builder");
              int previousCount = snapshot.data != null ? snapshot.data!.docs.length : 0;

              if (snapshot.connectionState == ConnectionState.waiting) {
                log("inside home stream builder in waiting state");
                return InfoCardSmall(
                  title: "Rides in progress",
                  value: "$previousCount",
                  onTap: () {},
                );
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  log("inside home has data and ${snapshot.data!.docs.length}");
                  log("inside home has data and ${snapshot.data!.docs.length}");
                  if (snapshot.data!.docs.length > 0) {
                    return InfoCardSmall(
                      title: "Rides in progress",
                      value: "${snapshot.data!.docs.length}",
                      onTap: () {},
                    );
                  } else {
                    return InfoCardSmall(
                      title: "Rides in progress",
                      value: "0",
                      onTap: () {},
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
          SizedBox(height: _width / 64),
          InfoCardSmall(title: "Packages delivered", value: "17", onTap: () {}),
          SizedBox(height: _width / 64),
          Row(
            children: [
              // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              //   stream: ffstore.collection("CancelRequest").snapshots(),
              //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //     int previousCount = snapshot.data != null ? snapshot.data!.docs.length : 0;
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       log("inside home  length :  ${snapshot.data!.docs.length}");
              //       return InfoCardSmall(
              //         title: "Cancelled delivery",
              //         value: "$previousCount",
              //         onTap: () {},
              //       );
              //     } else if (snapshot.connectionState == ConnectionState.active ||
              //         snapshot.connectionState == ConnectionState.done) {
              //       if (snapshot.hasError) {
              //         return const Text('Error');
              //       } else if (snapshot.hasData) {
              //         log("inside home has data and ${snapshot.data!.docs.length}");
              //         log("inside home has data and ${snapshot.data!.docs.length}");
              //         if (snapshot.data!.docs.length > 0) {
              //           return InfoCardSmall(
              //             title: "Cancelled delivery",
              //             value: "${snapshot.data!.docs.length}",
              //             onTap: () {},
              //           );
              //         } else {
              //           return InfoCardSmall(
              //             title: "Cancelled delivery",
              //             value: "0",
              //             onTap: () {},
              //           );
              //         }
              //       } else {
              //         log("in else of hasData done on home and: ${snapshot.connectionState} and"
              //             " snapshot.hasData: ${snapshot.hasData}");
              //         return Center(child: const Text('No Recommendations For Now'));
              //       }
              //     } else {
              //       log("in last else of ConnectionState.done and: ${snapshot.connectionState}");
              //       return Center(child: Text('State: ${snapshot.connectionState}'));
              //     }
              //   },
              // ),
            ],
          ),
          SizedBox(height: _width / 64),
          InfoCardSmall(title: "Scheduled deliveries", value: "32", onTap: () {}),
        ],
      ),
    );
  }
}
