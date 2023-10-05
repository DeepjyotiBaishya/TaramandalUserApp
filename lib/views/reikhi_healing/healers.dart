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
import 'package:rashi_network/views/reikhi_healing/healers_profile.dart';

class HealersChatList extends ConsumerStatefulWidget {
  const HealersChatList({super.key});

  @override
  ConsumerState<HealersChatList> createState() => _HealersChatListState();
}

class _HealersChatListState extends ConsumerState<HealersChatList> {
  @override
  void initState() {
    // TODO: implement initState
    GetAds.to.loadBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appStateauto = ref.watch(appStateautoDispose);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Healers',
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
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          // const SizedBox(width: 14),
        ],
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
                    "No healers available at the moment",
                    fontSize: 18,
                    fontWeight: 400,
                    color: AppColors.lightGrey1,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                return DesignSingleTap(
                  isTappedNotifier: ValueNotifier(false),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HealersProfile(index: index),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DesignContainer(
                      color: AppColors.white,
                      // height: 140,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.green),
                              borderRadius: BorderRadius.circular(
                                  60), // assuming height/width is 83
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg',
                                height: 83,
                                width: 83,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const DesignText(
                                      'Astro Kunal Khemu',
                                      fontSize: 12,
                                      fontWeight: 600,
                                    ),
                                    SizedBox(
                                      height: 20,
                                      child: ListView.builder(
                                        itemCount: 3,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            const Padding(
                                          padding: EdgeInsets.only(right: 6),
                                          child: DesignText('⭐'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const DesignText(
                                  'Vaastu, Horoscope',
                                  fontSize: 10,
                                  fontWeight: 500,
                                  color: AppColors.lightGrey1,
                                ),
                                const DesignText(
                                  'Hindi, English',
                                  fontSize: 10,
                                  fontWeight: 500,
                                  color: AppColors.lightGrey1,
                                ),
                                const DesignText(
                                  '5 Years',
                                  fontSize: 10,
                                  fontWeight: 500,
                                  color: AppColors.lightGrey1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const DesignText(
                                      'Rs.10/Min',
                                      fontSize: 10,
                                      fontWeight: 500,
                                      color: AppColors.red,
                                    ),
                                    SizedBox(
                                      height: 31,
                                      width: 81,
                                      child: DesignButtons(
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HealersProfile(index: index),
                                            ),
                                          );
                                        },
                                        textLabel: 'Select',
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
            ),
    );
  }
}
