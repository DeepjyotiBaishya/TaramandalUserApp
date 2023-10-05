import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';
import 'package:rashi_network/services/shared_prefrence/prefrence_helper.dart';

class SignUpAsAstrologerController extends GetxController {
  static SignUpAsAstrologerController get to => Get.put(SignUpAsAstrologerController());

  RxMap<String, dynamic> signUpasAstrologerRes = <String, dynamic>{}.obs;
  // RxList waitingList = [].obs;

  Future<bool?> signUpasAstrologerApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    PrefrenceDataController.to.token.value = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token) ?? '';
    log(PrefrenceDataController.to.token.value.toString(), name: 'TOEKN');
    try {
      dio.Response response = await dio.Dio().post(ApiConfig.contactUs,
          data: params,
          options: dio.Options(
            contentType: dio.Headers.jsonContentType,
            headers: {"Authorization": "Bearer ${PrefrenceDataController.to.token.value}"},
          ));

      if (response.statusCode == 200) {
        signUpasAstrologerRes.value = response.data;
        log(signUpasAstrologerRes.toString(), name: 'signUpasAstrologerRes');

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
        error(e.response?.data['message'] ?? "Something went wrong");
      }
    }
    return null;
  }
}
