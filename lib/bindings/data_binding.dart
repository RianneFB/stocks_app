import 'package:get/get.dart';
import 'package:stocks/controllers/data_controller.dart';

class DataBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DataController>(() => DataController());
  }
}