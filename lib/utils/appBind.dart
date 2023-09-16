
import 'package:get/get.dart';

import '../controllers/cusController.dart';
import '../controllers/shopController.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Bind my controllers
    Get.put(CustomerController());
    Get.put(ShopController());
  }
}
