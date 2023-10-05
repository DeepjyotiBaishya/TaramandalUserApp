import 'package:get/get.dart';

class BottomController extends GetxController {
  static BottomController get to => Get.put(BottomController());

  RxInt selectedIndOfBottom = 0.obs;
}
