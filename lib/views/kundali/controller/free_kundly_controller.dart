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

class FreeKundlyController extends GetxController {
  static FreeKundlyController get to => Get.put(FreeKundlyController());

  String basicAuth = 'Basic ' + base64.encode(utf8.encode('625847:56873aeab4eeeea2c85101ec9d3012ac'));

  ///1
  RxMap<String, dynamic> basicDataRes = <String, dynamic>{}.obs;

  Future<bool?> basicDataApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    try {
      dio.Response response = await dio.Dio().post("https://json.astrologyapi.com/v1/nakshatra_report",
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {"Authorization": basicAuth, "Content-Type": "application/x-www-form-urlencoded"},
          ));

      if (response.statusCode == 200) {
        basicDataRes.value = response.data;
        log(basicDataRes.toString(), name: 'basicDataRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (success != null) {
            success();
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
      log(e.response?.data['msg'] ?? "Something went wrong");
      if (error != null) {
        error(e.response?.data['msg'] ?? "Something went wrong");
      }
    }
    return null;
  }

  ///2
  RxMap<String, dynamic> freeKundlyRes = <String, dynamic>{}.obs;

  Future<bool?> freeKundlyApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    try {
      dio.Response response = await dio.Dio().post("https://json.astrologyapi.com/v1/birth_details",
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {"Authorization": basicAuth, "Content-Type": "application/x-www-form-urlencoded"},
          ));

      if (response.statusCode == 200) {
        freeKundlyRes.value = response.data;
        log(freeKundlyRes.toString(), name: 'freeKundlyRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (success != null) {
            success();
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
      log(e.response?.data['msg'] ?? "Something went wrong");
      if (error != null) {
        error(e.response?.data['msg'] ?? "Something went wrong");
      }
    }
    return null;
  }

  ///3
  RxString getChartRes = ''.obs;
  Future<bool?> getChartApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    log("https://json.astrologyapi.com/v1/horo_chart_image/:chartId".toString(), name: 'URL');
    log('Basic ' + base64.encode(utf8.encode('625847:56873aeab4eeeea2c85101ec9d3012ac')), name: 'URL');

    try {
      dio.Response response = await dio.Dio().post("https://json.astrologyapi.com/v1/horo_chart_image/:D1",
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {"Authorization": basicAuth, "Content-Type": "application/x-www-form-urlencoded"},
          ));
      log('${response.data}', name: 'CHART RES');
      if (response.statusCode == 200) {
        getChartRes.value = response.data['svg'];

        log(getChartRes.toString(), name: 'getChartRes');
        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (success != null) {
            success(response.data['svg']);
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
      log(e.response?.data['msg'] ?? "Something went wrong");
      if (error != null) {
        error(e.response?.data['msg'] ?? "Something went wrong");
      }
    }
    return null;
  }

  ///4
  RxMap<String, dynamic> basicPanchangRes = <String, dynamic>{}.obs;

  Future<bool?> basicPanchangApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    try {
      dio.Response response = await dio.Dio().post("https://json.astrologyapi.com/v1/basic_panchang",
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {"Authorization": basicAuth, "Content-Type": "application/x-www-form-urlencoded"},
          ));

      if (response.statusCode == 200) {
        basicPanchangRes.value = response.data;
        log(basicPanchangRes.toString(), name: 'basicPanchangRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (success != null) {
            success();
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
      log(e.response?.data['msg'] ?? "Something went wrong");
      if (error != null) {
        error(e.response?.data['msg'] ?? "Something went wrong");
      }
    }
    return null;
  }

  ///5
  RxList kpPlanetsRes = [].obs;

  Future<bool?> kpPlanetsApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    try {
      dio.Response response = await dio.Dio().post("https://json.astrologyapi.com/v1/kp_planets",
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {"Authorization": basicAuth, "Content-Type": "application/x-www-form-urlencoded"},
          ));

      if (response.statusCode == 200) {
        kpPlanetsRes.value = response.data;
        log(kpPlanetsRes.toString(), name: 'kpPlanetsRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (success != null) {
            success();
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
      log(e.response?.data['msg'] ?? "Something went wrong");
      if (error != null) {
        error(e.response?.data['msg'] ?? "Something went wrong");
      }
    }
    return null;
  }

  RxList kpPlanetsCurpsRes = [].obs;

  Future<bool?> kpPlanetsCurpsApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    try {
      dio.Response response = await dio.Dio().post("https://json.astrologyapi.com/v1/kp_house_cusps",
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {"Authorization": basicAuth, "Content-Type": "application/x-www-form-urlencoded"},
          ));

      if (response.statusCode == 200) {
        kpPlanetsCurpsRes.value = response.data;
        log(kpPlanetsCurpsRes.toString(), name: 'kpPlanetsCurpsRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (success != null) {
            success();
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
      log(e.response?.data['msg'] ?? "Something went wrong");
      if (error != null) {
        error(e.response?.data['msg'] ?? "Something went wrong");
      }
    }
    return null;
  }

  ///6
  RxMap<String, dynamic> ghatChakraRes = <String, dynamic>{}.obs;

  Future<bool?> ghatChakraApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    try {
      dio.Response response = await dio.Dio().post("https://json.astrologyapi.com/v1/ghat_chakra",
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {"Authorization": basicAuth, "Content-Type": "application/x-www-form-urlencoded"},
          ));

      if (response.statusCode == 200) {
        ghatChakraRes.value = response.data;
        log(ghatChakraRes.toString(), name: 'ghatChakraRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (success != null) {
            success();
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
      log(e.response?.data['msg'] ?? "Something went wrong");
      if (error != null) {
        error(e.response?.data['msg'] ?? "Something went wrong");
      }
    }
    return null;
  }

  ///7
  RxList majorDashaRes = [].obs;

  Future<bool?> majorDashaApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    try {
      dio.Response response = await dio.Dio().post("https://json.astrologyapi.com/v1/major_chardasha",
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {"Authorization": basicAuth, "Content-Type": "application/x-www-form-urlencoded"},
          ));

      if (response.statusCode == 200) {
        majorDashaRes.value = response.data;
        log(majorDashaRes.toString(), name: 'majorDashaRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (success != null) {
            success();
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
      log(e.response?.data['msg'] ?? "Something went wrong");
      if (error != null) {
        error(e.response?.data['msg'] ?? "Something went wrong");
      }
    }
    return null;
  }

  ///8
  ///6
  RxMap<String, dynamic> sadheSatiRes = <String, dynamic>{}.obs;

  Future<bool?> sadheSatiApi({
    required Map params,
    Function? success,
    Function? error,
  }) async {
    log(params.toString(), name: 'PARAMS');
    try {
      dio.Response response = await dio.Dio().post("https://json.astrologyapi.com/v1/sadhesati_current_status",
          data: params,
          options: dio.Options(
            // contentType: dio.Headers.formUrlEncodedContentType,
            headers: {"Authorization": basicAuth, "Content-Type": "application/x-www-form-urlencoded"},
          ));

      if (response.statusCode == 200) {
        sadheSatiRes.value = response.data;
        log(sadheSatiRes.toString(), name: 'sadheSatiRes');

        // log(analyticsRes.toString(), name: 'analyticsRes ');
        // waitingList.value = response.data;

        if (response.data != null) {
          if (success != null) {
            success();
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
      log(e.response?.data['msg'] ?? "Something went wrong");
      if (error != null) {
        error(e.response?.data['msg'] ?? "Something went wrong");
      }
    }
    return null;
  }
}
