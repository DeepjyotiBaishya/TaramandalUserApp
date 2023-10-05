import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/payment_test.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/services/api/api_access.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/ui/custom/custom_text_form.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/ui/widgets/progress_circle.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/viewmodel/provider/appstate.dart';
import 'package:rashi_network/views/wallet/applly_coupen_screen.dart';
import 'package:rashi_network/views/wallet/controller/add_money_controller.dart';
import '../../utils/controller/get_profile_controller.dart';
import 'payment_information.dart';
import 'wallet_history_screen.dart';

class Wallet extends ConsumerStatefulWidget {
  const Wallet({super.key});

  @override
  ConsumerState<Wallet> createState() => _WalletState();
}

class _WalletState extends ConsumerState<Wallet> {
  final paymentText = TextEditingController();
  bool onWillPop = true;
  RxString appliedCoupen = ''.obs;

  @override
  void initState() {
    GetProfileController.to.getProfileApi(params: {});
    // TODO: implement initState
    GetAds.to.loadBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateRef);
    return WillPopScope(
      onWillPop: () async {
        return onWillPop;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColors.darkTeal2,
          title: const DesignText(
            'My Wallet',
            color: Colors.white,
            fontSize: 20,
            fontWeight: 600,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const WalletHistoryScreen());
              },
              icon: const Icon(
                Icons.history,
                size: 25,
                color: AppColors.white,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
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
        body: SingleChildScrollView(
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DesignText(
                    'Available Balance',
                    fontSize: 16,
                    fontWeight: 500,
                  ),
                  DesignText(
                    'Rs. ${GetProfileController.to.profileRes['data']?['userdetail']?['walletamount'] ?? '0.00'}',
                    fontSize: 16,
                    fontWeight: 400,
                  ),
                  const SizedBox(height: 20),
                  const DesignText(
                    'Please enter the amount',
                    fontSize: 16,
                    fontWeight: 500,
                  ),
                  const SizedBox(height: 10),
                  DesignFormField(
                    controller: paymentText,
                    hintText: 'Enter Amount',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 5),
                  const DesignText(
                    '*Note: Amount should be greater than Rs.100',
                    fontSize: 12,
                    fontWeight: 400,
                    color: AppColors.lightGrey1,
                  ),
                  const SizedBox(height: 5),
                  const DesignText(
                    '*Note: The Recharge value should be in Multiple of Rs.10.',
                    fontSize: 12,
                    fontWeight: 400,
                    color: AppColors.lightGrey1,
                  ),
                  Obx(() {
                    return appliedCoupen.value != '' ? const SizedBox(height: 20) : const SizedBox();
                  }),
                  Obx(() {
                    return appliedCoupen.value != ''
                        ? DottedBorder(
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
                                  '$appliedCoupen',
                                  fontSize: 18,
                                  fontWeight: 600,
                                  color: AppColors.darkTeal,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    appliedCoupen.value = '';
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: AppColors.darkTeal,
                                  ))
                            ]),
                          )
                        : const SizedBox();
                  }),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: DesignButtons(
                      onPressed: () async {
                        if (paymentText.text.isEmpty) {
                          showSnackBar(title: ApiConfig.error, message: 'Please Enter Amount');
                        } else if (int.parse(paymentText.text) % 10 != 0) {
                          showSnackBar(title: ApiConfig.error, message: 'Amount Should be multiple of Rs.10');
                        } else if (int.parse(paymentText.text.toString()) >= 100) {
                          // showP
                          if (appliedCoupen != '') {
                            if (int.parse(paymentText.text.toString()) >= 501) {
                              Get.to(() => ApplyCoupenScreen(
                                    amount: paymentText.text,
                                    coupen: appliedCoupen.value == 'Flat Rs.100 OFF applied' ? '100' : '0',
                                  ));
                            } else {
                              showSnackBar(title: ApiConfig.error, message: 'Amount Should be grater than Rs.500');
                            }
                          } else {
                            /*AddMoneyController.to.addMoneyApi(
                                params: {
                                  "amount": int.parse(paymentText.text),
                                },
                                success: () {
                                  log(
                                      AddMoneyController.to.addMoneyRes['data']
                                              ?['longurl'] ??
                                          "null",
                                      name: 'REDIRECT URL');
                                  if ((AddMoneyController.to.addMoneyRes['data']
                                              ?['longurl'] ??
                                          null) ==
                                      null) {
                                    showSnackBar(
                                        title: ApiConfig.error,
                                        message:
                                            'Something Went Wrong Try Again');
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InstamojoPaymentScreen(
                                            paymentRequestId: AddMoneyController
                                                .to.addMoneyRes['data']['id'],
                                            paymentRequestUrl:
                                                AddMoneyController
                                                        .to.addMoneyRes['data']
                                                    ['longurl'],
                                          ),
                                        ));
                                  }
                                },
                                error: (e) {
                                  showSnackBar(
                                      title: ApiConfig.error,
                                      message: e.toString());
                                });*/
                            Get.to(() => PaymentInformation(
                                  isCashBack: false,
                                  amount: paymentText.text,
                                ));
                          }
                        } else {
                          showSnackBar(title: ApiConfig.error, message: 'Amount Should be grater than Rs.100');
                        }

                        /*  if (kDebugMode) {
                            print(appState.userReports.user?.id?.toString());
                          }
                          if (appState.userReports.user?.email != null ||
                              appState.userReports.user?.email != '') {
                            if (double.parse(paymentText.text.trim()) <= 99) {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const ProfileUpdate(),
                              //   ),
                              // );
                              showSnackBar(
                                  title: ApiConfig.error,
                                  message: 'Amount Shout be Bigger Then 100');
                            } else {
                              setState(() => onWillPop = false);
                              ApiAccess()
                                  .walletAddMoney(paymentText.text.trim(),
                                      userReports: appState.userReports)
                                  .then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InstamojoPaymentScreen(
                                        paymentRequestId: '',
                                        paymentRequestUrl: value,
                                      ),
                                    )).then((value) {
                                  final Uri url = Uri.parse(value);
                                  final String paymentStatus =
                                      url.queryParameters['payment_status'] ?? '';
                                  if (paymentStatus == 'Credit') {
                                    final String paymentRequestId =
                                        url.queryParameters['payment_request_id'] ??
                                            '';
                                    final String paymentid =
                                        url.queryParameters['payment_id'] ?? '';
                                    ApiAccess()
                                        .setCurrentWallet(
                                      // amount: (num.parse(paymentText.text.trim()) +
                                      //         appState.userReports.userdetail!
                                      //             .walletamount!)
                                      //     .toString(),
                                      amount: paymentText.text.trim(),
                                      id: appState.userReports.user!.id!.toString(),
                                      paymentid: paymentid,
                                      paymentstatus: paymentStatus,
                                      paymentrequestid: paymentRequestId,
                                    )
                                        .then((value) {
                                      if (value) {
                                        setState(() => onWillPop = true);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WalletPaymentConfirmation(),
                                          ),
                                        );
                                      } else {
                                        setState(() => onWillPop = true);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PaymentFaild(),
                                          ),
                                        );
                                      }
                                    });
                                  }
                                });
                              });
                            }
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfileUpdate(),
                                ));
                          }*/
                      },
                      textLabel: 'Add Money',
                      isTappedNotifier: ValueNotifier(false),
                      colorText: Colors.white,
                      fontSize: 14,
                      fontWeight: 600,
                      color: AppColors.darkTeal,
                      child: !onWillPop
                          ? const DesignProgress(color: Colors.white)
                          : const DesignText(
                              'Add Money',
                              fontSize: 12,
                              fontWeight: 600,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const DesignText(
                    'Applicable Coupon',
                    fontSize: 16,
                    fontWeight: 500,
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      /*String text =
                            'Use code OFF${(index + 1) * 10} for a ${(index + 1) * 10}% discount on your next wallet recharge.';
                        String boldText =
                            'OFF${(index + 1) * 10}'; // the substring to be made bold
                        RegExp regExp = RegExp(boldText);
                        Match match = regExp.firstMatch(text) as Match;
                        int startIndex = match.start;
                        int endIndex = match.end;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.pink, AppColors.lightBlue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.lightGrey,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: text.substring(0, startIndex),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: boldText,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.darkTeal,
                                          ),
                                        ),
                                        TextSpan(
                                          text: text.substring(endIndex),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    child: DesignButtons(
                                      onPressed: () async {},
                                      textLabel: 'Apply',
                                      isTappedNotifier: ValueNotifier(false),
                                      sideWidth: 1,
                                      colorText: AppColors.darkTeal1,
                                      borderSide: true,
                                      colorBorderSide: AppColors.darkTeal1,
                                      fontSize: 12,
                                      pdleft: 18,
                                      pdright: 18,
                                      color: Colors.transparent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );*/

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            if (index == 0) {
                              appliedCoupen.value = """Flat Rs.100 OFF applied""";
                            } else {
                              showSnackBar(title: ApiConfig.error, message: 'Coupon is not Applicable');
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(index == 0
                                ? 'assets/img/coupons.jpg'
                                : index == 1
                                    ? 'assets/img/OFF10.png'
                                    : 'assets/img/OFF20.png'),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
