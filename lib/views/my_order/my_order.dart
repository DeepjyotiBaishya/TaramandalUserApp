import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/container.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/views/my_order/my_order_summary.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  int isChat = 0;
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
          'My Orders',
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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DesignButtons(
                  onPressed: () async {
                    setState(() => isChat = 0);
                  },
                  textLabel: 'Orders',
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
                    setState(() => isChat = 1);
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
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: isChat == 0 ? OrdersView() : ConsultationView(),
          ),
        ],
      ),
    );
  }

  Widget ConsultationView() {
    return true
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
                  "Ohhh!! you do not have any upcoming consultation",
                  fontSize: 18,
                  fontWeight: 400,
                  color: AppColors.lightGrey1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: 8,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => const MyorderSummary());
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DesignContainer(
                      blurRadius: 6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Image.network(
                              'https://media.licdn.com/dms/image/C5103AQHp4cT0ddqm_Q/profile-displayphoto-shrink_800_800/0/1578716401072?e=2147483647&v=beta&t=JS78CQMdQodi4t4Oz9IXlj6Ls0NBAZ7FV8ON-Ujpq8U',
                              height: 83,
                              width: 83,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  DesignText(
                                    'Reena Gupta',
                                    fontSize: 14,
                                    fontWeight: 600,
                                  ),
                                  DesignText(
                                    'Date: 26th April 2023',
                                    fontSize: 12,
                                    fontWeight: 400,
                                    color: AppColors.lightGrey1,
                                  ),
                                  DesignText(
                                    'Consulation Time: 1:00 am',
                                    fontSize: 12,
                                    fontWeight: 400,
                                    color: AppColors.lightGrey1,
                                  ),
                                  DesignText(
                                    'Slot Duration: 20mins',
                                    fontSize: 12,
                                    fontWeight: 400,
                                    color: AppColors.lightGrey1,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ],
                      )),
                ),
              );
            },
          );
  }

  Widget OrdersView() {
    return true
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
                  "Ohhh!! you do not have any upcoming orders",
                  fontSize: 18,
                  fontWeight: 400,
                  color: AppColors.lightGrey1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: 8,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => const MyorderSummary());
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DesignContainer(
                      blurRadius: 6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Image.network(
                              'https://media.licdn.com/dms/image/C5103AQHp4cT0ddqm_Q/profile-displayphoto-shrink_800_800/0/1578716401072?e=2147483647&v=beta&t=JS78CQMdQodi4t4Oz9IXlj6Ls0NBAZ7FV8ON-Ujpq8U',
                              height: 83,
                              width: 83,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  DesignText(
                                    '7 Ratti Evil Eye',
                                    fontSize: 14,
                                    fontWeight: 600,
                                  ),
                                  DesignText(
                                    'Delivery on: 28th April 2023 ',
                                    fontSize: 12,
                                    fontWeight: 400,
                                    color: AppColors.lightGrey1,
                                  ),
                                  DesignText(
                                    'Ordered on : 26th April 2023 ',
                                    fontSize: 12,
                                    fontWeight: 400,
                                    color: AppColors.lightGrey1,
                                  ),
                                  DesignText(
                                    'Rs.3400',
                                    fontSize: 12,
                                    fontWeight: 600,
                                    color: AppColors.lightGrey1,
                                  ),
                                  DesignText(
                                    'Delievered',
                                    fontSize: 12,
                                    fontWeight: 500,
                                    color: AppColors.green,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ],
                      )),
                ),
              );
            },
          );
  }
}
