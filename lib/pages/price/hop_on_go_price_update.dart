import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

class HopOnGoPriceUpdate extends StatefulWidget {
  Map? mapData;
  String? id;
  HopOnGoPriceUpdate({Key? key, this.mapData, this.id}) : super(key: key);

  @override
  State<HopOnGoPriceUpdate> createState() => _HopOnGoPriceUpdateState();
}

class _HopOnGoPriceUpdateState extends State<HopOnGoPriceUpdate> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController kiloMeterController = TextEditingController();
  TextEditingController bookingFeeController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    kiloMeterController.text = widget.mapData!['pricePerMiles'].toString();
    bookingFeeController.text = widget.mapData!['bookingFee'].toString();
    serviceController.text = widget.mapData!['serviceFee'].toString();
    timeController.text = widget.mapData!['timeMultiplier'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "HOP ON GO",
                        weight: FontWeight.bold,
                        size: 18,
                      ),
                      SizedBox(height: Get.height * 0.04),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Image.asset(
                              "assets/images/Hop On.png",
                              height: 70,
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.04),
                      TextFormField(
                        controller: kiloMeterController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a price";
                          }
                          // else if (!GetUtils.isNum(value.trim())) {
                          //   return "Please enter a valid price ";
                          // }
                          else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Per 1 KiloMeter",
                          hintText: "1",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: bookingFeeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a price";
                          }
                          // else if (!GetUtils.isNum(value.trim())) {
                          //   return "Please enter a valid price ";
                          // }
                          else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Hop On Go Booking Fee",
                          hintText: "2",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: serviceController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a price";
                          }
                          // else if (!GetUtils.isNum(value.trim())) {
                          //   return "Please enter a valid number ";
                          // }
                          else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Hop On Go Service Fee",
                          hintText: "2",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: timeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a price";
                          } else if (!GetUtils.isNum(value.trim())) {
                            return "Please enter a valid number ";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Hop On Go time Fee",
                          hintText: "2",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            log("Updating");
                            await ffstore.collection("HopOnPrices").doc(widget.id).update({
                              'pricePerMiles': int.parse(kiloMeterController.text),
                              'bookingFee':int.parse( bookingFeeController.text),
                              'serviceFee': double.parse(serviceController.text),
                              'timeMultiplier': int.parse(timeController.text),
                            });
                            Get.snackbar(
                              "Success",
                              "Price updated successfully",
                              duration: Duration(seconds: 4),
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else {
                            Get.snackbar(
                              "Failure ",
                              "Form Not Validated ",
                              duration: Duration(seconds: 4),
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(color: active, borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: CustomText(
                            text: "Update",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
