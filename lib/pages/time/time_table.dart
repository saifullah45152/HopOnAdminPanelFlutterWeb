import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Example without datasource
class TimeTable extends StatefulWidget {
  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
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
                GestureDetector(
                  onTap: () {
                    selectTime(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      border: Border.all(color: active.withOpacity(.4), width: .5),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 6),
                          color: lightGrey.withOpacity(.1),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.timer,
                            color: active,
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "ADD NEW TIME",
                          weight: FontWeight.bold,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: CustomText(
                    text: "Available TimeSlots",
                    weight: FontWeight.bold,
                    size: 20,
                  ),
                ),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: ffstore.collection("HopOnTimeSlot").orderBy('time').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        if (snapshot.data!.docs.length > 0) {
                          return Wrap(
                            direction: Axis.horizontal,
                            children: List.generate(snapshot.data?.docs.length ?? 0, (index) {
                              return Container(
                                margin: EdgeInsets.all(3),
                                padding: EdgeInsets.all(20),
                                width: 175,
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
                                    Container(),
                                    CustomText(text: "${snapshot.data!.docs[index]['time']}"),
                                    // SizedBox(width: 10),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        await ffstore
                                            .collection("HopOnTimeSlot")
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                        Get.snackbar(
                                          "Success",
                                          "Time Slot Deleted  Successfully",
                                          duration: Duration(seconds: 4),
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      },
                                      child: Image.asset("assets/images/Group 1 (2).png", height: 16),
                                    ),
                                    Container(),
                                  ],
                                ),
                              );
                            }),
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

  Rx<DateTime> taskDateTime = DateTime.now().obs;
  RxString selectedTime = DateTime.now().toString().obs;

  selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != taskDateTime) {
      print("Inside Time Picker ");
      taskDateTime = DateTime(
        taskDateTime.value.year,
        taskDateTime.value.month,
        taskDateTime.value.day,
        timeOfDay.hour,
        timeOfDay.minute,
      ).obs;
      selectedTime.value = taskDateTime.value.toString();
      if (selectedTime.value != "") {
        await ffstore
            .collection("HopOnTimeSlot")
            .where('time', isEqualTo: DateFormat('jm').format(DateTime.parse(selectedTime.value)))
            .get()
            .then((value) async {
          log("Before if time val");
          if (value.docs.length > 0) {
            log("Already  Exists ");
            Get.snackbar(
              "Fails",
              "Time already exists ",
              duration: Duration(seconds: 4),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            log("Else adding part");
            await ffstore.collection("HopOnTimeSlot").add({
              'time': DateFormat('jm').format(DateTime.parse(selectedTime.value)),
            });
            Get.snackbar(
              "Success",
              "Time Added Successfully",
              duration: Duration(seconds: 4),
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        });
      } else {
        log(" Date not selected ");
      }
    }
  }
}
