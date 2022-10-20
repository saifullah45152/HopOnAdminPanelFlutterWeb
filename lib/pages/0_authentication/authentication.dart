import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/locator.dart';
import 'package:flutter_web_dashboard/routing/router.dart';
import 'package:flutter_web_dashboard/routing/routes_names.dart';
import 'package:flutter_web_dashboard/services/navigation_service.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  GlobalKey<FormState> signInKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    log("Log In Page ");
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: signInKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/2-removebg-preview.png"),
                      Expanded(child: Container()),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CustomText(
                        text: "Welcome back to the admin panel.",
                        color: lightGrey,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (!GetUtils.isEmail(value?.trim() ?? "")) {
                        return "Please enter a valid email address";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "abc@domain.com",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "123",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                    validator: (pass) {
                      if (pass!.trim().isEmpty) {
                        print('Password is Required');
                        return 'Password is Required';
                      } else if (pass.trim().length < 6) {
                        print('Password must have at least 6 elements');
                        return 'Password must have at least 6 elements';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      locator<NavigationService>().navigateTo(overviewPageRoute);
                      navigationController.showSideMenu.value = true;
                      // locator<NavigationService>().navigateTo(timePagePageRoute);

                      // Get.offAllNamed(rootRoute);
                      // Navigator.pushReplacementNamed(context, RoutesName.SITELAYOUT);

                      // NavigationService.navigateTo(timePagePageRoute);
                      //
                      // locator<NavigationController>().navigateTo(timePagePageRoute);

                      // Navigator.pushNamed(context, RoutesName.SITELAYOUT);

                      // if (signInKey.currentState?.validate() ?? false) {
                      //   signInKey.currentState?.save();
                      //   try {
                      //     showLoading();
                      //     try {
                      //       await FirebaseAuth.instance
                      //           .signInWithEmailAndPassword(
                      //             email: emailController.text.trim().toLowerCase(),
                      //             password: passwordController.text.trim(),
                      //           )
                      //           .then((result) async {});
                      //       Get.back();
                      //     } on FirebaseAuthException catch (e) {
                      //       dismissLoadingWidget();
                      //       showErrorSnackBar(e);
                      //     }
                      //   } catch (e) {
                      //     log(e.toString());
                      //   }
                      // } else {
                      //   Get.defaultDialog(
                      //     title: "Validation Error!",
                      //     middleText: "Please fill in the all the fields correctly.",
                      //     textConfirm: "Ok",
                      //     onConfirm: () {
                      //       Get.back();
                      //     },
                      //     confirmTextColor: Colors.white,
                      //     buttonColor: Colors.blueAccent,
                      //   );
                      // }
                    },
                    child: Container(
                      decoration: BoxDecoration(color: active, borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CustomText(
                        text: "Login",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
