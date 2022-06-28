import 'package:get/get.dart';

Controller controller = Get.put(Controller());

class Controller extends GetxController {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    update(["indexchange"]);
  }
}
