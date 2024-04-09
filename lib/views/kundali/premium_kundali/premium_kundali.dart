import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/ui/widgets/material_iconbtn.dart';
import 'package:rashi_network/utils/commonWidget.dart';
import 'package:rashi_network/utils/controller/get_profile_controller.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/views/kundali/premium_kundali/enter_detail_screen.dart';
import 'package:rashi_network/views/kundali/premium_kundali/kundali_detail.dart';

import 'ask_question.dart';

class PremiumKundaliList extends StatefulWidget {
  const PremiumKundaliList({super.key});

  @override
  State<PremiumKundaliList> createState() => _PremiumKundaliListState();
}

class _PremiumKundaliListState extends State<PremiumKundaliList> with SingleTickerProviderStateMixin {
  final text = TextEditingController();
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
          'Kundali Detail',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (double.parse((GetProfileController.to.profileRes['data']?['userdetail']?['walletamount'] ?? '0.00').toString()) < 999) {
                    insufficientBalancePopup(context, "999", "get Answer of Question & Kundly Details");
                  } else {
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          const DesignText(
                            'Payment',
                            fontSize: 18,
                            fontWeight: 600,
                            color: AppColors.gold,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: DesignText(
                              'You need to pay 1800 to access this',
                              fontSize: 16,
                              fontWeight: 400,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: DesignButtons(
                              onPressed: () async {
                                Get.back();
                                Get.to(() => const EnterDetailScreen(
                                      que: 1,
                                      opetion: 1,
                                    ));
                                // showSnackBar(title: ApiConfig.success, message: 'Payment SuccessFull...');
                              },
                              textLabel: 'Pay Now',
                              isTappedNotifier: ValueNotifier(false),
                              sideWidth: 1,
                              colorText: AppColors.white,
                              borderSide: true,
                              colorBorderSide: AppColors.darkTeal2,
                              fontSize: 12,
                              fontWeight: 700,
                              color: AppColors.darkTeal2,
                            ),
                          ),
                        ]),
                      ),
                    ));
                  }
                  /*  Get.defaultDialog(
                    backgroundColor: Colors.white,
                    content: Column(children: [
                      DesignText(
                        'Payment',
                        fontSize: 18,
                        fontWeight: 600,
                        color: AppColors.gold,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: DesignText(
                          'You need to pay 1800 to access this',
                          fontSize: 16,
                          fontWeight: 400,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                        width: 120,
                        child: DesignButtons(
                          onPressed: () async {
                            Get.back();
                            Get.to(() => const EnterDetailScreen(
                                  que: 1,
                                ));
                            showSnackBar(
                                title: ApiConfig.success,
                                message: 'Payment SuccessFull...');
                          },
                          textLabel: 'Pay Now',
                          isTappedNotifier: ValueNotifier(false),
                          sideWidth: 1,
                          colorText: AppColors.white,
                          borderSide: true,
                          colorBorderSide: AppColors.darkTeal1,
                          fontSize: 12,
                          fontWeight: 700,
                          color: AppColors.darkTeal1,
                        ),
                      ),
                    ]),
                    title: '',
                    actions: [const Text('')],
                    barrierDismissible: true,
                  );*/

                  // Get.to(() => const AskQuestionScreen());
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AskQuestionScreen(),
                    ),
                  );*/
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: AppColors.lightGrey,
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/img/premium_kundali.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DesignText(
                                  'Premium Kundali and Ask a Free question',
                                  fontSize: 16,
                                  fontWeight: 400,
                                ),
                                Row(
                                  children: [
                                    DesignText(
                                      'Rs.1800',
                                      fontSize: 12,
                                      fontWeight: 600,
                                      decoration: TextDecoration.lineThrough,
                                      // You can add other styling properties as needed
                                    ),
                                    SizedBox(width: 8),
                                    DesignText(
                                      'Rs.999',
                                      fontWeight: 600,
                                      fontSize: 16,
                                      // Add other styling properties for the discounted price
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 34,
                          //   width: 70,
                          //   child: DesignButtons(
                          //     onPressed: () async {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) =>
                          //               const KundaliPremiumDetails(),
                          //         ),
                          //       );
                          //     },
                          //     textLabel: 'Buy',
                          //     isTappedNotifier: ValueNotifier(false),
                          //     sideWidth: 1,
                          //     colorText: AppColors.darkTeal1,
                          //     borderSide: true,
                          //     colorBorderSide: AppColors.darkTeal1,
                          //     fontSize: 12,
                          //     fontWeight: 600,
                          //     color: Colors.transparent,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (double.parse((GetProfileController.to.profileRes['data']?['userdetail']?['walletamount'] ?? '0.00').toString()) < 399) {
                    insufficientBalancePopup(context, "399", "get Answer of 1 Question");
                  } else {
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          const DesignText(
                            'Payment',
                            fontSize: 18,
                            fontWeight: 600,
                            color: AppColors.gold,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: DesignText(
                              'You need to pay 399 to access this',
                              fontSize: 16,
                              fontWeight: 400,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: DesignButtons(
                              onPressed: () async {
                                Get.back();
                                Get.to(() => const EnterDetailScreen(
                                      que: 1,
                                      opetion: 2,
                                    ));
                                // showSnackBar(title: ApiConfig.success, message: 'Payment SuccessFull...');
                              },
                              textLabel: 'Pay Now',
                              isTappedNotifier: ValueNotifier(false),
                              sideWidth: 1,
                              colorText: AppColors.white,
                              borderSide: true,
                              colorBorderSide: AppColors.darkTeal2,
                              fontSize: 12,
                              fontWeight: 700,
                              color: AppColors.darkTeal2,
                            ),
                          ),
                        ]),
                      ),
                    ));
                  }
                  /*  Get.defaultDialog(
                    backgroundColor: Colors.white,
                    content: ,
                    title: '',
                    actions: [const Text('')],
                    barrierDismissible: true,
                  );*/

                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AskQuestionScreen(),
                    ),
                  );*/
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: AppColors.lightGrey,
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/img/ask_one_que.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DesignText(
                                  'Ask 1 Question',
                                  fontSize: 16,
                                  fontWeight: 400,
                                ),
                                DesignText(
                                  'Rs.399',
                                  fontSize: 14,
                                  fontWeight: 600,
                                )
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 34,
                          //   width: 70,
                          //   child: DesignButtons(
                          //     onPressed: () async {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) =>
                          //               const KundaliPremiumDetails(),
                          //         ),
                          //       );
                          //     },
                          //     textLabel: 'Buy',
                          //     isTappedNotifier: ValueNotifier(false),
                          //     sideWidth: 1,
                          //     colorText: AppColors.darkTeal1,
                          //     borderSide: true,
                          //     colorBorderSide: AppColors.darkTeal1,
                          //     fontSize: 12,
                          //     fontWeight: 600,
                          //     color: Colors.transparent,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (double.parse((GetProfileController.to.profileRes['data']?['userdetail']?['walletamount'] ?? '0.00').toString()) < 899) {
                    insufficientBalancePopup(context, "899", "get Answer of 3 Question");
                  } else {
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          const DesignText(
                            'Payment',
                            fontSize: 18,
                            fontWeight: 600,
                            color: AppColors.gold,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: DesignText(
                              'You need to pay 899 to access this',
                              fontSize: 16,
                              fontWeight: 400,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: DesignButtons(
                              onPressed: () async {
                                Get.back();
                                Get.to(() => const EnterDetailScreen(
                                      que: 3,
                                      opetion: 3,
                                    ));
                                // showSnackBar(
                                //   title: ApiConfig.success,
                                //   message: 'Payment SuccessFull...',
                                // );
                              },
                              textLabel: 'Pay Now',
                              isTappedNotifier: ValueNotifier(false),
                              sideWidth: 1,
                              colorText: AppColors.white,
                              borderSide: true,
                              colorBorderSide: AppColors.darkTeal2,
                              fontSize: 12,
                              fontWeight: 700,
                              color: AppColors.darkTeal2,
                            ),
                          ),
                        ]),
                      ),
                    ));
                  }

                  /*  Get.defaultDialog(
                    backgroundColor: Colors.white,
                    content: Column(children: [
                      DesignText(
                        'Payment',
                        fontSize: 18,
                        fontWeight: 600,
                        color: AppColors.gold,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: DesignText(
                          'You need to pay 899 to access this',
                          fontSize: 16,
                          fontWeight: 400,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                        width: 120,
                        child: DesignButtons(
                          onPressed: () async {
                            Get.back();
                            Get.to(() => const EnterDetailScreen(
                                  que: 3,
                                ));
                            showSnackBar(
                              title: ApiConfig.success,
                              message: 'Payment SuccessFull...',
                            );
                          },
                          textLabel: 'Pay Now',
                          isTappedNotifier: ValueNotifier(false),
                          sideWidth: 1,
                          colorText: AppColors.white,
                          borderSide: true,
                          colorBorderSide: AppColors.darkTeal1,
                          fontSize: 12,
                          fontWeight: 700,
                          color: AppColors.darkTeal1,
                        ),
                      ),
                    ]),
                    title: '',
                    actions: [const Text('')],
                    barrierDismissible: true,
                  );*/

                  // Get.to(() => const AskQuestionScreen());
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AskQuestionScreen(),
                    ),
                  );*/
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: AppColors.lightGrey,
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/img/ask_three_que.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DesignText(
                                  'Pack of 3 questions',
                                  fontSize: 16,
                                  fontWeight: 400,
                                ),
                                DesignText(
                                  'Rs.899',
                                  fontSize: 14,
                                  fontWeight: 600,
                                )
                              ],
                            ),
                          ),
                          /*SizedBox(
                            height: 34,
                            width: 70,
                            child: DesignButtons(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const KundaliPremiumDetails(),
                                  ),
                                );
                              },
                              textLabel: 'Buy',
                              isTappedNotifier: ValueNotifier(false),
                              sideWidth: 1,
                              colorText: AppColors.darkTeal1,
                              borderSide: true,
                              colorBorderSide: AppColors.darkTeal1,
                              fontSize: 12,
                              fontWeight: 600,
                              color: Colors.transparent,
                            ),
                          ),*/
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (double.parse((GetProfileController.to.profileRes['data']?['userdetail']?['walletamount'] ?? '0.00').toString()) < 1499) {
                    insufficientBalancePopup(context, "1499", "get Answer of 5 Question");
                  } else {
                    Get.dialog(Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          const DesignText(
                            'Payment',
                            fontSize: 18,
                            fontWeight: 600,
                            color: AppColors.gold,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: DesignText(
                              'You need to pay 1499 to access this',
                              fontSize: 16,
                              fontWeight: 400,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: DesignButtons(
                              onPressed: () async {
                                Get.back();
                                Get.to(() => const EnterDetailScreen(
                                      que: 5,
                                      opetion: 4,
                                    ));
                                // showSnackBar(
                                //   title: ApiConfig.success,
                                //   message: 'Payment SuccessFull...',
                                // );
                              },
                              textLabel: 'Pay Now',
                              isTappedNotifier: ValueNotifier(false),
                              sideWidth: 1,
                              colorText: AppColors.white,
                              borderSide: true,
                              colorBorderSide: AppColors.darkTeal2,
                              fontSize: 12,
                              fontWeight: 700,
                              color: AppColors.darkTeal2,
                            ),
                          ),
                        ]),
                      ),
                    ));
                  }
                  /*Get.defaultDialog(
                    backgroundColor: Colors.white,
                    content: Column(children: [
                      DesignText(
                        'Payment',
                        fontSize: 18,
                        fontWeight: 600,
                        color: AppColors.gold,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: DesignText(
                          'You need to pay 1499 to access this',
                          fontSize: 16,
                          fontWeight: 400,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                        width: 120,
                        child: DesignButtons(
                          onPressed: () async {
                            Get.back();
                            Get.to(() => const EnterDetailScreen(
                                  que: 5,
                                ));
                            showSnackBar(
                              title: ApiConfig.success,
                              message: 'Payment SuccessFull...',
                            );
                          },
                          textLabel: 'Pay Now',
                          isTappedNotifier: ValueNotifier(false),
                          sideWidth: 1,
                          colorText: AppColors.white,
                          borderSide: true,
                          colorBorderSide: AppColors.darkTeal1,
                          fontSize: 12,
                          fontWeight: 700,
                          color: AppColors.darkTeal1,
                        ),
                      ),
                    ]),
                    title: '',
                    actions: [const Text('')],
                    barrierDismissible: true,
                  );*/

                  // Get.to(() => const AskQuestionScreen());
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AskQuestionScreen(),
                    ),
                  );*/
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: AppColors.lightGrey,
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/img/ask_five_question.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DesignText(
                                  'Pack of 5 questions',
                                  fontSize: 16,
                                  fontWeight: 400,
                                ),
                                DesignText(
                                  'Rs.1499',
                                  fontSize: 14,
                                  fontWeight: 600,
                                )
                              ],
                            ),
                          ),
                          /*SizedBox(
                            height: 34,
                            width: 70,
                            child: DesignButtons(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const KundaliPremiumDetails(),
                                  ),
                                );
                              },
                              textLabel: 'Buy',
                              isTappedNotifier: ValueNotifier(false),
                              sideWidth: 1,
                              colorText: AppColors.darkTeal1,
                              borderSide: true,
                              colorBorderSide: AppColors.darkTeal1,
                              fontSize: 12,
                              fontWeight: 600,
                              color: Colors.transparent,
                            ),
                          ),*/
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
