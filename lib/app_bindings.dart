import 'package:get/get.dart';
import 'package:marvel_test/modules/character/character_controller.dart';
import 'package:marvel_test/repositories/character_repository_implementation.dart';
import 'package:marvel_test/shared/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBindigs extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(CustomDio());
    await Get.putAsync(() => SharedPreferences.getInstance());
    Get.put(CharacterController(
        characterRepository: CharacterRepositoryImplementation(
            prefs: Get.find<SharedPreferences>(),
            http: Get.find<CustomDio>())));
  }
}
