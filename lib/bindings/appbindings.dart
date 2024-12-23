import 'package:get/get.dart';
import 'package:todolistapp/controllers/authcontroller.dart';


class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
