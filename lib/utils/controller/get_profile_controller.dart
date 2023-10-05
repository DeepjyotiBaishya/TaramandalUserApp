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

class GetProfileController extends GetxController {
  static GetProfileController get to => Get.put(GetProfileController());

  RxMap<String, dynamic> profileRes = <String, dynamic>{}.obs;
  // RxList waitingList = [].obs;

  Future<bool?> getProfileApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    try {
      PrefrenceDataController.to.token.value = await PreferencesHelper()
              .getPreferencesStringData(PreferencesHelper.token) ??
          '';
      dio.Response response = await dio.Dio().post(ApiConfig.viewprofile,
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {
              "Authorization":
                  "Bearer ${PrefrenceDataController.to.token.value}"
            },
          ));

      if (response.statusCode == 200) {
        profileRes.value = response.data;
        log(profileRes.toString(), name: 'profileRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (response.data['status']) {
            if (success != null) {
              success();
            }
          } else {
            Get.dialog(
                barrierDismissible: false,
                Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Profile',
                          style: TextStyle(
                              color: AppColors.blackBackground,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          // style: color222222s18w600,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Please Update Your Profile',
                          style: TextStyle(
                              color: AppColors.blackBackground,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      commonColorButton(
                          onTap: () async {
                            Get.to(() => const MyAccountScreen());
                          },
                          name: 'Update'),
                      const SizedBox(
                        height: 12,
                      ),
                    ]),
                  ),
                ));
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

  RxMap<String, dynamic> liveAstrologerRes = <String, dynamic>{}.obs;
  // RxList waitingList = [].obs;
  static RxList liveAstrologers = [].obs;
  Future<bool?> getLiveAstrologerApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    try {
      dio.Response response = await dio.Dio().post(
        ApiConfig.onlineastrologer,
        data: params,
        /*options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {
              "Authorization":
                  "Bearer ${PrefrenceDataController.to.token.value}"
            },
          )*/
      );

      if (response.statusCode == 200) {
        liveAstrologerRes.value = response.data;
        log(liveAstrologerRes.toString(), name: 'liveAstrologerRes');

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
