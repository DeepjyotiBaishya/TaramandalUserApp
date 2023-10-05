import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';
import 'package:rashi_network/services/shared_prefrence/prefrence_helper.dart';
import 'package:rashi_network/utils/commonWidget.dart';
import 'package:rashi_network/utils/design_colors.dart';
import 'package:rashi_network/views/login/login.dart';
import 'package:rashi_network/views/profile/my_Account.dart';

class DailyHoroscopeController extends GetxController {
  static DailyHoroscopeController get to => Get.put(DailyHoroscopeController());

  RxMap<String, dynamic> dailyHoroscopeRes = <String, dynamic>{}.obs;
  // RxList waitingList = [].obs;

  String basicAuth = 'Basic ' + base64.encode(utf8.encode('625847:56873aeab4eeeea2c85101ec9d3012ac'));

  Future<bool?> getHoroscopeApi({
    required String sign,
    Function? success,
    Function? error,
  }) async {
    log('https://json.astrologyapi.com/v1/sun_sign_prediction/daily/${sign.toLowerCase()}');
    try {
      dio.Response response = await dio.Dio().post("https://json.astrologyapi.com/v1/sun_sign_prediction/daily/${sign.toLowerCase()}",
          data: {},
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {"Authorization": basicAuth, "Content-Type": "application/x-www-form-urlencoded"},
          ));
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        dailyHoroscopeRes.value = response.data;
        log(dailyHoroscopeRes.toString(), name: 'dailyHoroscopeRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data['status'] != false) {
          if (success != null) {
            success();
          }

          return true;
        } else {
          if (error != null) {
            error(response.data['error'] ?? 'Something went Wrong..');
          }
          return false;
        }
      } else {
        print(response.data);
        if (error != null) {
          error(response.data['message'] ?? 'Something went Wrong..');
        }
      }
    } on dio.DioError catch (e) {
      log(e.response?.data['msg'] ?? "Something went wrong");
      if (error != null) {
        error(e.response?.data['msg'] ?? "Something went wrong");
      }
    }
    return null;
  }
}
