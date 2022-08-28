import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/pages/price/hop_on_go_price_update.dart';
import 'package:flutter_web_dashboard/pages/price/hop_on_x_price_update.dart';
import 'package:flutter_web_dashboard/pages/price/hop_on_xl_price_update.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';


class PriceTable extends StatefulWidget {
  PriceTable({Key? key}) : super(key: key);

  @override
  State<PriceTable> createState() => _PriceTableState();
}

class _PriceTableState extends State<PriceTable> {
  TextEditingController kiloMeterController = TextEditingController();
  TextEditingController bookingFeeController = TextEditingController();
  TextEditingController serviceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 30),
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
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: ffstore.collection("HopOnGoPrice").snapshots(),
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
                              return GestureDetector(
                                onTap: () {
                                  // Get.to(HopOnGoPriceUpdate(mapData: data));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => HopOnGoPriceUpdate(
                                        mapData: data,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
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
                                        child: Image.asset(
                                          "assets/images/Hop On.png",
                                          height: 40,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      CustomText(
                                        text: "HOP ON GO",
                                        weight: FontWeight.bold,
                                        size: 16,
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
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: ffstore.collection("HopOnXPrice").snapshots(),
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
                              return GestureDetector(
                                onTap: () {
                                  // Get.to(HopOnGoPriceUpdate(mapData: data));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => HopOnXPriceUpdate(
                                        mapData: data,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
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
                                        child: Image.asset(
                                          "assets/images/Hop On X.png",
                                          height: 40,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      CustomText(
                                        text: "HOP ON X",
                                        weight: FontWeight.bold,
                                        size: 16,
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
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: ffstore.collection("HopOnXPrice").snapshots(),
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
                              return GestureDetector(
                                onTap: () {
                                  // Get.to(HopOnGoPriceUpdate(mapData: data));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => HopOnXLPriceUpdate(
                                        mapData: data,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
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
                                        child: Image.asset(
                                          "assets/images/Hop On XL .png",
                                          height: 40,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      CustomText(
                                        text: "HOP ON XL",
                                        weight: FontWeight.bold,
                                        size: 16,
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}