import 'dart:developer';
import 'package:get/get.dart';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';
import 'package:rashi_network/services/shared_prefrence/prefrence_helper.dart';
import 'package:rashi_network/utils/constants.dart';
import 'package:rashi_network/utils/design_utlis.dart';
import 'package:rashi_network/viewmodel/model/astrologer_model.dart';
import 'package:rashi_network/viewmodel/model/banner_model.dart';
import 'package:rashi_network/viewmodel/model/free_kundali.dart';
import 'package:rashi_network/viewmodel/model/latest_blogs_model.dart';
import 'package:rashi_network/viewmodel/model/live_astrologer.dart';
import 'package:rashi_network/viewmodel/model/pr_release_model.dart';
import 'package:rashi_network/viewmodel/model/user_reports.dart';
import 'package:rashi_network/viewmodel/provider/appstate.dart';

typedef OnUploadProgress = void Function(double progressValue);
final apiProvider = Provider<ApiAccess>((ref) => ApiAccess());

class ApiAccess {
  // final Dio dio = Dio();
  Future attemptLogIn({
    required String phone,
  }) async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      dio.Response res = await dio.Dio().post(
        "${Constants.baseURL}login",
        data: {"mobile": phone, "nToken": fcmToken},
        options: Options(responseType: ResponseType.json),
      );
      if (res.data["status"]) {
        return res.data;
      }
    } on DioError catch (e) {
      // Tools.showToasts(e.response!.data["message"]);
      if (kDebugMode) {
        print(e.toString());
      }
      return "";
    }
    return "";
  }

  Future<List<BannerModel>> getBanner() async {
    try {
      var token = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token);
      dio.Response res = await dio.Dio().post(
        "https://www.thetaramandal.com/api/banner",
        // data: {"mobile": phone, "nToken": fcmToken},
        options: Options(responseType: ResponseType.json, headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (res.data["status"]) {
        print(res.data);
        var data = res.data['data'] as List;
        return data.map((ddd) => BannerModel.fromJson(ddd)).toList();
      }
      return [];
    } on DioError catch (e) {
      return [];
    }
  }

  Future<bool> verifyInstamojoPayment({
    required String paymentRequestId,
  }) async {
    try {
      dio.Response res = await dio.Dio().post(
        "https://www.instamojo.com/api/1.1/payment-requests/$paymentRequestId/",
        // data: {"mobile": phone, "nToken": fcmToken},
        options: Options(responseType: ResponseType.json, headers: {
          "X-Api-Key": "a6e17c1d98db0bfe174ff8e582ca77dd",
          "X-Auth-Token": "e63dd39b4f2a54a2e713a9564e9c0758",
        }),
      );
      if (kDebugMode) {
        print(res.data);
      }
      if (res.data["payment_request"]['status'] == 'Completed') {
        return true;
      }
      return false;
    } on DioError catch (e) {
      return false;
    }
  }

  Future orderGenerate({
    required String paymentRequestId,
  }) async {
    try {
      dio.Response res = await dio.Dio().post(
        "https://us-central1-thetaramandal-380cd.cloudfunctions.net/createOrderInstamogo",
        data: {"buyerName": "John Doe", "buyerEmail": "johndoe@fff.com", "buyerPhone": "1234567890", "amount": "10", "purpose": "Test ffsfsfsforder"},
        options: Options(
          responseType: ResponseType.json,
        ),
      );
      // print(res.data);
      if (res.statusCode == 200) {
        return res.data;
      }
      return false;
    } on DioError catch (e) {
      return false;
    }
  }

  Future<FreeKundaliModel> orderGenerateFreeKundali({
    required String coordinates,
    required String datetime,
  }) async {
    try {
      final response = await dio.Dio().post(
        'https://api.prokerala.com/token',
        data: {
          'grant_type': 'client_credentials',
          'client_id': 'f4d35d24-de04-4b28-8d10-e11894a2ef48',
          'client_secret': 'AMkGNwRhmfwUH7KfyC3CENFsF4F2sFgIf93qGo6v',
        },
      );

      final accessToken = response.data['access_token'];
      final results = await dio.Dio().get(
        'https://api.prokerala.com/v2/astrology/kundli',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        queryParameters: {
          'ayanamsa': '1',
          'coordinates': coordinates,
          'datetime': datetime,
        },
        //  'coordinates': '23.1765,75.7885',
        //   'datetime': '2023-05-16T15:32:50+05:30',
      );
      if (results.data['status'] == 'ok') {
        return FreeKundaliModel.fromJson(results.data['data']);
      }
      return FreeKundaliModel();
    } on DioError catch (e) {
      return FreeKundaliModel();
    }
  }

  // PR Release
  Future<List<PrReleaseModel>> prRelease() async {
    try {
      var token = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token);
      dio.Response res = await dio.Dio().post(
        "${Constants.baseURL}pr-release",
        // data: {"mobile": phone, "nToken": fcmToken},
        options: Options(responseType: ResponseType.json, headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (res.data["status"]) {
        var data = res.data['data'] as List;
        if (kDebugMode) {
          print(res.data['data']);
        }
        return data.map((e) => PrReleaseModel.fromJson(e)).toList();
      }
      return [];
    } on DioError catch (e) {
      return [];
    }
  }

  // Latest Blogs
  Future<List<BlogsModel>> latestBlogs() async {
    log('BLOG API ');
    try {
      var token = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token);
      dio.Response res = await dio.Dio().post(
        "${Constants.baseURL}blog",
        // data: {"mobile": phone, "nToken": fcmToken},
        options: Options(responseType: ResponseType.json, headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (res.data["status"]) {
        var data = res.data['data'] as List;
        return data.map((ddd) => BlogsModel.fromJson(ddd)).toList();
      }
      return [];
    } on DioError catch (e) {
      return [];
    }
  }

  // Chat Astrologer
  Future<AstrologerModel> astrologerList() async {
    try {
      var token = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token);
      dio.Response res = await dio.Dio().post(
        "${Constants.baseURL}chat-with-astrologer",
        // data: {"mobile": phone, "nToken": fcmToken},
        options: Options(responseType: ResponseType.json, headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (res.data["status"]) {
        // var data = res.data['data']['astrologer']['data'] as List;
        // return data.map((ddd) => AstrologerModel.fromJson(ddd)).toList();
        return AstrologerModel.fromJson(res.data);
      }
      return AstrologerModel();
    } on dio.DioError catch (e) {
      return AstrologerModel();
    }
  }

  // Wallet Add Money
  Future<String> walletAddMoney(String amount, {required UserReports userReports}) async {
    try {
      var token = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token);
      var data = {
        "buyerName": userReports.user!.name,
        "buyerEmail": userReports.user!.email,
        "buyerPhone": userReports.user!.mobile,
        "amount": amount,
        "purpose": "Wallet Add Money",
        "redirect_url": "Test ffsfsfsforder"
      };
      dio.Response res = await dio.Dio().post(
        "https://us-central1-thetaramandal-380cd.cloudfunctions.net/createOrderInstamojo",
        data: data,
        options: Options(
          responseType: ResponseType.json,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (kDebugMode) {
        print(res.data);
      }
      if (res.data["success"]) {
        //   var data = res.data['data']['astrologer']['data'] as List;
        return res.data['payment_request']['paymenturl'];
      }
      return '';
    } on dio.DioError catch (e) {
      return '';
    }
  }

  // Live Astrologer
  static RxList liveAstrologers = [].obs;
  Future liveAstrologer({required Map data}) async {
    log('LIVE ASTROLOGER API CALL');
    try {
      // var token = await PreferencesHelper()
      //     .getPreferencesStringData(PreferencesHelper.token);
      dio.Response res = await dio.Dio().post(
        "https://www.thetaramandal.com/api/onlineastrologer",
        data: data,
        // data: {"mobile": phone, "nToken": fcmToken},
        /*options: dio.Options(
                // contentType: dio.Headers.formUrlEncodedContentType,
                headers: {
                  "Authorization":
                      "Bearer ${PrefrenceDataController.to.token.value}"
                },
              )*/
      );

      log(res.data.toString(), name: 'LIVE ASTROLOGERS');
      if (res.data["status"]) {
        liveAstrologers.value = res.data['data'];

        // return data.map((ddd) => LiveAstrologerModel.fromJson(ddd)).toList();
      }
      // return [];
    } on dio.DioError catch (e) {
      log(e.toString(), name: 'ERROR OF GETTING LIVE ASTROLOGER');
    }
  }

  // Live Astrologer
  // Live Astrologer
  // Future<UserReports> getProfile(WidgetRef ref) async {
  //   try {
  //     var token = await PreferencesHelper()
  //         .getPreferencesStringData(PreferencesHelper.token);
  //     dio.Response res = await dio.Dio().post(
  //       "https://www.thetaramandal.com/api/viewprofile",
  //       // data: {"mobile": phone, "nToken": fcmToken},
  //       options: Options(responseType: ResponseType.json, headers: {
  //         'Authorization': 'Bearer $token',
  //       }),
  //     );
  //     if (res.data["status"]) {
  //       var data = res.data['data'];
  //       print(data);
  //       final appState = ref.read(appStateRef);
  //       appState.userReports = UserReports.fromJson(data);
  //       return UserReports.fromJson(data);
  //     }
  //     return UserReports();
  //   } on DioError catch (e) {
  //     return UserReports();
  //   }
  // }

  // Live Astrologer
  //Remaining Wallet money
  Future<bool> setCurrentWallet({
    required String paymentid,
    required String paymentstatus,
    required String paymentrequestid,
    required String id,
    required String amount,
  }) async {
    try {
      var token = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token);
      var data = {"payment_id": paymentid, "payment_status": paymentstatus, "payment_request_id": paymentrequestid, "id": id, "amount": amount};
      dio.Response res = await dio.Dio().post(
        "https://www.thetaramandal.com/api/wallet/payments/success",
        data: data,
        options: Options(responseType: ResponseType.json, headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      print('Ankit Res-> ${res.data}');
      if (res.data["status"]) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      return false;
    }
  }

  //Remaining Wallet money
  //Profile Update
  Future<bool> profileUpdate({
    required String name,
    required String email,
    required String city,
    required String state,
    required String pincode,
    required String dob,
    required String gender,
  }) async {
    try {
      var token = await PreferencesHelper().getPreferencesStringData(PreferencesHelper.token);
      var data = {
        "name": name,
        "email": email,
        "dob": dob, //"1999/08/15",
        "gender": gender,
        "city": city,
        "state": state,
        "pincode": pincode
      };
      if (kDebugMode) {
        print("Data->$data");
      }
      dio.Response res = await dio.Dio().post(
        "https://www.thetaramandal.com/api/addprofile",
        data: data,
        options: Options(responseType: ResponseType.json, headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (res.data["status"]) {
        if (kDebugMode) {
          print('profileUpdate->$profileUpdate $token ${res.data}');
        }
        return true;
      } else {
        DesignUtlis.flutterToast(res.data["message"]);
      }
      return false;
    } on DioError catch (e) {
      // print('profileUpdate Error->$profileUpdate   ${e.error.data.toString()}');
      DesignUtlis.flutterToast(e.message.toString());
      return false;
    }
  }
  //Profile Update
}
