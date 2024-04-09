import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';
import 'package:rashi_network/services/shared_prefrence/prefrence_helper.dart';

class AddMoneyController extends GetxController {
  static AddMoneyController get to => Get.put(AddMoneyController());

  RxMap<String, dynamic> addMoneyRes = <String, dynamic>{}.obs;

  // RxList waitingList = [].obs;

  Future<bool?> addMoneyApi({required Map params, Function? success, Function? error, String? page}) async {
    PrefrenceDataController.to.token.value = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token) ?? '';
    log(params.toString(), name: 'PARAMS');
    log(ApiConfig.addwalletmoney.toString(), name: 'URL');
    log(PrefrenceDataController.to.token.value.toString(), name: 'TOEKN');
    try {
      dio.Response response = await dio.Dio().post(
        ApiConfig.addwalletmoney,
        data: params,
        options: dio.Options(
          headers: {"Authorization": "Bearer ${PrefrenceDataController.to.token.value}", "Content-Type": 'application/json', "Accept": 'application/json'},
        ),
      );
      log(response.toString(), name: 'RESPONSE');

      if (response.statusCode == 200) {
        // Check if response data is not null
        if (response.data != null) {
          addMoneyRes.value = response.data;
          log(addMoneyRes.toString(), name: 'loginRes');

          // Check for the existence of 'data' in addMoneyRes
          if (addMoneyRes['data'] != null) {
            bool successStatus = addMoneyRes['data']['success'] ?? false;

            if (success != null && addMoneyRes['data'] != null && addMoneyRes['data']['paymenturl'] != null) {
              success();
            }

            if (successStatus) {
              if (success != null) {
                success();
              }
              return true;
            }
            
          } else {
            if (error != null) {
              error('Data not found in response.');
            }
          }
        } else {
          if (error != null) {
            error('Response data is null.');
          }
        }
      } else {
        print(response.data);
        if (error != null) {
          error(jsonDecode(response.data.toString())['message'] ?? 'Something went wrong..');
        }
      }
    } on dio.DioError catch (e) {
      log(e.response.toString());
      if (error != null) {
        error(e.response?.data['data'] ?? e.response?.data['message'] ?? "Something went wrong");
      }
    }
    return false;
  }

  RxMap<String, dynamic> addMoneyStatusRes = <String, dynamic>{}.obs;

  // RxList waitingList = [].obs;

  Future<bool?> addMoneyStatusApi(
      {required Map params, Function? success, Function? error, String? page}) async {
    PrefrenceDataController.to.token.value = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token) ?? '';
    log(params.toString(), name: 'PARAMS');
    log(ApiConfig.walletpaymentstatus.toString(), name: 'URL');
    log(PrefrenceDataController.to.token.value.toString(), name: 'TOEKN');
    try {
      dio.Response response = await dio.Dio().post(
          ApiConfig.walletpaymentstatus,
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {
              "Authorization": "Bearer ${PrefrenceDataController.to.token
                  .value}"
            },
          ));
      log(response.toString(), name: 'RESPONSE');

      if (response.statusCode == 200) {
        addMoneyStatusRes.value = response.data;
        log(addMoneyStatusRes.toString(), name: 'addMoneyStatusRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (addMoneyStatusRes['status']) {
            if (success != null) {
              success();
            }
          } else {
            if (error != null) {
              error(addMoneyStatusRes['message'] ?? 'Something went Wrong..');
            }
          }

          return true;
        } else {
          if (error != null) {
            error(addMoneyStatusRes['message'] ?? 'Something went Wrong..');
          }
          return false;
        }
      } else {
        print(response.data);
        if (error != null) {
          error(addMoneyStatusRes['message'] ?? 'Something went Wrong..');
        }
      }
    } on dio.DioError catch (e) {
      log(e.response!.data.toString());
      if (error != null) {
        error("Something went wrong");
      }
    }
    return null;
  }
}