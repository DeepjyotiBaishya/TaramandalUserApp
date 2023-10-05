import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rashi_network/ui/custom/custom_text_form.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/controller/get_profile_controller.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/views/login_astrologer/otp_screen_astrologer.dart';
import 'package:share_plus/share_plus.dart';

import 'terms_condition_refer_earn.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  @override
  Widget build(BuildContext context) {
    //HomeController
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Refer & Earn',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/img/refere.png',
                    height: 260,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const DesignText(
                'Refer to your friend and get a cash reward of Rs.50',
                fontSize: 20,
                fontWeight: 600,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const DesignText(
                'Share this link with your friends and after they install you will get Rs.50 cash reward',
                fontSize: 14,
                fontWeight: 400,
                color: AppColors.lightGrey1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const DesignText(
                'Your referral code',
                fontSize: 20,
                fontWeight: 600,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      color: AppColors.darkTeal,
                      strokeWidth: 1,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      dashPattern: [10, 5],
                      // borderPadding: EdgeInsets.all(8),
                      child: Row(children: [
                        Expanded(
                          child: DesignText(
                            ///add referral code of User
                            GetProfileController.to.profileRes['data']?['user']?['referralcode'] ?? '' /*'TARA10'*/,
                            fontSize: 18,
                            fontWeight: 600,
                            color: AppColors.darkTeal,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: GetProfileController.to.profileRes['data']?['user']?['referralcode'] ?? '')).then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Your Referral Code Has Been Copied.")));
                              });
                            },
                            icon: const Icon(
                              Icons.copy,
                              color: AppColors.darkTeal,
                            ))
                      ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        Share.share(
                          'Check out The Taramandal - Astrology app https://play.google.com/store/apps/details?id=com.taramandal.rashi_network \n This Is my Referral Code: ${GetProfileController.to.profileRes['data']?['user']?['referralcode'] ?? ''}',
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.darkTeal,
                        child: Icon(Icons.share, color: AppColors.white),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const TermsAndConditionRefer());
                      },
                      child: const DesignText(
                        '*Terms and conditions apply',
                        fontSize: 12,
                        fontWeight: 400,
                        color: AppColors.lightGrey1,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Get.dialog(Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            const DesignText(
                              'Have referral code?',
                              fontSize: 18,
                              fontWeight: 600,
                              color: AppColors.gold,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: DesignText(
                                'Get a referral code and redeem now',
                                fontSize: 16,
                                fontWeight: 400,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DesignFormField(
                              controller: TextEditingController(),
                              hintText: 'Enter referral code',
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: Get.width / 8.5,
                              width: Get.width / 2.5,
                              child: DesignButtons(
                                onPressed: () async {
                                  Get.back();
                                },
                                textLabel: 'Redeem now',
                                isTappedNotifier: ValueNotifier(false),
                                colorText: Colors.white,
                                fontSize: 12,
                                fontWeight: 600,
                                color: AppColors.darkTeal,
                              ),
                            ),
                          ]),
                        ),
                      ));
                      /* Get.defaultDialog(
                        backgroundColor: Colors.white,
                        content: Column(children: [
                          const DesignText(
                            'Have referral code?',
                            fontSize: 18,
                            fontWeight: 600,
                            color: AppColors.gold,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: DesignText(
                              'Get a referral code and redeem now',
                              fontSize: 16,
                              fontWeight: 400,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DesignFormField(
                            controller: TextEditingController(),
                            hintText: 'Enter referral code',
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: Get.width / 8.5,
                            width: Get.width / 2.5,
                            child: DesignButtons(
                              onPressed: () async {
                                Get.back();
                              },
                              textLabel: 'Redeem now',
                              isTappedNotifier: ValueNotifier(false),
                              colorText: Colors.white,
                              fontSize: 12,
                              fontWeight: 600,
                              color: AppColors.darkTeal,
                            ),
                          ),
                        ]),
                        title: '',
                        actions: [const Text('')],
                        barrierDismissible: true,
                      );*/
                    },
                    child: const DesignText(
                      'Have referral code?',
                      fontSize: 14,
                      fontWeight: 600,
                      color: AppColors.darkTeal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
