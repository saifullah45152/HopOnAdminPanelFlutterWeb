import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

class HopOnXLPriceUpdate extends StatefulWidget {
  Map? mapData;
  String? id;
  HopOnXLPriceUpdate({Key? key, this.mapData, this.id}) : super(key: key);

  @override
  State<HopOnXLPriceUpdate> createState() => _HopOnXLPriceUpdateState();
}

class _HopOnXLPriceUpdateState extends State<HopOnXLPriceUpdate> {
  TextEditingController kiloMeterController = TextEditingController();
  TextEditingController bookingFeeController = TextEditingController();
  TextEditingController serviceController = TextEditingController();

  @override
  void initState() {
    kiloMeterController.text = widget.mapData!['perkilometerprice'].toString();
    bookingFeeController.text = widget.mapData!['bookingfee'].toString();
    serviceController.text = widget.mapData!['hoponservicefee'].toString();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "HOP ON XL",
                    weight: FontWeight.bold,
                    size: 18,
                  ),
                  SizedBox(height: Get.height * 0.04),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          "assets/images/Hop On XL .png",
                          height: 70,
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.04),
                  TextFormField(
                    controller: kiloMeterController,
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
                    decoration: InputDecoration(
                      labelText: "Hop On Go Service Fee",
                      hintText: "2",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: () async {
                      await ffstore.collection("HopOnXLPrice").doc(widget.id).update({
                        'perkilometerprice': int.parse(kiloMeterController.text),
                        'bookingfee': int.parse(bookingFeeController.text),
                        'hoponservicefee': int.parse(serviceController.text),
                      });
                      Get.snackbar(
                        "Success",
                        "Price updated successfully",
                        duration: Duration(seconds: 4),
                        snackPosition: SnackPosition.BOTTOM,
                      );
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
    );
  }
}
