import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rashi_network/services/api/api_access.dart';
import 'package:rashi_network/ui/custom/custom_text_form.dart';
import 'package:rashi_network/ui/theme/buttons/buttons.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/ui/widgets/progress_circle.dart';
import 'package:rashi_network/utils/design_colors.dart';

class ProfileUpdate extends ConsumerStatefulWidget {
  const ProfileUpdate({super.key});

  @override
  ConsumerState<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends ConsumerState<ProfileUpdate> {
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final pincode = TextEditingController();
  final dob = TextEditingController();
  final selectedGender = TextEditingController();
  String? selectedGenderValue;
  bool isloading = false;
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
        dob.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColors.darkTeal2,
          title: const DesignText(
            'Profile Update',
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                DesignFormField(
                  controller: name,
                  hintText: 'Enter your name*',
                ),
                const SizedBox(height: 8),
                DesignFormField(
                  controller: email,
                  hintText: 'Enter your Email*',
                ),
                const SizedBox(height: 8),
                // DesignFormField(
                //   controller: dob,
                //   hintText: 'DOB*',
                // ),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: DesignFormField(
                    controller: dob,
                    hintText: 'DOB',
                    readOnly: true,
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedGenderValue,
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
                      selectedGender.text = newValue ?? '';
                      selectedGenderValue = newValue;
                    });
                  },
                  items: <String>['Male', 'Female'].map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                DesignFormField(
                  controller: city,
                  hintText: 'City*',
                ),
                const SizedBox(height: 8),
                DesignFormField(
                  controller: state,
                  hintText: 'State*',
                ),
                const SizedBox(height: 8),
                DesignFormField(
                  controller: pincode,
                  hintText: 'Pincode*',
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: DesignButtons(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() => isloading = true);
                        ApiAccess()
                            .profileUpdate(
                                name: name.text.trim(),
                                email: email.text.trim(),
                                city: city.text.trim(),
                                state: state.text.trim(),
                                pincode: pincode.text.trim(),
                                dob: dob.text.trim(),
                                gender: selectedGender.text)
                            .then((value) {
                          if (value) {
                            /*ApiAccess().getProfile(ref).then((value) {
                              Navigator.pop(context);
                            });*/
                          } else {
                            setState(() => isloading = false);
                          }
                        });
                      }
                    },
                    textLabel: 'Continue',
                    isTappedNotifier: ValueNotifier(false),
                    colorText: Colors.white,
                    fontSize: 14,
                    fontWeight: 600,
                    color: AppColors.darkTeal,
                    child: isloading
                        ? const DesignProgress(size: 18, color: Colors.white)
                        : const DesignText(
                            "Continue",
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: 600,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
