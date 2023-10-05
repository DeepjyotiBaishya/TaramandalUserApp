import 'dart:async';
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
import 'package:rashi_network/views/bottom_controller.dart';
import 'package:rashi_network/views/cart/payment_confirmation.dart';
import 'package:rashi_network/views/home_controller.dart';

import 'controller/call_controller.dart';

class EnterDetailCallScreen extends StatefulWidget {
  final Map astrologerProfile;
  const EnterDetailCallScreen({required this.astrologerProfile});

  @override
  State<EnterDetailCallScreen> createState() => _EnterDetailCallScreenState();
}

class _EnterDetailCallScreenState extends State<EnterDetailCallScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController birthTime = TextEditingController();
  String? gender;
  String? relation;
  String? employement;

  TextEditingController profession = TextEditingController();
  TextEditingController message = TextEditingController();

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

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.darkTeal2,
        title: const DesignText(
          'Enter Details',
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
                  log(widget.astrologerProfile['is_busy'], name: 'IS BUSY');
                  if (widget.astrologerProfile['is_busy'] == 'no' && widget.astrologerProfile['available_call'] == 'yes') {
                    CallController.to.callAstrologerRes.clear();
                    CallController.to.callAstrologerApi(
                        params: {
                          "astrologerid": (widget.astrologerProfile['astrologer_id']).toString(),
                          "name": name.text,
                          "dob": birthDate.text,
                          "birthtime": birthTime.text,
                          "gender": gender!,
                          "relationshipstatus": relation!,
                          "employmentstatus": employement ?? "",
                          "profession": profession.text,
                          "message": message.text
                        },
                        success: () {
                          log(CallController.to.callAstrologerRes['data']['Call']['Sid'], name: 'CAL ID');

                          String callID = CallController.to.callAstrologerRes['data']['Call']['Sid'];

                          BottomController.to.selectedIndOfBottom.value = 0;

                          _timer = Timer.periodic(const Duration(seconds: 2),
                              (_) => CallController.to.callStatusApi(astologerID: widget.astrologerProfile['astrologer_id'].toString(), callID: callID));
                          Get.dialog(
                              Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                child: WillPopScope(
                                  onWillPop: () async {
                                    _timer?.cancel();
                                    Get.offAll(() => const HomeController());
                                    GetProfileController.to.getProfileApi(params: {});
                                    return true;
                                  },
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
                                          Obx(() {
                                            return Expanded(
                                              child: DesignText(
                                                (CallController.to.callStatusRes['data']?['Call']?['Status'] ?? '') == 'in-progress'
                                                    ? 'Connecting...'
                                                    : (CallController.to.callStatusRes['data']?['Call']?['Status'] ?? '') == 'no-answer'
                                                        ? 'Rejected...'
                                                        : (CallController.to.callStatusRes['data']?['Call']?['Status'] ?? '') == 'failed'
                                                            ? 'Failed...'
                                                            : (CallController.to.callStatusRes['data']?['Call']?['Status'] ?? '') == 'completed'
                                                                ? 'Completed...'
                                                                : (CallController.to.callStatusRes['data']?['Call']?['Status'] ?? '') == 'busy'
                                                                    ? 'Busy'
                                                                    : 'Connecting...',
                                                fontSize: 18,
                                                fontWeight: 600,
                                                color: AppColors.gold,
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }),
                                          IconButton(
                                            onPressed: () {
                                              _timer?.cancel();
                                              Get.offAll(() => const HomeController());
                                              GetProfileController.to.getProfileApi(params: {});
                                              Get.back();
                                            },
                                            icon: const Icon(Icons.close),
                                            color: AppColors.blackBackground,
                                            padding: EdgeInsets.zero,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Obx(() {
                                          return DesignText(
                                            (CallController.to.callStatusRes['data']?['Call']?['Status'] ?? '') == 'in-progress'
                                                ? 'You will receive a call'
                                                : (CallController.to.callStatusRes['data']?['Call']?['Status'] ?? '') == 'no-answer'
                                                    ? 'Your call has been rejected by Astrologer'
                                                    : (CallController.to.callStatusRes['data']?['Call']?['Status'] ?? '') == 'failed'
                                                        ? 'You have been rejected a Astrologer Call'
                                                        : (CallController.to.callStatusRes['data']?['Call']?['Status'] ?? '') == 'completed'
                                                            ? 'You has been Completed...'
                                                            : (CallController.to.callStatusRes['data']?['Call']?['Status'] ?? '') == 'busy'
                                                                ? 'Astrologer is busy try again..'
                                                                : 'You will receive a call',
                                            fontSize: 16,
                                            fontWeight: 400,
                                            textAlign: TextAlign.center,
                                          );
                                        }),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                              barrierDismissible: false);
                        },
                        error: (e) {
                          showSnackBar(title: ApiConfig.error, message: e.toString());
                        });
                  } else {
                    Get.dialog(Dialog(
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
                              const Expanded(
                                child: DesignText(
                                  'Sorry!',
                                  fontSize: 18,
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: DesignText(
                              widget.astrologerProfile['available_call'] == 'no'
                                  ? 'The Astrologer is not available for call. Select another astrologer for chatting or wait for some time and try again.'
                                  : 'The Astrologer is busy with another call. Select another astrologer for chatting or wait for some time and try again.',
                              fontSize: 16,
                              fontWeight: 400,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ]),
                      ),
                    ));
                  }
                }
              },
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              label: Container(
                margin: const EdgeInsets.only(left: 4),
                child: const DesignText(
                  "Submit",
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
                DropdownButtonFormField<String>(
                  value: relation,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Field Required";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Select Relationship status',
                    filled: true,
                    isDense: true,
                    fillColor: Colors.transparent,
                    // hintStyle: TextStyle(color: DesignColor.darkGrey),
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
                  onChanged: (String? newValue) {
                    // Update the selected gender when a new value is chosen
                    setState(() {
                      relation = newValue;
                    });
                  },
                  items: <String>['Married', 'Unmarried', 'Single', 'Divorce'].map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                ),
                /*   DesignFormField(
                  controller: relation,
                  hintText: 'Select Relationship status',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Field Can't be empty";
                    }
                    return null;
                  },
                ),*/
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: employement,
                  decoration: const InputDecoration(
                    hintText: 'Select Employment Status',
                    filled: true,
                    isDense: true,
                    fillColor: Colors.transparent,
                    // hintStyle: TextStyle(color: DesignColor.darkGrey),
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
                  onChanged: (String? newValue) {
                    // Update the selected gender when a new value is chosen
                    setState(() {
                      employement = newValue;
                    });
                  },
                  items: <String>['Working', 'Job', 'Business', 'Housewives'].map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                DesignFormField(
                  controller: profession,
                  hintText: 'Enter Profession',
                ),
                const SizedBox(height: 10),
                DesignFormField(
                  controller: message,
                  hintText: 'Enter message',
                  maxLines: 3,
                ),
                const DesignText('*Disclaimer: Please provide accurate predictions for better results', fontSize: 12, fontWeight: 400),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
