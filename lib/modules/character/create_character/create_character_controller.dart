import 'package:get/get.dart';
import 'package:marvel_test/interfaces/character_repository.dart';
import 'package:marvel_test/models/character_model.dart';
import 'package:marvel_test/modules/character/character_controller.dart';
import 'package:marvel_test/validators/character_validator.dart';

class CreateCharacterController extends GetxController {
  RxString name = ''.obs;
  RxString description = ''.obs;
  RxString image = ''.obs;
  RxString errorMessage = ''.obs;

  final ICharacterRepository characterRepository;
  final CharacterController characterController;

  CreateCharacterController(
      {required this.characterRepository, required this.characterController});

  setName(String name) => this.name.value = name;
  setDescription(String description) => this.description.value = description;
  setImage(String image) => this.image.value = image;

  

  bool formIsValid() =>
      CharacterValidator.validateDescription()!(description.value) == null &&
      CharacterValidator.validateName()!(name.value) == null;

  Future<bool> createCharacter() async {
    try {
      final character = CharacterModel(
          name: name.value, image: image.value, description: description.value);

      final savedCharacter =
          await characterRepository.createCharacter(character);

      characterController.addCharacter(character: savedCharacter);

      return true;
    } catch (e) {
      errorMessage.value = 'Erro ao criar personagem';
      return false;
    }
  }
}
