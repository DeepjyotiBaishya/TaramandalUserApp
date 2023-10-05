import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/ui/custom/custom_text_form.dart';
import 'package:rashi_network/utils/commonWidget.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/ui/theme/text.dart';
import 'package:rashi_network/utils/snackbar.dart';
import 'package:rashi_network/views/cart/payment_confirmation.dart';
import 'package:rashi_network/views/kundali/controller/free_kundly_controller.dart';
import 'package:rashi_network/views/kundali/controller/get_chart_controller.dart';

import 'details_check.dart';

import 'package:google_places_for_flutter/google_places_for_flutter.dart';

class FreeKundaliEnterDetails extends StatefulWidget {
  final String? name;
  final String? bDate;
  final String? bTime;
  final String? gender;
  final String? location;

  const FreeKundaliEnterDetails({super.key, this.name, this.bDate, this.bTime, this.gender, this.location});

  @override
  State<FreeKundaliEnterDetails> createState() => _FreeKundaliEnterDetailsState();
}

class _FreeKundaliEnterDetailsState extends State<FreeKundaliEnterDetails> {
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

  TimeOfDay? selectedtime;
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedtime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      /*  builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },*/
    );
    if (pickedtime != null) {
      setState(() {
        birthTime.text = pickedtime.format(context).toString();
        selectedtime = pickedtime;
        log((selectedtime?.hour ?? '').toString(), name: 'HOUR');
        log((selectedtime?.minute ?? '').toString(), name: 'MIN');
      });
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    name.text = widget.name ?? '';
    birthDate.text = widget.bDate ?? '';
    birthTime.text = widget.bTime ?? '';
    birthLocation.text = widget.location ?? '';
    setState(() {
      gender = widget.gender ?? null;
    });
    super.initState();
  }

  String? girl_place_lat, girl_place_long, girl_birth_location;
  void get_girllatlong(String birth_location) async {
    final query = birth_location;
    showProgress();
    List<Location> locations = await locationFromAddress(query);
    setState(() {
      print("locations :: ${locations.toString()}");
      girl_place_lat = locations[0].latitude.toString();
      girl_place_long = locations[0].longitude.toString();
      print("girl_place_lat :: ${girl_place_lat.toString()}");
      print("girl_place_long :: ${girl_place_long.toString()}");
    });
    hideProgress();
  }

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
                  if ((girl_birth_location ?? '') == '') {
                    showSnackBar(title: ApiConfig.error, message: 'Please Select Location');
                  } else {
                    Get.to(() => FreeKundaliDetails(
                          name: name.text,
                          date: birthDate.text,
                          time: birthTime.text,
                          place: girl_birth_location ?? '',
                          longitude: girl_place_long ?? '',
                          latitude: girl_place_lat ?? '',
                          day: birthDate.text.split('/')[2],
                          month: birthDate.text.split('/')[1],
                          year: birthDate.text.split('/')[0],
                          hour: (selectedtime?.hour ?? '').toString(),
                          min: (selectedtime?.minute ?? '').toString(),
                          timeZone: DateTime.now().timeZoneOffset.toString(),
                          gender: gender ?? '',
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
                Align(
                  alignment: Alignment.center,
                  child: SearchGooglePlacesWidget(
                    placeType: PlaceType.address,
                    // PlaceType.cities, PlaceType.geocode, PlaceType.region etc
                    placeholder: 'Enter birth place',
                    apiKey: 'AIzaSyC54_RnAsutpoao87j9w-OmbawLMdKA1jo',
                    onSearch: (Place place) {},
                    onSelected: (Place place) async {
                      print('address ${place.description}');
                      setState(() {
                        girl_birth_location = place.description.toString();
                        get_girllatlong(girl_birth_location ?? "");
                      });
                    },
                  ),
                ),
                /*DesignFormField(
                  controller: birthLocation,
                  hintText: 'Enter birth location',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please Enter Your Location";
                    }
                    return null;
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
