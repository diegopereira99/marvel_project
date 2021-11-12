import 'package:get/get.dart';
import 'package:marvel_test/modules/character/character_controller.dart';
import 'package:marvel_test/modules/character/edit_character/edit_character_controller.dart';
import 'package:marvel_test/repositories/character_repository_implementation.dart';
import 'package:marvel_test/shared/custom_dio.dart';

class EditCharacterBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(EditCharacterController(character: Get.arguments, characterController: Get.find<CharacterController>(), characterRepository: CharacterRepositoryImplementation(http: Get.find<CustomDio>())));
  }

}