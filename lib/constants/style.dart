import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


//firebase
FirebaseFirestore ffstore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;


//Collections


String driverCollection = "Drivers";
String driverPendingCollection = "PendingDrivers";

//Colors
Color light = Color(0xFFF7F8FC);
Color lightGrey = Color(0xFFA4A6B3);
Color dark = Color(0xFF363740);
Color active = Color(0xFF3C19C0);