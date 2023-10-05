import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/design_colors.dart';

import '../views/wallet/wallet.dart';

Widget commonCheckBox(
    {Color? activeColor,
    required RxBool value,
    ValueChanged<bool?>? onChanged}) {
  return StatefulBuilder(
    builder: (context, newState) => Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        activeColor: activeColor ?? AppColors.darkTeal,
        value: value.value,
        onChanged: onChanged ??
            (val) {
              newState(() {
                value.value = !value.value;
              });
            }),
  );
}

Widget commonColorButton(
    {required GestureTapCallback onTap,
    required String name,
    double? width,
    double? height,
    TextStyle? style,
    List<Color>? gradientColor,
    Color? color,
    double? radius,
    Border? border}) {
  return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height: height ?? 45,
        width: width ?? double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 8),
            color: color ?? AppColors.darkTeal,
            border: border),
        padding: const EdgeInsets.all(6),
        child: Center(
            child: Text(
          name,
          style: style ??
              TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
        )),
      ));
}

Future<dynamic> insufficientBalancePopup(
    BuildContext context, String rs, String callOrChat) {
  return Get.dialog(Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          children: [
            const Opacity(
              opacity: 0,
              child: IconButton(
                onPressed: null,
                icon: Icon(Icons.close),
                color: AppColors.blackBackground,
                padding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: DesignText(
                'Insufficient Balance!',
                fontSize: 16,
                fontWeight: 600,
                color: AppColors.gold,
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close),
              color: AppColors.blackBackground,
              padding: EdgeInsets.zero,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: DesignText(
            'Minimum Balance of Rs.${rs} is required to ${callOrChat} with the astrologer',
            fontSize: 16,
            fontWeight: 400,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 38,
          width: MediaQuery.of(context).size.width / 2,
          child: DesignButtons(
            onPressed: () async {
              Get.back();
              Get.to(() => const Wallet());
            },
            textLabel: 'Recharge now',
            isTappedNotifier: ValueNotifier(false),
            colorText: Colors.white,
            fontSize: 14,
            fontWeight: 600,
            color: AppColors.darkTeal,
            child: const DesignText(
              'Recharge now',
              fontSize: 12,
              fontWeight: 600,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    ),
  ));
}

Future<dynamic> showProgress() {
  return Get.defaultDialog(
      backgroundColor: Colors.white,
      content: const CupertinoActivityIndicator(
        color: AppColors.darkTeal,
        radius: 8,
      ),
      title: '',
      actions: [const Text('')],
      barrierDismissible: false);
}

void hideProgress() => Get.back();
