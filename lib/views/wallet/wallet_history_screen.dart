import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
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

import 'controller/wallet_history_controller.dart';

class WalletHistoryScreen extends ConsumerStatefulWidget {
  const WalletHistoryScreen({super.key});

  @override
  ConsumerState<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends ConsumerState<WalletHistoryScreen> {
  @override
  void initState() {
    WalletHistoryController.to.walletHistoryApi();
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
          'Wallet History',
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
      body: Obx(() {
        return WalletHistoryController.to.walletHistoryRes.isEmpty
            ? const Center(
                child: CupertinoActivityIndicator(color: AppColors.teal),
              )
            : (WalletHistoryController.to.walletHistoryRes['data'] ?? []).isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/img/no_data.png', height: 120, width: 120),
                        const SizedBox(height: 20),
                        const DesignText(
                          "Ohhh!! There is no Wallet History",
                          fontSize: 18,
                          fontWeight: 400,
                          color: AppColors.lightGrey1,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: (WalletHistoryController.to.walletHistoryRes['data'] ?? []).length,
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
                                DesignText(
                                  WalletHistoryController.to.walletHistoryRes['data']?[index]?['Message'] ?? '',
                                  fontSize: 14,
                                  fontWeight: 600,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                DesignText(
                                  'Recharge Date: ${WalletHistoryController.to.walletHistoryRes['data']?[index]?['created_at'] ?? ''}',
                                  fontSize: 12,
                                  fontWeight: 500,
                                  color: AppColors.lightGrey1,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                DesignText(
                                  'Rs.${WalletHistoryController.to.walletHistoryRes['data']?[index]?['amount'] ?? ''}',
                                  fontSize: 12,
                                  fontWeight: 500,
                                  color: AppColors.lightGrey1,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                DesignText(
                                  (WalletHistoryController.to.walletHistoryRes['data']?[index]?['credit_debit'] ?? 0) == 1 ? 'Credited' : 'Debited',
                                  fontSize: 10,
                                  fontWeight: 500,
                                  color: (WalletHistoryController.to.walletHistoryRes['data']?[index]?['credit_debit'] ?? 0) == 1 ? AppColors.green : AppColors.red,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
      }),
    );
  }
}
