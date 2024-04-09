import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/ui/custom/custom_text_form.dart';
import 'package:rashi_network/utils/controller/get_profile_controller.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/views/cart/payment_confirmation.dart';

import '../home.dart';
import 'controller/edit_profile_controller.dart';

class MyAccountScreen extends StatefulWidget {
  final String? name;
  final String? bDate;
  final String? bTime;
  final String? gender;
  final String? location;

  const MyAccountScreen(
      {super.key,
      this.name,
      this.bDate,
      this.bTime,
      this.gender,
      this.location});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController birthTime = TextEditingController();
  TextEditingController birthLocation = TextEditingController();
  String? gender;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate);
      setState(() {
        birthDate.text = formattedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedtime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedtime != null) {
      setState(() {
        birthTime.text = pickedtime.format(context).toString();
      });
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    log(widget.name ?? '', name: 'NAME');
    log(widget.bDate ?? '', name: 'NAME');
    log(widget.bTime ?? '', name: 'NAME');
    log(widget.location ?? '', name: 'NAME');
    name.text = widget.name ?? '';
    birthDate.text = widget.bDate ?? '';
    birthTime.text = widget.bTime ?? '';
    birthLocation.text = widget.location ?? '';
    // setState(() {
    // gender = widget.gender ?? '';
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'My Account',
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
                if (formKey.currentState!.validate()) {
                  UpdateProfileController.to.updateProfileApi(
                      params: {
                        "name": name.text,
                        "dob": birthDate.text,
                        "birthtime": birthTime.text,
                        "birthlocation": birthLocation.text,
                        "gender": gender!,
                        "city": birthLocation.text,
                        "state": birthLocation.text
                      },
                      success: () {
                        Future.delayed(
                          Duration(microseconds: 10),
                          () {
                            GetProfileController.to.getProfileApi(params: {});
                          },
                        );
                        Get.back();
                        Get.dialog(
                            barrierDismissible: false,
                            Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
                                          const Expanded(
                                            child: DesignText(
                                              'Thank You!',
                                              fontSize: 18,
                                              fontWeight: 600,
                                              color: AppColors.gold,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Get.offAll(() => HomeScreen());
                                              Get.back();
                                            },
                                            icon: const Icon(Icons.close),
                                            color: AppColors.blackBackground,
                                            padding: EdgeInsets.zero,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: DesignText(
                                          'We Have saved Your Profile Details.',
                                          fontSize: 16,
                                          fontWeight: 400,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ]),
                              ),
                            ));
                      },
                      error: (e) {
                        showSnackBar(
                            title: ApiConfig.error, message: e.toString());
                      });

                  /*Get.to(() => const FreeKundaliDetails());*/
                }
              },
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              label: Container(
                margin: const EdgeInsets.only(left: 4),
                child: const DesignText(
                  "Save",
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: 700,
                ),
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DesignFormField(
                  controller: name,
                  hintText: 'Enter name',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please Enter Your Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                DesignFormField(
                  controller: birthDate,
                  hintText: 'Enter birth date',
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please Enter Your Birth Date";
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                const SizedBox(height: 10),
                DesignFormField(
                  controller: birthTime,
                  hintText: 'Enter birth time',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please Enter Your Birth Time";
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () {
                    _selectTime(context);
                  },
                ),
                const SizedBox(height: 10),
                /* Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: AppColors.lightGrey3, width: 1.0)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const Center(
                          child: DesignText('Male',
                              fontSize: 14,
                              fontWeight: 400,
                              color: AppColors.lightGrey1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: AppColors.lightGrey3, width: 1.0)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: const Center(
                          child: DesignText('Female',
                              fontSize: 14,
                              fontWeight: 400,
                              color: AppColors.lightGrey1),
                        ),
                      ),
                    ),
                  ],
                ),*/
                DropdownButtonFormField<String>(
                  value: gender,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Field Required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Gender',
                    filled: true,
                    isDense: true,
                    fillColor: Colors.transparent,
                    // hintStyle: TextStyle(color: DesignColor.darkGrey),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    contentPadding: EdgeInsets.all(16),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.darkGrey, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.lightGrey3, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.lightGrey3, width: 1.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.tapRed, width: 2.0),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    // Update the selected gender when a new value is chosen
                    setState(() {
                      gender = newValue;
                    });
                  },
                  items: <String>['Male', 'Female'].map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                DesignFormField(
                  controller: birthLocation,
                  hintText: 'Enter birth location',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please Enter Your Location";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
