import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';
import 'package:rashi_network/services/shared_prefrence/prefrence_helper.dart';

class UpdateProfileController extends GetxController {
  static UpdateProfileController get to => Get.put(UpdateProfileController());

  RxMap<String, dynamic> updateEmailRes = <String, dynamic>{}.obs;
  // RxList waitingList = [].obs;

  Future<bool?> updateProfileApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    try {
      PrefrenceDataController.to.token.value = await PreferencesHelper()
              .getPreferencesStringData(PreferencesHelper.token) ??
          '';
      dio.Response response = await dio.Dio().post(ApiConfig.updateprofile,
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {
              "Authorization":
                  "Bearer ${PrefrenceDataController.to.token.value}"
            },
          ));

      if (response.statusCode == 200) {
        updateEmailRes.value = response.data;
        log(updateEmailRes.toString(), name: 'updateEmailRes');

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
      log(e.message.toString());
      if (error != null) {
        error("Something went wrong");
      }
    }
    return null;
  }
}
