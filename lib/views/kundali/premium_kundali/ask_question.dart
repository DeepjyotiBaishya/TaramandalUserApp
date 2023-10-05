import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/ui/widgets/material_iconbtn.dart';
import 'package:rashi_network/utils/commonWidget.dart';
import 'package:rashi_network/utils/controller/get_profile_controller.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/views/home_controller.dart';
import 'package:rashi_network/views/kundali/premium_kundali/kundali_detail.dart';

import 'controller/premium_kundly_controller.dart';

class AskQuestionScreen extends StatefulWidget {
  final int que;
  final Map data;
  const AskQuestionScreen({super.key, required this.que, required this.data});

  @override
  State<AskQuestionScreen> createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    log(widget.data.toString(), name: 'PARAMS');
    super.initState();
  }

  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Enter Questions',
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
                ///call api
                ///
                if (key.currentState!.validate()) {
                  showProgress();
                  PremiumKundlyController.to.askAQuestionApi(
                      params: widget.data,
                      success: () {
                        hideProgress();

                        Get.dialog(
                          barrierDismissible: false,
                          Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: WillPopScope(
                              onWillPop: () async {
                                Get.offAll(() => const HomeController());
                                GetProfileController.to.getProfileApi(params: {});
                                return false;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(mainAxisSize: MainAxisSize.min, children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Opacity(opacity: 0, child: Icon(Icons.close, color: AppColors.lightGrey)),
                                      const Expanded(
                                        child: DesignText(
                                          'Thankyou!',
                                          fontSize: 18,
                                          fontWeight: 600,
                                          color: AppColors.gold,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Get.offAll(() => const HomeController());
                                            GetProfileController.to.getProfileApi(params: {});
                                          },
                                          child: const Icon(Icons.close, color: AppColors.lightGrey1)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: DesignText(
                                      'We Will send our response for your questions in reports.',
                                      fontSize: 16,
                                      fontWeight: 400,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        );
                      },
                      error: (e) {
                        hideProgress();
                        showSnackBar(title: ApiConfig.error, message: e.toString());
                      });
                }

                /*Get.defaultDialog(
                  onWillPop: () async {
                    Get.offAll(() => HomeController());
                    return false;
                  },
                  backgroundColor: Colors.white,
                  content:,
                  title: '',
                  actions: [const Text('')],
                  barrierDismissible: true,
                );*/
                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KundaliPremiumDetails(),
                  ),
                );*/
              },
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              label: Container(
                margin: const EdgeInsets.only(left: 4),
                child: const DesignText(
                  "Submit",
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: 600,
                ),
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*  GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KundaliPremiumDetails(),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
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
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://www.ratanrashi.com/product_images/product_292_1260_thumb.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const DesignText(
                                      'Premium Kundali',
                                      fontSize: 16,
                                      fontWeight: 400,
                                    ),
                                    DesignText(
                                      'Rs.1800',
                                      fontSize: 14,
                                      fontWeight: 600,
                                    )
                                  ],
                                ),
                              ),
                              */ /* SizedBox(
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
                              ),*/ /*
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),*/
              DesignText(
                'Ask ${widget.que} free question',
                fontSize: 16,
                fontWeight: 500,
              ),
              const SizedBox(height: 10),
              Form(
                key: key,
                child: Column(
                  children: List.generate(widget.que, (index) {
                    TextEditingController controller = TextEditingController();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: controller,
                        onChanged: (value) {
                          if (index == 0) {
                            widget.data['question1'] = value;
                            log(widget.data.toString(), name: "PARAMS $index");
                          } else if (index == 1) {
                            widget.data['question2'] = value;
                            log(widget.data.toString(), name: "PARAMS $index");
                          } else if (index == 2) {
                            widget.data['question3'] = value;
                            log(widget.data.toString(), name: "PARAMS $index");
                          } else if (index == 3) {
                            widget.data['question4'] = value;
                            log(widget.data.toString(), name: "PARAMS $index");
                          } else if (index == 4) {
                            widget.data['question5'] = value;
                            log(widget.data.toString(), name: "PARAMS $index");
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (controller.text.isEmpty) {
                            return "Question Should Not be Empty";
                          }
                          return null;
                        },
                        onTapOutside: (event) {
                          /*final currentFocus = FocusScope.of(context);
                          if (currentFocus.focusedChild != null) {
                            currentFocus.focusedChild!.unfocus();
                          }*/
                        },
                        decoration: InputDecoration(
                          hintText: 'Type question....',
                          filled: true,
                          fillColor: Colors.white,

                          //if (text.text.trim().isNotEmpty)
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          contentPadding: const EdgeInsets.all(16),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.darkGrey, width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.lightGrey3, width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.lightGrey3, width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.tapRed, width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessDialogCard extends StatelessWidget {
  const SuccessDialogCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                alignment: Alignment.topRight,
                child: MaterialIconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close))),
            const SizedBox(height: 10),
            const DesignText(
              'Thank you',
              fontSize: 18,
              fontWeight: 600,
              color: AppColors.gold,
            ),
            const SizedBox(height: 6),
            const DesignText(
              'We will send our response for your questions in reports',
              fontSize: 14,
              fontWeight: 400,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
