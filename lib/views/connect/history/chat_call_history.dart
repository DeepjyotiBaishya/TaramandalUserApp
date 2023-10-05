import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/views/connect/history/call_history.dart';
import 'package:rashi_network/views/connect/history/chat_history.dart';

import 'consultation_history.dart';

class ChatCallHistory extends StatefulWidget {
  const ChatCallHistory({super.key});

  @override
  State<ChatCallHistory> createState() => _ChatCallHistoryState();
}

class _ChatCallHistoryState extends State<ChatCallHistory> {
  int isChat = 0;
  PageController controller = PageController(initialPage: 0);
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
          'History',
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
      bottomNavigationBar: GetAds.to.isBannerAdReady.value
          ? Container(
              width: double.infinity,
              height: 70,
              color: Colors.white,
              child: AdWidget(
                ad: GetAds.to.bannerAd,
              ),
            )
          : SizedBox(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DesignButtons(
                    onPressed: () async {
                      controller.animateToPage(0,
                          duration: Duration(microseconds: 10),
                          curve: Curves.bounceIn);

                      setState(() => isChat = 0);
                    },
                    textLabel: 'Call',
                    isTappedNotifier: ValueNotifier(false),
                    sideWidth: 1,
                    colorText: AppColors.darkTeal1,
                    borderSide: true,
                    colorBorderSide: Colors.transparent,
                    fontSize: 12,
                    fontWeight: 700,
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: DesignButtons(
                    onPressed: () async {
                      controller.animateToPage(1,
                          duration: Duration(microseconds: 10),
                          curve: Curves.bounceIn);
                      setState(() => isChat = 1);
                    },
                    textLabel: 'Chat',
                    isTappedNotifier: ValueNotifier(false),
                    sideWidth: 1,
                    colorText: AppColors.darkTeal1,
                    borderSide: true,
                    colorBorderSide: Colors.transparent,
                    fontSize: 12,
                    fontWeight: 700,
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: DesignButtons(
                    onPressed: () async {
                      controller.animateToPage(2,
                          duration: Duration(microseconds: 10),
                          curve: Curves.bounceIn);
                      setState(() => isChat = 2);
                    },
                    textLabel: 'Consultation',
                    isTappedNotifier: ValueNotifier(false),
                    sideWidth: 1,
                    colorText: AppColors.darkTeal1,
                    borderSide: true,
                    colorBorderSide: Colors.transparent,
                    fontSize: 12,
                    fontWeight: 700,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
              child: Stack(
                children: [
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey4,
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: isChat == 0
                                ? AppColors.darkTeal
                                : AppColors.lightGrey4,
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: (isChat == 1)
                                ? AppColors.darkTeal
                                : AppColors.lightGrey4,
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: (isChat == 2)
                                ? AppColors.darkTeal
                                : AppColors.lightGrey4,
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) => setState(() => isChat = value),
                children: [
                  const CallHistory(),
                  const ChatHistory(),
                  const ConsultationHistory()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
