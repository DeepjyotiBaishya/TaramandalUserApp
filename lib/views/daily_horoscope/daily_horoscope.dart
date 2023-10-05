import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/utils/commonWidget.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/viewmodel/model/horoscope_model.dart';
import 'package:rashi_network/viewmodel/provider/appstate.dart';
import 'package:rashi_network/views/GemStone/gem_stone_details.dart';
import 'package:rashi_network/views/daily_horoscope/daily_horoscope_details.dart';
import 'package:rashi_network/views/home/controller/daily_horoscope_controller.dart';

class DailyHoroscope extends ConsumerStatefulWidget {
  const DailyHoroscope({super.key});

  @override
  ConsumerState<DailyHoroscope> createState() => _DailyHoroscopeState();
}

class _DailyHoroscopeState extends ConsumerState<DailyHoroscope> {
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
          'Daily Horoscope',
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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.1,
        ),
        itemCount: HoroscopeModel.items.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final livedata = HoroscopeModel.items[index];
          return GestureDetector(
            onTap: () {
              showProgress();
              DailyHoroscopeController.to.getHoroscopeApi(
                  sign: livedata.title,
                  success: () {
                    hideProgress();
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.close)),
                            ],
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.green,
                              ),
                              image: DecorationImage(
                                image: AssetImage(livedata.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            livedata.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          DesignText(
                            'Personal Life',
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.blackBackground,
                          ),
                          DesignText(
                            DailyHoroscopeController.to.dailyHoroscopeRes['prediction']?['personal_life'] ?? '',
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.lightGrey1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          DesignText(
                            'Health',
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.blackBackground,
                          ),
                          DesignText(
                            DailyHoroscopeController.to.dailyHoroscopeRes['prediction']?['health'] ?? '',
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.lightGrey1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          DesignText(
                            'Luck',
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.blackBackground,
                          ),
                          DesignText(
                            DailyHoroscopeController.to.dailyHoroscopeRes['prediction']?['luck'] ?? '',
                            fontSize: 10,
                            fontWeight: 500,
                            color: AppColors.lightGrey1,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ]),
                      ),
                    ));
                  },
                  error: (e) {
                    hideProgress();
                    showSnackBar(title: ApiConfig.error, message: e.toString());
                  });
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DailyHoroscopeDetails(),
                ),
              );*/
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: AppColors.lightGrey,
                ),
              ),
              child: Column(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Image.asset(
                          livedata.image,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  DesignText(
                    livedata.title,
                    fontSize: 14,
                    fontWeight: 500,
                  ),
                  /* Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DesignText(
                      livedata.date,
                      fontSize: 10,
                      fontWeight: 500,
                      textAlign: TextAlign.center,
                    ),
                  ),*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
