import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';
import 'package:rashi_network/services/shared_prefrence/prefrence_helper.dart';

class WalletHistoryController extends GetxController {
  static WalletHistoryController get to => Get.put(WalletHistoryController());

  RxMap<String, dynamic> walletHistoryRes = <String, dynamic>{}.obs;
  // RxList waitingList = [].obs;

  Future<bool?> walletHistoryApi({
    Function? success,
    Function? error,
  }) async {
    PrefrenceDataController.to.token.value = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token) ?? '';
    log(PrefrenceDataController.to.token.value.toString(), name: 'TOEKN');
    try {
      dio.Response response = await dio.Dio().post(ApiConfig.wallethistory,
          data: {},
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {"Authorization": "Bearer ${PrefrenceDataController.to.token.value}"},
          ));

      if (response.statusCode == 200) {
        walletHistoryRes.value = response.data;
        log(walletHistoryRes.toString(), name: 'walletHistoryRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (response.data['status']) {
            if (success != null) {
              success();
            }
          } else {
            if (error != null) {
              error(response.data['message'] ?? 'Something went Wrong..');
            }
          }

          return true;
        } else {
          if (error != null) {
            error(response.data['message'] ?? 'Something went Wrong..');
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
      if (error != null) {
        error(e.message ?? "Something went wrong");
      }
    }
    return null;
  }
}
