import 'package:fyp/Controller/AuthController.dart';
import 'package:fyp/Controller/CartController.dart';
import 'package:fyp/Controller/PaymentController.dart';
import 'package:fyp/Controller/ProductController.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class defaultBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<ProductController>(ProductController());
    Get.put<CartController>(CartController());
    Get.put<PaymentController>(PaymentController());
    Get.put<AuthController>(AuthController());
    // Get.lazyPut(()=>ItemController(),fenix: true);
    // Get.put(customerController());
    // Get.lazyPut(()=>LoginController());
  }

}