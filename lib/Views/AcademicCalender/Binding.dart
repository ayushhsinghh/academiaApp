import 'package:get/get.dart';

import '../../Controllers/AcadControllers.dart';

class CalenderBinding extends Bindings {
  @override
  void dependencies() {
    /// Creating a new instance of the AcadDataController class.
    Get.lazyPut<AcadDataController>(
      () => AcadDataController(),
    );
  }
}
