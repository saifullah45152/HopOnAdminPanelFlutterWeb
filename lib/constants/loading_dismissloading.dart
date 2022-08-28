
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

showLoading() {
  Get.defaultDialog(
    title: "",
    content: LoadingAnimationWidget.staggeredDotsWave(
      color: Colors.black,
      size: 100,
    ),
    barrierDismissible: false,
  );
}

dismissLoadingWidget() {
  Get.back();
}

//+show snacK
showCustomSnackBar({required String title, required String message, int seconds = 2}) {
  Get.snackbar(
    title,
    message,
    duration: Duration(seconds: seconds),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
  );
}

showErrorSnackBar(FirebaseAuthException e) {
  switch (e.code) {
    case "user-mismatch":
      showCustomSnackBar(
        title: "User Mismatch❗",
        message: "The given credentials do not correspond to the user.  Please 🙏 try again.",
        seconds: 4,
      );
      log("user-mismatch");
      break;
    case "user-not-found":
      showCustomSnackBar(
        title: "User not found❗",
        message: "The given credentials do not correspond to any existing user. Please 🙏 try again.",
        seconds: 4,
      );
      log("user-not-found");
      break;
    case "invalid-email":
      showCustomSnackBar(
        title: "Invalid email❗",
        message: "Seems like the given email is invalid. Please 🙏 sign-in again.",
        seconds: 4,
      );
      log("invalid-email");
      break;
    case "email-already-in-use":
      showCustomSnackBar(
        title: "Email already in use❗",
        message: "As this is a security sensitive matter, please 🙏 sign-in again.",
        seconds: 4,
      );
      log("email-already-in-use");
      break;
    case "requires-recent-login":
      showCustomSnackBar(
        title: "Requires recent login❗",
        message: "As this is a security sensitive matter, Please 🙏 sign-in again.",
        seconds: 4,
      );
      log("requires recent login");
      break;
    case "wrong-password":
      log("wrong-password");
      showCustomSnackBar(
        title: "🤦‍♂️Wrong Password!",
        message: "Please 🙏 enter correct current password to "
            "successfully change the email.",
        seconds: 4,
      );
      break;
    case "network-request-failed":
      log("wrong-password");
      showCustomSnackBar(
        title: "🤦‍♂️Network Error",
        message: "Please 🙏 connect to the strong internet connection.",
        seconds: 4,
      );
      break;
    case "too-many-requests":
      log("too-many-requests");
      showCustomSnackBar(
        title: "🤦‍♂️Too many attempts",
        message: "Firebase has temporarily blocked your requests."
            "Please 🙏 try again in a few minutes. ",
        seconds: 4,
      );
      break;
    case "provider-already-linked":
      log("provider-already-linked");
      showCustomSnackBar(
        title: "🤦‍♂️Provider already linked",
        message: "This provider is already linked to another account. "
            "Please 🙏 try again with a different one. ",
        seconds: 4,
      );
      break;
    case "credential-already-in-use":
      log("credential-already-in-use");
      showCustomSnackBar(
        title: "🤦‍♂️Credentials already in use",
        message: "These credentials are already being used. "
            "Please 🙏 try again with different ones. ",
        seconds: 4,
      );
      break;
    case "operation-not-allowed":
      log("operation-not-allowed");
      showCustomSnackBar(
        title: "🤦‍♂️Service is not allowed",
        message: "Seems like this service is not available to the users for the time being. "
            "Please 🙏 try again after a few days or contact the app owners. ",
        seconds: 4,
      );
      break;
    case "invalid-verification-code":
      log("invalid-verification-code");
      showCustomSnackBar(
        title: "🤦‍♂️Invalid Verification Code",
        message: "The verification code for phone authentication could not be validated. "
            "Please 🙏 try again. ",
        seconds: 4,
      );
      break;
    case "invalid-verification-id":
      log("invalid-verification-id");
      showCustomSnackBar(
        title: "🤦‍♂️Invalid Verification Id",
        message: "The verification id for phone authentication could not be validated. "
            "Please 🙏 try again. ",
        seconds: 4,
      );
      break;
    case "invalid-phone-number":
      log("invalid-phone-number");
      showCustomSnackBar(
        title: "🤦‍♂️Invalid Phone Number",
        message: "The provided phone number is invalid. "
            "Please 🙏 enter a valid phone number with the country code, as in +923001212345 and try again. ",
        seconds: 4,
      );
      break;
    case "invalid-credential":
      log("invalid-credential");
      showCustomSnackBar(
        title: "🤦‍♂️Invalid Credentials",
        message: "The provided credentials could not be validated. "
            "Please 🙏 try again. ",
        seconds: 4,
      );
      break;
    default:
      showCustomSnackBar(
        title: "Error!",
        message: "Following error was thrown: $e",
        seconds: 5,
      );
      break;
  }
}
