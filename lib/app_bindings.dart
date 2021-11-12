import 'package:get/get.dart';
import 'package:marvel_test/modules/character/character_controller.dart';
import 'package:marvel_test/repositories/character_repository_implementation.dart';
import 'package:marvel_test/shared/custom_dio.dart';

class AppBindigs extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomDio());
    Get.put(CharacterController(characterRepository: CharacterRepositoryImplementation(http: Get.find<CustomDio>())));
  }

}