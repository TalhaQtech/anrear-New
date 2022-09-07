import 'package:get/get.dart';

class main_controller extends GetxController {
  var count = 0;
  var count2 = 0.obs;
  List listimg = [];
  List listimg2 = [];

  increasefunc() {
    count++;
    refresh();
    print(count);
  }
}
