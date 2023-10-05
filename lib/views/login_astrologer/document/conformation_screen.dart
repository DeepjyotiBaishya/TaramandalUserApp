import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rashi_network/utils/assets_names.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/views/home_controller.dart';

class ConformationScreen extends StatelessWidget {
  const ConformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const HomeController());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColors.darkTeal2,
          title: const DesignText(
            'Confirmation',
            color: Colors.white,
            fontSize: 20,
            fontWeight: 600,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: 45,
            width: double.infinity,
            child: FloatingActionButton.extended(
                backgroundColor: AppColors.darkTeal,
                onPressed: () {
                  Get.offAll(() => const HomeController());
                },
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                label: Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: const DesignText(
                    "Go Back",
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: 700,
                  ),
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  LottieBuilder.asset(
                    AssetsName.lottiesuccessanimation,
                    repeat: false,
                    height: 200,
                    width: 200,
                  ),
                  const DesignText(
                    'Thankyou for submitting your request',
                    fontSize: 20,
                    fontWeight: 600,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const DesignText(
                    'One of our executive will get back to you soon',
                    fontSize: 16,
                    fontWeight: 400,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
