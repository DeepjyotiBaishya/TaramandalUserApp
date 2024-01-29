import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/services/firebase/auth_servoces.dart';
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';
import 'package:rashi_network/services/shared_prefrence/prefrence_helper.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/commonWidget.dart';
import 'package:rashi_network/utils/constants.dart';
import 'package:rashi_network/utils/controller/get_profile_controller.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/utils/design_utlis.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/viewmodel/provider/appstate.dart';
import 'package:rashi_network/views/connect/history/chat_call_history.dart';
import 'package:rashi_network/views/customer_support/customer_support.dart';
import 'package:rashi_network/views/home/home_screen.dart';
import 'package:rashi_network/views/login/login.dart';
import 'package:rashi_network/views/login_astrologer/login_astrologer.dart';
import 'package:rashi_network/views/membership/membership.dart';
import 'package:rashi_network/views/membership/membership_details.dart';
import 'package:rashi_network/views/my_order/my_order.dart';
import 'package:rashi_network/views/profile/profile_update.dart';
import 'package:rashi_network/views/wallet/wallet.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profile/my_Account.dart';
import 'refer_and_earn/refer_and_earn_screen.dart';
import 'package:in_app_review/in_app_review.dart';

class AppDrawer extends ConsumerWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appStateauto = ref.watch(appStateautoDispose);
    // final appState = ref.watch(appStateRef);

    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /* UserAccountsDrawerHeader(
              onDetailsPressed: () {
                Get.to(() => const MyAccountScreen());
              },
              decoration: const BoxDecoration(color: Colors.white),
              accountName: DesignText(
                appState.userReports.user?.name ?? '',
                fontSize: 16,
                fontWeight: 500,
              ),
              accountEmail: DesignText(
                '+91 ${appState.userReports.user?.mobile ?? ''}',
                fontSize: 16,
                fontWeight: 500,
              ),
              currentAccountPicture: Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(60)),
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToK_-LT9HmxfBNTsC0A8wfvjtfxKh3GjexbQ&usqp=CAU'),
              ),
            ),*/
            SizedBox(height: Get.height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  log(GetProfileController.to.profileRes.toString(), name: 'profileRes');
                  Get.to(() => MyAccountScreen(
                        name: GetProfileController.to.profileRes['data']?['user']?['name'] ?? '',
                        gender: GetProfileController.to.profileRes['data']?['userdetail']?['gender'] ?? '',
                        location: GetProfileController.to.profileRes['data']?['userdetail']?['birthlocation'] ?? '',
                        bTime: GetProfileController.to.profileRes['data']?['userdetail']?['birthtime'] ?? '',
                        bDate: GetProfileController.to.profileRes['data']?['userdetail']?['dob'] ?? '',
                      ));
                },
                child: Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: Get.height * 0.1,
                      width: Get.height * 0.1,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
                      child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToK_-LT9HmxfBNTsC0A8wfvjtfxKh3GjexbQ&usqp=CAU'),
                    ),
                    SizedBox(width: Get.width * 0.03),
                    Expanded(
                      child: Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DesignText(
                              GetProfileController.to.profileRes['data']?['user']?['name'] ?? '',
                              fontSize: 16,
                              fontWeight: 500,
                            ),
                            DesignText(
                              '+91 ${GetProfileController.to.profileRes['data']?['user']?['mobile'] ?? ''}',
                              fontSize: 16,
                              fontWeight: 500,
                            ),
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            // const Divider(color: DesignColor.darkTeal, height: 1),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // ListTile(
                    //   title: const DesignText(
                    //     "Home",
                    //     fontSize: 12,
                    //     fontWeight: 500,
                    //     color: AppColors.darkTeal,
                    //   ),
                    //   leading: Icon(
                    //     PhosphorIcons.house,
                    //     size: 20,
                    //     color: AppColors.darkTeal,
                    //   ),
                    //   onTap: () {
                    //     appStateauto.currentIndex = 0;
                    //     Navigator.pop(context);
                    //   },
                    // ),
                    // const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "My wallet",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: /*wallet.png*/ Image.asset('assets/img/wallet.png', height: 20, width: 20, fit: BoxFit.cover),
                      onTap: () {
                        Navigator.pop(context);
                        GetProfileController.to.getProfileApi(params: {});
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Wallet(),
                          ),
                        );
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "My Order",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: Image.asset('assets/img/my_order.png', height: 20, width: 20, fit: BoxFit.cover),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyOrders(),
                          ),
                        );
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "Chat/Call History",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: Image.asset('assets/img/history.png', height: 20, width: 20, fit: BoxFit.cover),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatCallHistory(),
                          ),
                        );
                      },
                    ),
                    /* const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "Connect with Chat",
                        fontSize: 12,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: Icon(
                        PhosphorIcons.chat,
                        size: 20,
                        color: AppColors.darkTeal,
                      ),
                      onTap: () {
                        appStateauto.currentIndex = 1;
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "Connect with Call",
                        fontSize: 12,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: Icon(
                        PhosphorIcons.phone,
                        size: 20,
                        color: AppColors.darkTeal,
                      ),
                      onTap: () {
                        appStateauto.currentIndex = 2;
                        Navigator.pop(context);
                      },
                    ),*/
                    const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "Buy Membership",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: Image.asset('assets/img/member_ship.png', height: 20, width: 20, fit: BoxFit.cover),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // builder: (context) => const Membership(),
                            builder: (context) => const MembershipDetails(),
                          ),
                        );
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),

                    ListTile(
                      title: const DesignText(
                        "Sign up/Sign In as Astrologer ",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: Image.asset('assets/img/signup_astrologer.png', height: 20, width: 20, fit: BoxFit.cover),
                      onTap: () {
                        /* signup_astro.png*/
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreenAstrologer(),
                          ),
                        );
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "Review App",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: const Icon(
                        Icons.reviews_outlined,
                        size: 20,
                        color: AppColors.darkTeal,
                      ),
                      onTap: () async {
                        final InAppReview inAppReview = InAppReview.instance;
                        if (await inAppReview.isAvailable()) {
                          Future.delayed(const Duration(seconds: 1), () {
                            inAppReview.requestReview();
                          });
                        }
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "Refer And Earn",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: const Icon(
                        Icons.share_outlined,
                        size: 20,
                        color: AppColors.darkTeal,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReferAndEarnScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "Customer Support",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: Image.asset('assets/img/customer_support.png', height: 20, width: 20, fit: BoxFit.cover),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CustomerSupport(),
                          ),
                        );
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "Terms and Conditions",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: Image.asset('assets/img/terms_condition.png', height: 20, width: 20, fit: BoxFit.cover),
                      onTap: () {
                        DesignUtlis.launchURL(
                          'https://www.thetaramandal.com/terms-conditions',
                          mode: LaunchMode.inAppWebView,
                        );
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "Privacy Policy",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: Image.asset('assets/img/privacy_policy.png', height: 20, width: 20, fit: BoxFit.cover),
                      onTap: () {
                        DesignUtlis.launchURL(
                          'https://www.thetaramandal.com/privacy-policy',
                          mode: LaunchMode.inAppWebView,
                        );
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "Delete Account",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: const Icon(
                        FontAwesomeIcons.user,
                        size: 20,
                        color: AppColors.darkTeal,
                      ),
                      onTap: () async{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon (FontAwesomeIcons.triangleExclamation),
                                  ),
                                  Text('Alert')
                                ],
                              ),
                              content: const Text('Are you sure you want to delete'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No', style: TextStyle(color: AppColors.darkTeal1)),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  child: Text('Yes', style: TextStyle(color: AppColors.darkTeal1)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),
                    ListTile(
                      title: const DesignText(
                        "Logout",
                        fontSize: 14,
                        fontWeight: 500,
                        color: AppColors.darkTeal,
                      ),
                      leading: Image.asset('assets/img/log_out.png', height: 20, width: 20, fit: BoxFit.cover),
                      onTap: () async {
                        Get.dialog(
                            barrierDismissible: false,
                            Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(mainAxisSize: MainAxisSize.min, children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: const Icon(Icons.close),
                                        color: AppColors.darkTeal,
                                        padding: EdgeInsets.zero,
                                      )
                                    ],
                                  ),
                                  /*  Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Image.asset(cat_dog_Icon,
                                            height: 120),
                                      ),*/
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      'Log Out',
                                      style: TextStyle(color: AppColors.blackBackground, fontSize: 18, fontWeight: FontWeight.w600),
                                      // style: color222222s18w600,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      'Are u sure want to Logout?',
                                      style: TextStyle(color: AppColors.blackBackground, fontSize: 16, fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(children: [
                                    Expanded(
                                      child: commonColorButton(
                                        onTap: () {
                                          Get.back();
                                        },
                                        name: 'No',
                                        border: Border.all(color: AppColors.darkTeal),
                                        color: AppColors.white,
                                        style: TextStyle(color: AppColors.darkTeal, fontSize: 18, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: commonColorButton(
                                          onTap: () async {
                                            await AuthService().signOut();
                                            PreferencesHelper().clearPreferenceData();
                                            PrefrenceDataController.to.clear();
                                            Get.offAll(() => const LoginScreen());
                                          },
                                          name: 'Yes'),
                                    )
                                  ]),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ]),
                              ),
                            ));
                        /* Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));*/
                      },
                    ),
                    const Divider(color: AppColors.darkTeal, height: 1),
                  ],
                ),
              ),
            ),
            Container(
              height: 92,
              alignment: Alignment.center,
              color: AppColors.darkTeal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 6),
                  const DesignText(
                    "Also Available on",
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: 600,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          DesignUtlis.launchURL(Constants.urlFacebook);
                        },
                        icon: const Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          DesignUtlis.launchURL(Constants.urlInstagram);
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          DesignUtlis.launchURL(Constants.urlYoutube);
                        },
                        icon: const Icon(
                          FontAwesomeIcons.youtube,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
