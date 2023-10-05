import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rashi_network/utils/assets_names.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/views/home_controller.dart';

class PaymentConfirmation extends StatelessWidget {
  const PaymentConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        log('ON WILL POP');
        Get.offAll(() => const HomeController());

        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   iconTheme: const IconThemeData(color: Colors.white),
        //   backgroundColor: AppColors.darkTeal2,
        //   title: const DesignText(
        //     'Payment Confirmation',
        //     color: Colors.white,
        //     fontSize: 20,
        //     fontWeight: 700,
        //   ),
        //   shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       bottom: Radius.circular(20),
        //     ),
        //   ),
        // ),
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                LottieBuilder.asset(
                  AssetsName.lottiesuccessanimation,
                  repeat: false,
                  height: 200,
                  width: 200,
                ),
                const DesignText(
                  'Congratulations !!! ',
                  fontSize: 20,
                  fontWeight: 600,
                ),
                const SizedBox(height: 6),
                const DesignText(
                  'Your Order has been placed \nSuccessfully',
                  fontSize: 16,
                  fontWeight: 400,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
