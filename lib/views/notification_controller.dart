import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';
import '../services/api/api_service.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.put(NotificationController());

  RxMap<String, dynamic> userNotificationRes = <String, dynamic>{}.obs;

  Future<bool?> userNotificationApi(
      {required Map<String, dynamic> data,
        Function? success,
        Function? error,
        String? page}) async {
    try {
      dio.Response response = await dio.Dio().post(
        ApiConfig.usernotification,
        data: data,
        options: dio.Options(headers: {
          'Authorization': 'Bearer ${PrefrenceDataController.to.token.value}',
          'Accept': 'application/json'
        }),
      );

      if (response.statusCode == 200) {
        userNotificationRes.value = response.data;
        log(userNotificationRes.toString(), name: 'userNotificationApi');
        if (response.data != null) {
          var status = userNotificationRes['status'];

          if (status != null && status is String && status.toLowerCase() == 'true') {
            if (success != null) {
              success();
            }
            return true;
          } else {
            if (error != null) {
              error(userNotificationRes['message'] ?? "Something went wrong");
            }
          }
        } else {
          if (error != null) {
            error(userNotificationRes['message'] ?? "Something went wrong");
          }
          return false;
        }
      } else {
        print(response.data);
        if (error != null) {
          error("Something went wrong");
        }
      }
    } on dio.DioError catch (e) {
      if (error != null) {
        log((e.message ?? "").toString(), name: 'ERROR');
        log((e.response?.data ?? "").toString(), name: 'ERROR');
        error(
            (e.response?.data['message'] ?? "Something went wrong").toString());
      }
    }
    return null;
  }
}