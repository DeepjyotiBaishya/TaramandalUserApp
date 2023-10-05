import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';
import 'package:rashi_network/services/shared_prefrence/prefrence_helper.dart';

class CallController extends GetxController {
  static CallController get to => Get.put(CallController());

  RxMap<String, dynamic> callAstrologerRes = <String, dynamic>{}.obs;
  // RxList waitingList = [].obs;

  Future<bool?> callAstrologerApi(
      {Function? success, Function? error, required Map params}) async {
    PrefrenceDataController.to.token.value = await PreferencesHelper()
            .getPreferencesStringData(PreferencesHelper.token) ??
        '';

    log(ApiConfig.callastrologer.toString(), name: 'URL');
    log(params.toString(), name: 'PARAMS');
    log(PrefrenceDataController.to.token.value.toString(), name: 'TOEKN');
    try {
      // dio.options.headers['content-Type'] = 'application/x-www-form-urlencoded';
      // dio.Dio().options.headers['content-Type'] = 'application/json';
      // dio.Dio().options.headers["authorization"] =
      //     "Bearer ${PrefrenceDataController.to.token.value}";
      dio.Response response = await dio.Dio().post(ApiConfig.callastrologer,
          data: params,
          options: dio.Options(
            contentType: 'application/json',
            // contentType: dio.Headers.jsonContentType,
            // responseType: dio.ResponseType.json,
            headers: {
              // "Content-Type": "application/json",
              // "Accept": "application/json",
              "Authorization":
                  "Bearer ${PrefrenceDataController.to.token.value}"
            },
          ));
      log(response.toString(), name: 'RESPONSE');

      if (response.statusCode == 200) {
        callAstrologerRes.value = response.data;
        log(callAstrologerRes.toString(), name: 'CALL ASTOLOGER API');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (response.data['status']) {
            if (success != null) {
              success();
            }
          } else {
            if (error != null) {
              error(jsonDecode(response.data.toString())['message'] ??
                  'Something went Wrong..');
            }
          }

          return true;
        } else {
          if (error != null) {
            error(jsonDecode(response.data.toString())['message'] ??
                'Something went Wrong..');
          }
          return false;
        }
      } else {
        print(response.data);
        if (error != null) {
          error(jsonDecode(response.data.toString())['message'] ??
              'Something went Wrong..');
        }
      }
    } on dio.DioError catch (e) {
      log(e.message.toString());
      if (error != null) {
        error("Something went wrong");
      }
    }
    return null;
  }

  // in-progress - in process
  //completed  - call completed
  //failed - user decline
  //no-answer - astrologer decline

  ///call status
  RxMap<String, dynamic> callStatusRes = <String, dynamic>{}.obs;

  Future<bool?> callStatusApi(
      {Function? success,
      Function? error,
      required String astologerID,
      required String callID}) async {
    PrefrenceDataController.to.token.value = await PreferencesHelper()
            .getPreferencesStringData(PreferencesHelper.token) ??
        '';

    log(ApiConfig.currentcallstatus.toString(), name: 'URL');
    log(astologerID.toString(), name: 'astologerID');
    log(callID.toString(), name: 'CAll ID');
    log(PrefrenceDataController.to.token.value.toString(), name: 'TOEKN');
    try {
      dio.Response response = await dio.Dio().post(ApiConfig.currentcallstatus,
          data: {"astrologerid": astologerID, "callid": callID},
          options: dio.Options(
            headers: {
              "Authorization":
                  "Bearer ${PrefrenceDataController.to.token.value}"
            },
          ));
      log(response.toString(), name: 'RESPONSE');

      if (response.statusCode == 200) {
        callStatusRes.value = response.data;
        log(callStatusRes.toString(), name: 'callStatusRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (response.data['status']) {
            if (success != null) {
              success();
            }
          } else {
            if (error != null) {
              error(jsonDecode(response.data.toString())['message'] ??
                  'Something went Wrong..');
            }
          }

          return true;
        } else {
          if (error != null) {
            error(jsonDecode(response.data.toString())['message'] ??
                'Something went Wrong..');
          }
          return false;
        }
      } else {
        print(response.data);
        if (error != null) {
          error(jsonDecode(response.data.toString())['message'] ??
              'Something went Wrong..');
        }
      }
    } on dio.DioError catch (e) {
      log(e.message.toString());
      if (error != null) {
        error("Something went wrong");
      }
    }
    return null;
  }
}
