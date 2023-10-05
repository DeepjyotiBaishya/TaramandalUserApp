import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';
import 'package:rashi_network/services/shared_prefrence/prefrence_helper.dart';
import 'package:rashi_network/views/home_controller.dart';
import 'package:rashi_network/views/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getToken() async {
    PrefrenceDataController.to.token.value = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token) ?? '';
    PrefrenceDataController.to.fcmToken.value = await FirebaseMessaging.instance.getToken() ?? '';
    log(PrefrenceDataController.to.fcmToken.value, name: "FCM TOKEN");
  }

  @override
  void initState() {
    // TODO: implement initState
    /* if (PrefrenceDataController.to.token.value != '' &&
        PrefrenceDataController.to.token.value != null) {
      return const HomeController();
    } else {
      return const LoginScreen();
    }*/
    getToken().then((value) {
      Timer(const Duration(seconds: 5), () {
        // Get.offAll(() => LoginScreen());
        if (PrefrenceDataController.to.token.value != '' && PrefrenceDataController.to.token.value != null) {
          Get.offAll(() => const HomeController());
        } else {
          Get.offAll(() => const LoginScreen());
          // return const LoginScreen();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/img/splash_bg.png'), fit: BoxFit.cover)),
        child: Center(
          child: /* Lottie.asset('assets/lottie/splash_lottie.json',
              height: 200, width: 200)*/
              Image.asset('assets/img/logo.png', height: 250, width: 250),
        ),
      ),
    );
  }
}
