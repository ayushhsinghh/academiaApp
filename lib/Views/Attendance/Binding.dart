import 'package:get/get.dart';

import '../../Controllers/Controllers.dart';

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcadDataController>(
      () => AcadDataController(),
    );
  }
}
