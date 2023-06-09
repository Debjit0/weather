import 'package:get/get.dart';

class GlobalController extends GetxController {
  //create variables
  RxBool isLoading = true.obs;
  final RxDouble Latitude = 0.00.obs;
  final RxDouble Longitude = 0.00.obs;

  RxBool checkLoading() => isLoading; //check with own code later
  RxDouble getLatitude() => Latitude;
  RxDouble getLongitude() => Longitude;

  @override
  void onInit() {
    if (isLoading == true) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {}
}
