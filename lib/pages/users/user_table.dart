import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/pages/users/user_detail_layout_bulder.dart';
import 'package:flutter_web_dashboard/model/driver_model.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

/// Example without datasource
class UserTable extends StatelessWidget {
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
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: ffstore.collection(driverCollection).orderBy('isApproved',descending: true).snapshots(),
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
                      DriverModel driverModel =
                          DriverModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                      log("Data is ${data}");
                      log(" driver model is \n  ${driverModel.toJson()}");
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                log("Row Button Pressed ");
                                Get.to(() => UserLayOutScreen(
                                      driverModel: driverModel,
                                    ));
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      text: "${driverModel.firstName} ",
                                    ),
                                  ),
                                  Expanded(
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 10,
                                      ),
                                      child: Container(),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      text: "${driverModel.email} ",
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      constraints: BoxConstraints(minWidth: 100),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      text: driverModel.isApproved == false ? "Pending" : "Approved ",
                                      weight: FontWeight.bold,
                                      color: driverModel.isApproved == false ? active : Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      constraints: BoxConstraints(minWidth: 100),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      log("View Button Pressed ");
                                      // Get.to(
                                      //   () => LayoutScreen(
                                      //     driverModel: driverModel,
                                      //   ),
                                      // );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => UserLayOutScreen(
                                            driverModel: driverModel,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: light,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: active, width: .5),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      child: CustomText(
                                        text: "View",
                                        color: active.withOpacity(.7),
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
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
        ));
  }
}
