import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfilePageLogic extends GetxController {
  final buildNumber = ''.obs;
  final version = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    final packageInfo = await PackageInfo.fromPlatform();

    buildNumber.value = packageInfo.buildNumber;
    version.value = packageInfo.version;
  }
}
