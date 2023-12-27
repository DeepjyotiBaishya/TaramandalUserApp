import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/common/common_function.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/services/api/api_access.dart';
import 'package:rashi_network/ui/custom/design_single_tap.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/controller/get_profile_controller.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/views/connect/call/astrologer_call_profile.dart';
import 'package:rashi_network/views/connect/chat/astrologer_chat_profile.dart';
import 'package:rashi_network/views/connect/chat/chat_screen.dart';
import 'package:get/get.dart';
import 'package:rashi_network/views/home/search_astrologer.dart';
import '../../utils/commonWidget.dart';
import '../connect/history/chat_screen.dart';

class LiveAstrologer extends StatefulWidget {
  const LiveAstrologer({super.key});

  @override
  State<LiveAstrologer> createState() => _LiveAstrologerState();
}

class _LiveAstrologerState extends State<LiveAstrologer> {
  @override
  void initState() {
    // TODO: implement initState
    GetAds.to.loadBannerAd();
    ApiAccess().liveAstrologer(data: {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    log('DISPOSE');
    ApiAccess().liveAstrologer(data: {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Live Astrologers',
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
        /* actions: [
          InkWell(
            onTap: () {
              // Get.to(() => const SearchAstrologerScreen());

              // Get.to(() => SearchScreen());
            },
            child: Center(
              child: Image.asset('assets/img/search.png',
                  height: 20, width: 20, fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 16,
          ),
        ],*/
      ),
      bottomNavigationBar: Obx(() {
        return GetAds.to.isBannerAdReady.value
            ? Container(
                width: double.infinity,
                height: 70,
                color: Colors.white,
                child: AdWidget(
                  ad: GetAds.to.bannerAd,
                ),
              )
            : SizedBox();
      }),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: TextFormField(
              onTapOutside: (event) {
                final currentFocus = FocusScope.of(context);
                if (currentFocus.focusedChild != null) {
                  currentFocus.focusedChild!.unfocus();
                }
              },
              onChanged: (value) {
                ApiAccess().liveAstrologer(data: {"search": value});
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                ),
                hintText: 'Search Astrologer',
                // hintText: 'Enter Your Email or Phone no',
                filled: true,
                isDense: true,

                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding: EdgeInsets.all(16),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkGrey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.lightGrey3, width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.lightGrey3, width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.tapRed, width: 2.0),
                ),
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: ApiAccess.liveAstrologers.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  return DesignSingleTap(
                    isTappedNotifier: ValueNotifier(false),
                    onTap: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AstrologerProfile(
                      //         index: index, astrologerModel: livedata),
                      //   ),
                      // );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: DesignContainer(
                        color: AppColors.white,
                        // height: 140,
                        child: Row(
                          children: [
                            Hero(
                              tag: index,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2, color: Colors.green),
                                  borderRadius: BorderRadius.circular(60), // assuming height/width is 83
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    'https://thetaramandal.com/public/astrologer/${ApiAccess.liveAstrologers[index]['photo']}',
                                    height: 83,
                                    width: 83,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: DesignText(
                                          ApiAccess.liveAstrologers[index]['name'],
                                          fontSize: 12,
                                          fontWeight: 600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: ListView.builder(
                                          itemCount: 3,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) => const Padding(
                                            padding: EdgeInsets.only(right: 6),
                                            child: DesignText('⭐'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const DesignText(
                                    'Vaastu, Horoscope', // in Live api Currently no data available like: Vaastu, Horoscope, Last Checked: 19/05/2023 Time: 1:02 PM
                                    fontSize: 10,
                                    fontWeight: 500,
                                    color: AppColors.lightGrey1,
                                  ),
                                  DesignText(
                                    astrologerLanguage(ApiAccess.liveAstrologers[index]?['language'] ??
                                        ''), // in Live api Currently no data available like: Language, Last Checked: 19/05/2023 Time: 1:02 PM i got  "language": "1,2",
                                    fontSize: 10,
                                    fontWeight: 500,
                                    color: AppColors.lightGrey1,
                                  ),
                                  DesignText(
                                    '${ApiAccess.liveAstrologers[index]['experience']} Years',
                                    fontSize: 10,
                                    fontWeight: 500,
                                    color: AppColors.lightGrey1,
                                  ),
                                  Row(
                                    children: [
                                      DesignText(
                                        'Rs.${ApiAccess.liveAstrologers[index]['call_price']}/Min',
                                        fontSize: 10,
                                        fontWeight: 500,
                                        color: AppColors.red,
                                      ),
                                      //   DesignText(
                                      //    'Rs.${livedata.chatPrice}/Min',// 'chat_price'  Last Checked: 19/05/2023 Time: 1:07 PM ; on every field i got NUll Value
                                      //   fontSize: 10,
                                      //   fontWeight: 500,
                                      //   color: DesignColor.red,
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      if (ApiAccess.liveAstrologers[index]['call']! == 'Yes')
                                        SizedBox(
                                          height: 31,
                                          width: 81,
                                          child: DesignButtons(
                                            onPressed: () async {
                                              if (double.parse((GetProfileController.to.profileRes['data']?['userdetail']?['walletamount'] ?? '0.00').toString()) <
                                                  double.parse((ApiAccess.liveAstrologers[index]['call_price'] ?? 0).toString())) {
                                                insufficientBalancePopup(context, "${double.parse((ApiAccess.liveAstrologers[index]['call_price'] ?? 0).toString())}", "call");
                                              } else {
                                                Get.to(() => AstrologerCallProfile(astrologerProfile: ApiAccess.liveAstrologers[index]));
                                              }
                                            },
                                            textLabel: 'Call',
                                            isTappedNotifier: ValueNotifier(false),
                                            sideWidth: 1,
                                            colorText: Colors.white,
                                            borderSide: true,
                                            colorBorderSide: AppColors.darkTeal1,
                                            fontSize: 12,
                                            fontWeight: 700,
                                            color: AppColors.darkTeal1,
                                          ),
                                        ),
                                      if (ApiAccess.liveAstrologers[index]['chat']! == 'Yes') const SizedBox(width: 8),
                                      if (ApiAccess.liveAstrologers[index]['chat']! == 'Yes')
                                        SizedBox(
                                          height: 31,
                                          width: 81,
                                          child: DesignButtons(
                                            onPressed: () async {
                                              if (double.parse((GetProfileController.to.profileRes['data']?['userdetail']?['walletamount'] ?? '0.00').toString()) <
                                                  double.parse((ApiAccess.liveAstrologers[index]['chat_price'] ?? 0).toString())) {
                                                insufficientBalancePopup(context, "${double.parse((ApiAccess.liveAstrologers[index]['chat_price'] ?? 0).toString())}", "chat");
                                              } else {
                                                Get.to(() => AstrologerChatProfile(astrologerProfile: ApiAccess.liveAstrologers[index], astrologer_id: ApiAccess.liveAstrologers[index]['astrologer_id'] ?? 0, name: ApiAccess.liveAstrologers[index]['name'] ?? '',));
                                              }
                                            },
                                            textLabel: 'Chat',
                                            isTappedNotifier: ValueNotifier(false),
                                            sideWidth: 1,
                                            colorText: AppColors.darkTeal1,
                                            borderSide: true,
                                            colorBorderSide: AppColors.darkTeal1,
                                            fontSize: 12,
                                            fontWeight: 700,
                                            color: Colors.transparent,
                                          ),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
