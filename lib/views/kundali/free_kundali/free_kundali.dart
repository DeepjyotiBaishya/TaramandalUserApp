import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/ui/custom/custom_text_form.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/views/cart/payment_confirmation.dart';

import 'details_check.dart';
import 'enter_details.dart';

class FreeKundali extends StatefulWidget {
  const FreeKundali({super.key});

  @override
  State<FreeKundali> createState() => _FreeKundaliState();
}

class _FreeKundaliState extends State<FreeKundali> {
  RxList recentList = ['1', '1', '1', '1', '1', '1'].obs;
  RxInt selected = (-1).obs;

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
          'Enter Details',
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
        child: Obx(() {
          return SizedBox(
            height: 45,
            width: double.infinity,
            child: (selected.value > -1)
                ? FloatingActionButton.extended(
                    backgroundColor: AppColors.darkTeal,
                    onPressed: () {
                      // Get.to(() => const FreeKundaliEnterDetails());
                      // Get.to(() =>  FreeKundaliDetails());
                    },
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    label: Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const DesignText(
                        "Continue",
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: 700,
                      ),
                    ))
                : SizedBox(),
          );
        }),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70,
        color: Colors.white,
        child: AdWidget(
          ad: GetAds.to.bannerAd,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: DesignButtons(
                onPressed: () async {
                  Get.to(() => const FreeKundaliEnterDetails());
                },
                textLabel: 'Create new',
                isTappedNotifier: ValueNotifier(false),
                sideWidth: 1,
                colorText: AppColors.darkTeal1,
                borderSide: true,
                colorBorderSide: AppColors.darkTeal1,
                fontSize: 16,
                fontWeight: 700,
                color: Colors.transparent,
              ),
            ),

            // AdWidget(ad: GetAds.to.bannerAd),
            SizedBox(
              height: 20,
            ),
            /*const DesignText(
              'Recent Created',
              fontSize: 16,
              fontWeight: 600,
            ),
            const SizedBox(height: 8),
            Obx(() {
              return Column(
                children: recentList.isEmpty
                    ? [
                        Image.asset('assets/img/no_data.png',
                            height: 120, width: 120),
                        SizedBox(height: 20),
                        DesignText(
                          "Ohhh!! There is no Recent Details",
                          fontSize: 18,
                          fontWeight: 400,
                          color: AppColors.lightGrey1,
                        ),
                      ]
                    : List.generate(
                        recentList.length,
                        (index) => InkWell(
                          onTap: () {
                            selected.value = index;
                            selected.refresh();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: StreamBuilder(
                                stream: selected.stream,
                                builder: (context, snapshot) {
                                  return Container(
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: selected.value == index
                                                ? AppColors.darkTeal
                                                : AppColors.lightGrey2)),
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const DesignText(
                                            'Deepak Jha ',
                                            fontSize: 16,
                                            fontWeight: 500,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          const DesignText(
                                            '05 May 1999,03:02 AM \nMumbai, Maharashtra, India',
                                            fontSize: 14,
                                            fontWeight: 500,
                                            color: AppColors.lightGrey1,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 35,
                                                width: 100,
                                                child: DesignButtons(
                                                  onPressed: () async {
                                                    Get.to(() =>
                                                        FreeKundaliEnterDetails(
                                                          name: 'Deepak Jha ',
                                                          location:
                                                              '05 May 1999,03:02 AM Mumbai, Maharashtra, India',
                                                          gender: 'Male',
                                                        ));
                                                  },
                                                  textLabel: 'Edit',
                                                  isTappedNotifier:
                                                      ValueNotifier(false),
                                                  sideWidth: 1,
                                                  colorText:
                                                      AppColors.darkTeal1,
                                                  borderSide: true,
                                                  colorBorderSide:
                                                      AppColors.darkTeal1,
                                                  fontSize: 12,
                                                  fontWeight: 700,
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              SizedBox(
                                                height: 35,
                                                width: 100,
                                                child: DesignButtons(
                                                  onPressed: () async {
                                                    recentList.removeAt(index);
                                                    selected.value == index
                                                        ? selected.value = -1
                                                        : selected.value;
                                                  },
                                                  textLabel: 'Remove',
                                                  isTappedNotifier:
                                                      ValueNotifier(false),
                                                  sideWidth: 1,
                                                  colorText:
                                                      AppColors.darkTeal1,
                                                  borderSide: true,
                                                  colorBorderSide:
                                                      AppColors.darkTeal1,
                                                  fontSize: 12,
                                                  fontWeight: 700,
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ]),
                                  );
                                }),
                          ),
                        ),
                      ),
              );
            }),*/
            SizedBox(
              height: 60,
            ),
          ]),
        ),
      ),
    );
  }
}
