import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Example without datasource
class ReservationTable extends StatefulWidget {
  @override
  State<ReservationTable> createState() => _ReservationTableState();
}

class _ReservationTableState extends State<ReservationTable> {
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
                          child: Icon(
                            Icons.timer,
                            color: active,
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Reservation Page ",
                          weight: FontWeight.bold,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
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
      // setState(() async {
      print("Inside Time Picker ");
      taskDateTime = DateTime(
        taskDateTime.value.year,
        taskDateTime.value.month,
        taskDateTime.value.day,
        timeOfDay.hour,
        timeOfDay.minute,
      ).obs;
      selectedTime.value = taskDateTime.value.toString();
 ;

      if (selectedTime.value != null && selectedTime.value != "") {
        await ffstore.collection("HopOnTimeSlot").add({
          'time': DateFormat('jm').format(DateTime.parse(selectedTime.value)),
        });
        Get.snackbar(
          "Success",
          "Time Added Successfully",
          duration: Duration(seconds: 4),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        log(" Date not selected ");
      }
      // });
    }
  }
}