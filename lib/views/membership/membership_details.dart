import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';

import 'terms_condition_Membership.dart';

class MembershipDetails extends StatefulWidget {
  const MembershipDetails({super.key});

  @override
  State<MembershipDetails> createState() => _MembershipDetailsState();
}

class _MembershipDetailsState extends State<MembershipDetails> {
  List plan = [
    'Enjoy app with Ad free',
    'Flat 30% off on Consulation',
    'Flat 30% off on Call & Chat'
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
          'Buy Membership',
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
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70,
        color: Colors.white,
        child: AdWidget(
          ad: GetAds.to.bannerAd,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.pink, AppColors.lightBlue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.lightGrey,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const DesignText(
                        'Membership Plan',
                        fontSize: 16,
                        fontWeight: 600,
                        decoration: TextDecoration.underline,
                      ),
                      const SizedBox(height: 6),
                      ListView.builder(
                        itemCount: plan.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 4.0),
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Flexible(
                                  child: DesignText(
                                    plan[index],
                                    fontSize: 12,
                                    fontWeight: 300,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const Divider(color: AppColors.darkTeal, height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const DesignText(
                            'Rs.499',
                            fontSize: 18,
                            fontWeight: 600,
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: DesignButtons(
                              onPressed: () async {
                                Get.dialog(
                                  Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const DesignText(
                                            'Payment',
                                            fontSize: 18,
                                            fontWeight: 600,
                                            color: AppColors.gold,
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 20),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: DesignText(
                                              'You need to pay Rs.499 to access this Membership Plan',
                                              fontSize: 16,
                                              fontWeight: 400,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 120,
                                            child: DesignButtons(
                                              onPressed: () async {
                                                Get.back();
                                              },
                                              textLabel: 'Pay Now',
                                              isTappedNotifier:
                                                  ValueNotifier(false),
                                              sideWidth: 1,
                                              colorText: AppColors.white,
                                              borderSide: true,
                                              colorBorderSide:
                                                  AppColors.darkTeal2,
                                              fontSize: 12,
                                              fontWeight: 700,
                                              color: AppColors.darkTeal2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              textLabel: 'Buy now',
                              isTappedNotifier: ValueNotifier(false),
                              sideWidth: 1,
                              colorText: AppColors.darkTeal1,
                              borderSide: true,
                              colorBorderSide: AppColors.darkTeal1,
                              fontSize: 12,
                              pdleft: 18,
                              pdright: 18,
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const TermsAndConditionMembership());
              },
              child: const DesignText(
                "*Terms and conditions apply",
                fontSize: 12,
                fontWeight: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
