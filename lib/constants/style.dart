import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//firebase
FirebaseFirestore ffstore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

//Collections

String driverCollection = "Drivers";
String driverPendingCollection = "PendingDrivers";

String helpChatRoomCollection = "HelpChatRoom";
String helpChatMessageCollection = "HelpMessage";

// ADMIN ID

String adminId = "ZQtP0Mp7icVUaT54WjUSvUJW0n53";

//Colors
Color light = Color(0xFFF7F8FC);
Color lightGrey = Color(0xFFA4A6B3);
Color dark = Color(0xFF363740);
Color active = Color(0xFF3C19C0);
const KBlackColor = Color(0xff000000);

const KGreyDarkColor = Color(0xff747487);
const KSecondaryColor = Color(0xff121132);
const KPrimaryColor = Color(0xffFFFFFF);
const KGreyColor = Color(0xffF2F2F5);
const kPrimaryColor2 = Color(0xffFFFFFF);
const kGreyColor = Color(0xff707070);
// const kSecondaryColor = Color(0xffA032FF);
const kSecondaryColor = Color(0xffA032FF);

const TextStyle inputText = TextStyle(
  color: KGreyDarkColor,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500,
  fontSize: 14,
);
const TextStyle BlackSmallTextStyle = TextStyle(
  color: KSecondaryColor,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500,
  fontSize: 12,
);
const TextStyle GreyLightTextSmall = TextStyle(
  color: KGreyDarkColor,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
  fontSize: 12,
);

const TextStyle BlackSmallStyle = TextStyle(
  color: KSecondaryColor,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

const TextStyle MainWhiteheading = TextStyle(
  color: KPrimaryColor,
  fontFamily: "Roboto",
  fontWeight: FontWeight.w500,
  fontSize: 24,
);
TextStyle DisabledBlackSmallDarkStyle = TextStyle(
  color: Colors.grey.withOpacity(0.7),
  fontFamily: "Poppins",
  fontWeight: FontWeight.w600,
  fontSize: 14,
);

const TextStyle BlackSmallDarkStyle = TextStyle(
  color: KSecondaryColor,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w600,
  fontSize: 14,
);
const TextStyle BlackTextStyle = TextStyle(
  color: KSecondaryColor,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500,
  fontSize: 14,
);
const TextStyle WhiteSmallStyle = TextStyle(
  color: KPrimaryColor,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500,
  fontSize: 14,
);

const TextStyle GreyStyle = TextStyle(
  color: KSecondaryColor,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500,
  fontSize: 10,
);

const TextStyle WhiteStyle = TextStyle(
  color: KPrimaryColor,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500,
  fontSize: 10,
);

//+For Drop Down Field
final dropDownSignUpText = TextStyle(
  fontWeight: FontWeight.w500,
  color: kNewGreyColor,
  fontSize: 16.0,
);

final dropDownSignUpSelectedText = TextStyle(
  fontWeight: FontWeight.w500,
  color: kPrimaryColor,
  fontSize: 16.0,
);
const kNewGreyColor = Color(0xff686868);
var kTransparentColor = kPrimaryColor.withOpacity(0.5);
const kPrimaryColor = Color(0xffFFFFFF);

class DropDownDeco {
  static final dropDownDeco = BoxDecoration(
    borderRadius: BorderRadius.circular(6),
    border: Border.all(
      width: 2.0,
      // color: Colors.black,
      color: kTransparentColor,
    ),
  );
}
