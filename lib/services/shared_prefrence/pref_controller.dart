import 'package:get/get.dart';

class PrefrenceDataController extends GetxController {
  static PrefrenceDataController get to => Get.put(PrefrenceDataController());

  RxString token = ''.obs;
  RxString id = ''.obs;
  RxString fcmToken = ''.obs;
  // RxString isApp = ''.obs;

  clear() {
    token.value = '';
    id.value = '';
    fcmToken.value = '';
    // isApp.value = '';
  }
}
