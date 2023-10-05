import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/ui/custom/custom_text_form.dart';
import 'package:rashi_network/ui/custom/design_single_tap.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/views/blogs/view_all_blogs.dart';
import 'package:rashi_network/views/connect/call/call.dart';
import 'package:rashi_network/views/connect/chat/chat.dart';
import 'package:rashi_network/views/connect/history/chat_call_history.dart';
import 'package:rashi_network/views/customer_support/customer_support.dart';
import 'package:rashi_network/views/daily_horoscope/daily_horoscope.dart';
import 'package:rashi_network/views/kundali/free_kundali/enter_details.dart';
import 'package:rashi_network/views/kundali/premium_kundali/premium_kundali.dart';
import 'package:rashi_network/views/live_astrologer/live_astrologer.dart';
import 'package:rashi_network/views/wallet/wallet.dart';
import 'package:rashi_network/views/wallet/wallet_history_screen.dart';

class SearchAstrologerScreen extends StatefulWidget {
  const SearchAstrologerScreen({Key? key}) : super(key: key);

  @override
  State<SearchAstrologerScreen> createState() => _SearchAstrologerScreenState();
}

class _SearchAstrologerScreenState extends State<SearchAstrologerScreen> {
  List<Map<String, dynamic>> features = [
    {
      'title': "Wallet",
      'icon': Icons.wallet,
      'screen': const Wallet(),
    },
    {
      'title': "Wallet History",
      'icon': Icons.history,
      'screen': const WalletHistoryScreen(),
    },
    {
      'title': "Call",
      'icon': Icons.call,
      'screen': const Call(isBack: true),
    },
    {
      'title': "Chat",
      'icon': Icons.chat_bubble_outline,
      'screen': const Chat(isBack: true),
    },
    {
      'title': "Chat/Call History",
      'icon': Icons.history,
      'screen': const ChatCallHistory(),
    },
    {
      'title': "Search Astrologer",
      'icon': Icons.search,
      'screen': const LiveAstrologer(),
    },
    {
      'title': "Daily Horoscope",
      'img': 'assets/img/horoscope/Taurus.jpg',
      'screen': const DailyHoroscope(),
    },
    {
      'title': "Blogs",
      'img': 'assets/img/blog.png',
      'screen': const LatestBlogsAllView(),
    },
    {
      'title': "Free Kundli",
      'img': 'assets/img/kundali.png',
      'screen': const FreeKundaliEnterDetails(),
    },
    {
      'title': "Premium Kundali & Ask a Question",
      'img': 'assets/img/kundali.png',
      'screen': const PremiumKundaliList(),
    },
    {
      'title': "Customer Support",
      'icon': Icons.support_agent,
      'screen': const CustomerSupport(),
    },
  ];

  RxList<Map<String, dynamic>> searchList = <Map<String, dynamic>>[].obs;
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
            'Search',
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DesignFormField(
                controller: TextEditingController(),
                onChanged: (value) {
                  log(value);
                  if (value != '') {
                    searchList.clear();
                    for (var element in features) {
                      if (element['title'].toString().toLowerCase().contains(value)) {
                        searchList.add(element);
                      }
                    }
                  } else {
                    searchList.clear();
                  }
                  searchList.refresh();
                },
                hintText: 'Search',
                prefix: const Icon(Icons.search, color: AppColors.lightGrey1),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: searchList.stream,
                  builder: (context, snapshot) {
                    return searchList.isNotEmpty
                        ? ListView.builder(
                            itemCount: searchList.length,
                            padding: const EdgeInsets.all(12),
                            itemBuilder: (context, index) {
                              return DesignSingleTap(
                                isTappedNotifier: ValueNotifier(false),
                                onTap: () async {
                                  Get.to(() => searchList[index]['screen'] as Widget);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: DesignContainer(
                                    color: AppColors.white,
                                    // height: 140,
                                    child: Row(
                                      children: [
                                        searchList[index]['img'] == null
                                            ? Icon(
                                                searchList[index]['icon'],
                                                size: 28,
                                                color: AppColors.darkTeal1,
                                              )
                                            : Image.asset(searchList[index]['img'], width: 28, height: 28),
                                        const SizedBox(width: 12),
                                        Flexible(
                                          child: DesignText(
                                            searchList[index]['title'],
                                            fontSize: 14,
                                            fontWeight: 500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: features.length,
                            padding: const EdgeInsets.all(12),
                            itemBuilder: (context, index) {
                              return DesignSingleTap(
                                isTappedNotifier: ValueNotifier(false),
                                onTap: () async {
                                  Get.to(() => features[index]['screen'] as Widget);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: DesignContainer(
                                    color: AppColors.white,
                                    // height: 140,
                                    child: Row(
                                      children: [
                                        features[index]['img'] == null
                                            ? Icon(
                                                features[index]['icon'],
                                                size: 28,
                                                color: AppColors.darkTeal1,
                                              )
                                            : Image.asset(features[index]['img'], width: 28, height: 28),
                                        const SizedBox(width: 12),
                                        Flexible(
                                          child: DesignText(
                                            features[index]['title'],
                                            fontSize: 14,
                                            fontWeight: 500,
                                          ),
                                        ),
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
        ));
  }
}
