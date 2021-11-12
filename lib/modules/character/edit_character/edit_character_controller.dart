import 'package:get/get.dart';
import 'package:marvel_test/interfaces/character_repository.dart';
import 'package:marvel_test/models/character_model.dart';
import 'package:marvel_test/modules/character/character_controller.dart';
import 'package:marvel_test/validators/character_validator.dart';

class EditCharacterController extends GetxController {
  RxString name = ''.obs;
  RxString description = ''.obs;
  RxString image = ''.obs;
  RxString errorMessage = ''.obs;
  CharacterModel character;

  final ICharacterRepository characterRepository;
  final CharacterController characterController;

  EditCharacterController(
      {required this.character, required this.characterRepository, required this.characterController});

  @override
  onInit() async {
    setName(character.name);
    setDescription(character.description);
    setImage(character.image!);
    super.onInit();
  }

  setName(String name) => this.name.value = name;
  setDescription(String description) => this.description.value = description;
  setImage(String image) => this.image.value = image;

  bool formIsValid() =>
      CharacterValidator.validateDescription()!(description.value) == null &&
      CharacterValidator.validateName()!(name.value) == null;

  Future<bool> editCharacter() async {
    try {
      final character = CharacterModel(
          name: name.value, image: image.value, description: description.value,id: this.character.id);

      final updatedCharacter =
          await characterRepository.updateCharacter(character);
      characterController.updateCharacter(character: updatedCharacter);
      return true;
    } catch (e) {
      errorMessage.value = 'Erro ao editar personagem';
      return false;
    }
  }
}
