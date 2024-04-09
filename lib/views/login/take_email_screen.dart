import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rashi_network/services/api/api_access.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/services/firebase/auth_servoces.dart';
import 'package:rashi_network/services/secure.dart';
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/ui/widgets/progress_circle.dart';
import 'package:rashi_network/utils/commonWidget.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/utils/design_utlis.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/views/home_controller.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../profile/my_Account.dart';
import 'Controller/update_email_controller.dart';

class TakeEmailScreen extends StatefulWidget {
  @override
  State<TakeEmailScreen> createState() => _TakeEmailScreenState();
}

class _TakeEmailScreenState extends State<TakeEmailScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _referralCode = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool terms = false.obs;
  RxBool notified = false.obs;
  @override
  Widget build(BuildContext context) {
    //HomeController
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Enter details',
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
          height: 48,
          width: double.infinity,
          child: FloatingActionButton.extended(
              backgroundColor: AppColors.darkTeal,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (terms.value) {
                    log(PrefrenceDataController.to.id.value, name: 'ID USER');
                    UpdateEmailController.to.updateEmailApi(
                        params: {
                          "email": _email.text,
                          "id": PrefrenceDataController.to.id.value,
                          'referral': _referralCode.text,
                        },
                        success: () {
                          Get.to(() => const MyAccountScreen());
                        },
                        error: (e) {
                          // Get.offAll(() => const HomeController());
                          showSnackBar(title: ApiConfig.error, message: e.toString());
                        });
                  } else {
                    showSnackBar(title: ApiConfig.error, message: 'Please Accept Terms And Condition.');
                  }
                }
              },
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              label: const DesignText(
                "Continue",
                color: Colors.white,
                fontSize: 14,
                fontWeight: 600,
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _email,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Field Can't be empty";
                  } else if (!_email.text.isEmail) {
                    return "Enter Valid Email";
                  }
                  return null;
                },
                onTapOutside: (event) {
                  final currentFocus = FocusScope.of(context);
                  if (currentFocus.focusedChild != null) {
                    currentFocus.focusedChild!.unfocus();
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Enter email*',
                  // hintText: 'Enter Your Email or Phone no',
                  filled: true,
                  isDense: true,

                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: EdgeInsets.all(16),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.darkGrey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightGrey3, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightGrey3, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.tapRed, width: 2.0),
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _referralCode,
                onTapOutside: (event) {
                  final currentFocus = FocusScope.of(context);
                  if (currentFocus.focusedChild != null) {
                    currentFocus.focusedChild!.unfocus();
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Referral Code (Optional)',
                  // hintText: 'Enter Your Email or Phone no',
                  filled: true,
                  isDense: true,

                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: EdgeInsets.all(16),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.darkGrey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightGrey3, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightGrey3, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.tapRed, width: 2.0),
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  commonCheckBox(value: terms),
                  RichText(
                    // textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(fontSize: 12.0, color: AppColors.lightGrey1, fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'I agree to the ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms And Conditions',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkTeal,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => DesignUtlis.launchURL(
                                  'https://www.thetaramandal.com/privacy-policy',
                                  mode: LaunchMode.inAppWebView,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  commonCheckBox(value: notified),
                  RichText(
                    // textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(fontSize: 12.0, color: AppColors.lightGrey1, fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'I want to get notified for offers and coupons',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpInput extends StatefulWidget {
  const OtpInput({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;
  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late bool _isEmpty;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _isEmpty = widget.textEditingController.text.isEmpty;
    _focusNode = FocusNode();
    widget.textEditingController.addListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    setState(() {
      _isEmpty = widget.textEditingController.text.isEmpty;
    });
  }

  void _handleBackspace(RawKeyEvent event) {
    if (_isEmpty && event.logicalKey == LogicalKeyboardKey.backspace) {
      _focusNode.requestFocus();
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_handleTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: RawKeyboardListener(
          focusNode: _focusNode,
          onKey: _handleBackspace,
          child: TextFormField(
            controller: widget.textEditingController,
            onChanged: (value) {
              if (value.length == 1) {
                _focusNode.nextFocus();
                FocusScope.of(context).nextFocus();
              } else {
                _focusNode.nextFocus();
                FocusScope.of(context).previousFocus();
              }
            },
            onTapOutside: (event) {
              final currentFocus = FocusScope.of(context);
              if (currentFocus.focusedChild != null) {
                currentFocus.focusedChild!.unfocus();
              }
            },
            onFieldSubmitted: (_) {
              _focusNode.nextFocus();
              FocusScope.of(context).nextFocus();
            },
            onEditingComplete: () {
              _focusNode.nextFocus();
              FocusScope.of(context).nextFocus();
            },
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "";
              }
              return null;
            },
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              filled: true,
              errorStyle: TextStyle(height: 0, color: Colors.transparent),
              isDense: true,
              fillColor: Colors.transparent,
              // hintStyle: TextStyle(color: DesignColor.darkGrey),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.darkGrey, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey3, width: 1.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightGrey3, width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.tapRed, width: 1.0),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ),
    );
  }
}
