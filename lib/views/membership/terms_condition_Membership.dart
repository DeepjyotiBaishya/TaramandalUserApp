import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';

import '../connect/chat/enter_detail_chat_Screen.dart';

class TermsAndConditionMembership extends StatefulWidget {
  const TermsAndConditionMembership({super.key});

  @override
  State<TermsAndConditionMembership> createState() =>
      _TermsAndConditionMembershipState();
}

class _TermsAndConditionMembershipState
    extends State<TermsAndConditionMembership> {
  List terms = [
    'Membership plans are valid for one year from the date of purchase.',
    "There are no refunds for membership plans.",
    "User cannot transfer the membership amount to another user.",
    "The offer will only be valid when the money does not exceed Rs.10,000",
    'The membership will only reflect in wallet you cannot redeem the money from the wallet.'
  ];
  @override
  void initState() {
    // TODO: implement initState
    GetAds.to.loadBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Terms and Conditions',
          color: Colors.white,
          fontSize: 20,
          fontWeight: 600,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: FloatingActionButton.extended(
              backgroundColor: AppColors.darkTeal,
              onPressed: () {
                Get.back();
              },
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              label: const DesignText(
                "Go Back",
                color: Colors.white,
                fontSize: 14,
                fontWeight: 600,
              )),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70,
        color: Colors.white,
        child: AdWidget(
          ad: GetAds.to.bannerAd,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView.builder(
          itemCount: terms.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DesignText(
                    "${index + 1}.",
                    fontSize: 14,
                    fontWeight: 600,
                  ),
                  const SizedBox(width: 8.0),
                  Flexible(
                    child: DesignText(
                      terms[index],
                      fontSize: 14,
                      fontWeight: 500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
