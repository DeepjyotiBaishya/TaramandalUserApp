import 'dart:developer';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rashi_network/services/api/api_service.dart';
import 'package:rashi_network/services/shared_prefrence/pref_controller.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.put(ChatController());

  RxMap<String, dynamic> reqChatRes = <String, dynamic>{}.obs;

  Future<bool?> reqChatApi({required Map<String,
      dynamic> data, Function? success, Function? error, String? page}) async {
    try {
      dio.Response response = await dio.Dio().post(
        ApiConfig.userlaunchchat,
        data: data,
        options: dio.Options(headers: {
          'Authorization': 'Bearer ' + PrefrenceDataController.to.token.value,
          'Accept': 'application/json'
        }),
      );

      if (response.statusCode == 200) {
        reqChatRes.value = response.data;
        log(reqChatRes.toString(), name: 'LOGIN RES');
        if (response.data != null) {
          if (reqChatRes['status']) {
            if (success != null) {
              success();
            }
            return true;
          } else {
            if (error != null) {
              error(reqChatRes['message'] ?? "Something went wrong");
            }
          }
        } else {
          if (error != null) {
            error(reqChatRes['message'] ?? "Something went wrong");
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

  RxMap<String, dynamic> chatStatusRes = <String, dynamic>{}.obs;

  Future<bool?> chatStatusApi({required Map<String,
      dynamic> data, Function? success, Function? error}) async {
    try {
      log(data.toString(), name: 'PARAMS');
      log(ApiConfig.checkchatstatus, name: 'URL');
      dio.Response response = await dio.Dio().post(
        ApiConfig.checkchatstatus,
        data: data,
        options: dio.Options(headers: {
          'Authorization': 'Bearer ' + PrefrenceDataController.to.token.value,
        }),
      );

      if (response.statusCode == 200) {
        chatStatusRes.value = response.data;

        log(chatStatusRes.toString(), name: 'chatStatusRes RES');
        if (response.data != null) {
          if (response.data['status']) {
            if (success != null) {
              success();
            }
            return true;
          } else {
            if (error != null) {
              error(response.data['message'] ?? "Something went wrong");
            }
          }
        } else {
          if (error != null) {
            error(response.data['message'] ?? "Something went wrong");
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

  RxMap<String, dynamic> sendChatRequestRes = <String, dynamic>{}.obs;

  Future<bool?> sendChatRequestApi({required Map<String,
      dynamic> data, Function? success, Function? error}) async {
    try {
      log(data.toString(), name: 'PARAMS');
      log(ApiConfig.sendchatrequest, name: 'URL');
      dio.Response response = await dio.Dio().post(
        ApiConfig.sendchatrequest,
        data: data,
        options: dio.Options(headers: {
          'Authorization': 'Bearer ' + PrefrenceDataController.to.token.value,
        }),
      );

      if (response.statusCode == 200) {
        sendChatRequestRes.value = response.data;

        log(sendChatRequestRes.toString(), name: 'sendChatRequestRes RES');

        if (response.data != null) {
          dynamic status = response.data['status'];

          if (status is bool && status) {
            if (success != null) {
              success();
            }
            return true;
          } else {
            if (error != null) {
              error(response.data['message'] ?? "Something went wrong");
            }
          }
        } else {
          if (error != null) {
            error("Something went wrong");
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

  RxMap<String, dynamic> endChatRes = <String, dynamic>{}.obs;

  Future<bool?> endChatApi({required Map<String,
      dynamic> data, Function? success, Function? error}) async {
    try {
      log(data.toString(), name: 'PARAMS');
      log(ApiConfig.userendchat, name: 'URL');
      dio.Response response = await dio.Dio().post(
        ApiConfig.userendchat,
        data: data,
        options: dio.Options(headers: {
          'Authorization': 'Bearer ' + PrefrenceDataController.to.token.value,
        }),
      );

      if (response.statusCode == 200) {
        endChatRes.value = response.data;

        log(endChatRes.toString(), name: 'chatStatusRes RES');
        if (response.data != null) {
          if (response.data['status']) {
            if (success != null) {
              success();
            }
            return true;
          } else {
            if (error != null) {
              error(response.data['message'] ?? "Something went wrong");
            }
          }
        } else {
          if (error != null) {
            error(response.data['message'] ?? "Something went wrong");
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


  RxMap<String, dynamic> reviewRatingRes = <String, dynamic>{}.obs;

  Future<bool?> reviewRatingApi({required Map<String,
      dynamic> data, Function? success, Function? error}) async {
    try {
      log(data.toString(), name: 'PARAMS');
      log(ApiConfig.reviewRating, name: 'URL');
      dio.Response response = await dio.Dio().post(
        ApiConfig.reviewRating,
        data: data,
        options: dio.Options(headers: {
          'Authorization': 'Bearer ' + PrefrenceDataController.to.token.value,
        }),
      );

      if (response.statusCode == 200) {
        reviewRatingRes.value = response.data;

        log(reviewRatingRes.toString(), name: 'reviewRatingRes RES');
        if (response.data != null) {
          if (response.data['status']) {
            if (success != null) {
              success();
            }
            return true;
          } else {
            if (error != null) {
              error(response.data['message'] ?? "Something went wrong");
            }
          }
        } else {
          if (error != null) {
            error(response.data['message'] ?? "Something went wrong");
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


  RxMap<String, dynamic> showReviewRatingsRes = <String, dynamic>{}.obs;

  Future<bool?> showReviewRatingsApi({required Map<String,
      dynamic> data, Function? success, Function? error, String? page}) async {
    try {
      dio.Response response = await dio.Dio().post(
        ApiConfig.showReviewRatings,
        data: data,
        options: dio.Options(headers: {
          'Authorization': 'Bearer ' + PrefrenceDataController.to.token.value,
          'Accept': 'application/json'
        }),
      );

      if (response.statusCode == 200) {
        showReviewRatingsRes.value = response.data;
        log(showReviewRatingsRes.toString(), name: 'LOGIN RES');
        if (response.data != null) {
          if (showReviewRatingsRes['status']) {
            if (success != null) {
              success();
            }
            return true;
          } else {
            if (error != null) {
              error(showReviewRatingsRes['message'] ?? "Something went wrong");
            }
          }
        } else {
          if (error != null) {
            error(showReviewRatingsRes['message'] ?? "Something went wrong");
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
//   }
//
//   RxMap<String, dynamic> showReviewRatingsRes = <String, dynamic>{}.obs;
//
//
//
//
//   Future<bool?> showReviewRatingsApi({required Map<String, dynamic> data, Function? success, Function? error}) async {
//     try {
//       log(data.toString(), name: 'PARAMS');
//       log(ApiConfig.showReviewRatings, name: 'URL');
//       dio.Response response = await dio.Dio().post(
//         ApiConfig.showReviewRatings,
//         data: data,
//         options: dio.Options(headers: {
//           'Authorization': 'Bearer ' + PrefrenceDataController.to.token.value,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         showReviewRatingsRes.value = response.data;
//
//         log(showReviewRatingsRes.toString(), name: 'showReviewRatingsRes RES');
//         if (response.data != null) {
//           if (response.data['status']) {
//             if (success != null) {
//               success();
//             }
//             return true;
//           } else {
//             if (error != null) {
//               error(response.data['message'] ?? "Something went wrong");
//             }
//           }
//         } else {
//           if (error != null) {
//             error(response.data['message'] ?? "Something went wrong");
//           }
//           return false;
//         }
//       } else {
//         print(response.data);
//         if (error != null) {
//           error("Something went wrong");
//         }
//       }
//     } on dio.DioError catch (e) {
//       if (error != null) {
//         log((e.message ?? "").toString(), name: 'ERROR');
//         log((e.response?.data ?? "").toString(), name: 'ERROR');
//         error((e.response?.data['message'] ?? "Something went wrong").toString());
//       }
//     }
//     return null;
//   }
// }