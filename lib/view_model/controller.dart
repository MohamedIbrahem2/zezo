import 'package:get/get.dart';

class Controller extends GetxController {
  RxInt x = 20.obs;

  inc() {
    x++;
  }

  dec() {
    x--;
  }
}
