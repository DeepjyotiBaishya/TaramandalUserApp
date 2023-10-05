import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/ui/custom/design_single_tap.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/viewmodel/provider/appstate.dart';
import 'package:rashi_network/views/connect/chat/astrologer_chat_profile.dart';
import 'package:rashi_network/views/connect/chat/chat_screen.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
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
          'Notification',
          color: Colors.white,
          fontSize: 20,
          fontWeight: 600,
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Get.to(() => const WalletHistoryScreen());
          //   },
          //   icon: Icon(
          //     Icons.history,
          //     size: 25,
          //     color: AppColors.white,
          //   ),
          // ),
          // SizedBox(
          //   width: 15,
          // ),
        ],
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
      body: true
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/no_data.png',
                      height: 120,
                      width: 120,
                    ),
                    const SizedBox(height: 20),
                    const DesignText(
                      "We Will Notify You For Your Consultation.",
                      fontSize: 18,
                      fontWeight: 400,
                      color: AppColors.lightGrey1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                return DesignSingleTap(
                  isTappedNotifier: ValueNotifier(false),
                  onTap: () async {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AstrologerProfile(index: index),
                    //   ),
                    // );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DesignContainer(
                      color: AppColors.white,
                      // height: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DesignText(
                            'Wallet Recharge Notification',
                            fontSize: 14,
                            fontWeight: 600,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          const DesignText(
                            'recharge Credit successfully on your account',
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
