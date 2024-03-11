import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/ui/custom/design_single_tap.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';


import 'notification_controller.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    NotificationController.to.userNotificationApi(data: {});
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
        body: Obx(() {
          return NotificationController.to.userNotificationRes.isEmpty
              ? Center(
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
                  "Ohhh!! There is no Notification",
                  fontSize: 18,
                  fontWeight: 400,
                  color: AppColors.lightGrey1,
                ),
              ],
            ),
          )
          : ListView.builder(
            itemCount: (NotificationController.to.userNotificationRes['data'] ?? []).length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              return DesignSingleTap(
                isTappedNotifier: ValueNotifier(false),
                onTap: () async {
                  // await Get.to(() => );
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
                          '${(NotificationController.to.userNotificationRes['data']?[index]?['message'] ?? '')}',
                          fontSize: 14,
                          fontWeight: 600,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        DesignText(
                          'You received it on ${(NotificationController.to.userNotificationRes['data']?[index]?['created_at'] ?? '')}',
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
          );
        }
        )
    );
  }
}
