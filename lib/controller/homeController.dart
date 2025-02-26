
import 'package:get/get.dart';

class HomeController extends GetxController{

  RxBool switchCondition=false.obs;
  void checkCondition(var value)
  {
    switchCondition.value=false;
  }
}