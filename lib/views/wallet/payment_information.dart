import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rashi_network/payment_test.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/ui/widgets/material_iconbtn.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/views/cart/cart_summary.dart';
import 'package:rashi_network/views/wallet/wallet_payment_confirmation.dart';

import 'controller/add_money_controller.dart';

class PaymentInformation extends StatefulWidget {
  final bool isCashBack;
  final String amount;
  const PaymentInformation(
      {super.key, this.isCashBack = true, required this.amount});

  @override
  State<PaymentInformation> createState() => _PaymentInformationState();
}

class _PaymentInformationState extends State<PaymentInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Payment Information',
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: FloatingActionButton.extended(
              backgroundColor: AppColors.darkTeal,
              onPressed: () {
                AddMoneyController.to.addMoneyApi(
                    params: {
                      "amount": int.parse(widget.amount),
                      "couponcode": "",
                    },
                    success: () {
                      log(
                          AddMoneyController.to.addMoneyRes['data']?['paymenturl'] ?? "null",
                          name: 'REDIRECT URL');

                      if ((AddMoneyController.to.addMoneyRes['data']?['paymenturl'] ?? null) == null) {
                        showSnackBar(
                            title: ApiConfig.error,
                            message: 'Something Went Wrong Try Again');
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CcavenuePaymentScreen(
                                paymentRequestUrl: AddMoneyController.to.addMoneyRes['data']['paymenturl'],
                              ),
                            ));
                      }
                    },
                    error: (e) {
                      showSnackBar(
                          title: ApiConfig.error, message: e.toString());
                    });
                /* Get.to(() => const WalletPaymentConfirmation());*/
              },
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              label: Container(
                margin: const EdgeInsets.only(left: 4),
                child: const DesignText(
                  "Proceed",
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: 700,
                ),
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            PriceSummaryCard(
                title: 'Recharge Amount',
                price: 'Rs.${double.parse(widget.amount).toStringAsFixed(2)}'),
            const SizedBox(height: 6),
            PriceSummaryCard(
                title: 'GST(18%)',
                price:
                    'Rs.${(double.parse(widget.amount) * 18 / 100).toStringAsFixed(2)}'),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DesignText(
                  'Payable Amount',
                  fontSize: 14,
                  fontWeight: 500,
                ),
                DesignText(
                  'Rs.${(double.parse(widget.amount) - (double.parse(widget.amount) * 18 / 100)).toStringAsFixed(2)}',
                  fontSize: 14,
                  fontWeight: 500,
                ),
              ],
            ),
            const SizedBox(height: 10),
            !widget.isCashBack
                ? SizedBox()
                : Container(
                    clipBehavior: Clip.antiAlias,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(width: 1, color: AppColors.darkTeal)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: DesignText(
                              '100 % Extra on recharge of Rs 50',
                              fontSize: 14,
                              fontWeight: 500,
                              color: AppColors.darkTeal,
                            ),
                          ),
                          MaterialIconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
            !widget.isCashBack ? SizedBox() : const SizedBox(height: 10),
            !widget.isCashBack
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.done,
                        color: AppColors.darkTeal,
                      ),
                      SizedBox(width: 6),
                      Flexible(
                        child: DesignText(
                          'Rs.50 Cashback in wallet with this recharge',
                          fontSize: 14,
                          fontWeight: 500,
                          color: AppColors.darkTeal,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
