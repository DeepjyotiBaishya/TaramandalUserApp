import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rashi_network/services/ad_service/get_ads.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/ui/custom/custom_text_form.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/assets_names.dart';
import 'package:rashi_network/utils/commonWidget.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/views/customer_support/support_documents_upload.dart';
import 'package:rashi_network/views/login_astrologer/controller/signup_as_astrologer_controller.dart';

import 'confirm_dialog.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();
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
          'Customer Support',
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
            onPressed: () {
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
                      showDialog(
                        context: context,
                        builder: (context) => const DocumentsSuccessDialog(
                          svgImg: AssetsName.svgLogo,
                          svgHeight: 60,
                          title2: 'Thankyou for your time , out team will contact you soon',
                          deleteText: 'Go Home',
                        ),
                      );
                    });
              }
              // Navigator.push(
              //    context,
              //    MaterialPageRoute(
              //      builder: (context) => const SupportDocumentsUpload(),
              //    ));
            },
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            label: const DesignText(
              "Submit",
              color: Colors.white,
              fontSize: 14,
              fontWeight: 600,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70,
        color: Colors.white,
        child: AdWidget(
          ad: GetAds.to.bannerAd,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
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
                hintText: 'Enter Query*',
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                minLines: 3,
                validator: (value) {
                  if (message.text.isEmpty) {
                    return "Please Enter Your Query";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
