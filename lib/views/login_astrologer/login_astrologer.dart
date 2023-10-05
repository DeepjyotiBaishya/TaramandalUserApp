import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/ui/custom/custom_text_form.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/commonWidget.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/views/login_astrologer/controller/signup_as_astrologer_controller.dart';
import 'package:rashi_network/views/login_astrologer/document/conformation_screen.dart';
import 'package:rashi_network/views/login_astrologer/otp_screen_astrologer.dart';

import 'document/astrologer_documents_upload.dart';

class LoginScreenAstrologer extends StatefulWidget {
  const LoginScreenAstrologer({super.key});

  @override
  State<LoginScreenAstrologer> createState() => _LoginScreenAstrologerState();
}

class _LoginScreenAstrologerState extends State<LoginScreenAstrologer> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //HomeController
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Sign Up',
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
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DesignText(
                  'Welcome to Taramandal',
                  fontSize: 20,
                  fontWeight: 600,
                ),
                const SizedBox(height: 8),
                const DesignText(
                  'We are thrilled to  that you are interested to join our community of astrologer.',
                  fontSize: 14,
                  fontWeight: 400,
                  color: AppColors.lightGrey1,
                ),
                const SizedBox(height: 20),
                DesignFormField(
                  controller: name,
                  hintText: 'Enter your name*',
                  validator: (value) {
                    if (name.text.isEmpty) {
                      return "Please Enter Your Name";
                    }
                    return null;
                  },
                  // keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                DesignFormField(
                  controller: mobileNo,
                  hintText: 'Enter your mobile no*',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (mobileNo.text.isEmpty) {
                      return "Please Enter Your Mobile Number";
                    } else if (!mobileNo.text.isPhoneNumber) {
                      return "Please Enter Valid Mobile Number";
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 10),
                DesignFormField(
                  controller: email,
                  hintText: 'Enter your email*',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (email.text.isEmpty) {
                      return "Please Enter Your Email";
                    } else if (!email.text.isEmail) {
                      return "Please Enter Valid Email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                DesignFormField(
                  controller: message,
                  hintText: 'Enter your message*',
                  validator: (value) {
                    if (message.text.isEmpty) {
                      return "Please Enter Message";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: DesignButtons(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        showProgress();
                        SignUpAsAstrologerController.to.signUpasAstrologerApi(
                            params: {"name": name.text, "mbleno": mobileNo.text, "email": email.text, "message": message.text},
                            error: (e) {
                              hideProgress();
                              showSnackBar(title: ApiConfig.error, message: e.toString());
                            },
                            success: () {
                              hideProgress();
                              Get.to(() => const ConformationScreen());
                            });
                      }

                      /*  Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const OTPScreenAstrologer(),
                          ));*/
                    },
                    textLabel: 'Continue',
                    isTappedNotifier: ValueNotifier(false),
                    colorText: Colors.white,
                    fontSize: 14,
                    fontWeight: 600,
                    color: AppColors.darkTeal,
                  ),
                ),
                /*   const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: const DesignText(
                    'OR',
                    fontSize: 16,
                    fontWeight: 500,
                    color: AppColors.lightGrey1,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: DesignButtons(
                    onPressed: () async {},
                    textLabel: 'Continue with Google',
                    isTappedNotifier: ValueNotifier(false),
                    colorText: Colors.white,
                    fontSize: 14,
                    fontWeight: 600,
                    color: Colors.transparent,
                    borderSide: true,
                    colorBorderSide: AppColors.darkTeal,
                    child: Row(
                      children: [
                        SizedBox(width: 6),
                        Icon(
                          FontAwesomeIcons.google,
                          color: AppColors.darkTeal,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        DesignText(
                          'Continue with Google',
                          fontSize: 12,
                          fontWeight: 500,
                          color: AppColors.darkTeal,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: DesignButtons(
                    onPressed: () async {},
                    textLabel: 'Continue with Google',
                    isTappedNotifier: ValueNotifier(false),
                    colorText: Colors.white,
                    fontSize: 14,
                    fontWeight: 600,
                    color: Colors.transparent,
                    borderSide: true,
                    colorBorderSide: AppColors.darkTeal,
                    child: Row(
                      children: [
                        SizedBox(width: 6),
                        Icon(
                          FontAwesomeIcons.facebook,
                          color: AppColors.darkTeal,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        DesignText(
                          'Continue with Facebook',
                          fontSize: 12,
                          fontWeight: 500,
                          color: AppColors.darkTeal,
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
