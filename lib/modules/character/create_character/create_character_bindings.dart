import 'package:get/get.dart';
import 'package:marvel_test/modules/character/character_controller.dart';
import 'package:marvel_test/modules/character/create_character/create_character_controller.dart';
import 'package:marvel_test/repositories/character_repository_implementation.dart';
import 'package:marvel_test/shared/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCharacterBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateCharacterController(
        characterController: Get.find<CharacterController>(),
        characterRepository: CharacterRepositoryImplementation(
            prefs: Get.find<SharedPreferences>(),
            http: Get.find<CustomDio>())));
  }
}
