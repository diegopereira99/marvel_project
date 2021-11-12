import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:marvel_test/errors/character_error.dart';
import 'package:marvel_test/interfaces/character_repository.dart';
import 'package:marvel_test/models/character_model.dart';

class CharacterController extends GetxController {
  final ICharacterRepository characterRepository;
  CharacterController({required this.characterRepository}) {
    characters.listen((characters) {
      filteredCharacters.assignAll(characters);
    });
  }

  RxList<CharacterModel> characters = <CharacterModel>[].obs;
  RxList<CharacterModel> filteredCharacters = <CharacterModel>[].obs;
  RxBool loading = false.obs;
  RxString errorMessage = ''.obs;
  RxString filter = ''.obs;

  setFilter(String filter) => this.filter.value = filter;

  Future<void> getCharacters() async {
    try {
      loading.value = true;
      final charactersInLocalStorage =
          await characterRepository.getCharactersFromlocalStorage();
      if (charactersInLocalStorage.isNotEmpty) {
        characters.addAll(charactersInLocalStorage);
      } else {
        final fetchedCharacters = await characterRepository.getCharacters();
        characters.addAll(fetchedCharacters);
        characterRepository.saveCharactersInLocalStorage(characters);
      }
      loading.value = false;
    } on CharacterErrors catch (_) {
      errorMessage.value = 'Erro ao buscar personagens';
      loading.value = false;
    } catch (e) {
      errorMessage.value = 'Erro inesperado';
      loading.value = false;
    }
  }

  void filterCharacters() {
    if (filter.isEmpty) {
      filteredCharacters.assignAll(characters);
    } else {
      filteredCharacters.assignAll(characters
          .where((character) =>
              character.description
                  .toLowerCase()
                  .contains(filter.toLowerCase()) ||
              character.name.toLowerCase().contains(filter.toLowerCase()))
          .toList());
    }
  }

  Future<void> resetLocalCharacters() async {
    try {
      loading.value = true;

      final fetchedCharacters = await characterRepository.getCharacters();
      await characterRepository.saveCharactersInLocalStorage(fetchedCharacters);
      characters.assignAll(fetchedCharacters);

      filterCharacters();

      loading.value = false;
    } on CharacterErrors catch (_) {
      errorMessage.value = 'Erro ao atualizar personagens';
      loading.value = false;
    } catch (e) {
      errorMessage.value = 'Erro inesperado';
      loading.value = false;
    }
  }

  Future<void> removeCharacter({required CharacterModel character}) async {
    try {
      if (await characterRepository.deleteCharacter(character)) {
        final characterIndex =
            characters.indexWhere((c) => c.id == character.id);
        characters.removeAt(characterIndex);
      } else {
        throw Error();
      }
    } catch (e) {
      characters.add(character);
      errorMessage.value = 'Erro ao excluir o personagem';
    }
  }

  void addCharacter({required character}) {
    characters.insert(0, character);
  }

  void updateCharacter({required CharacterModel character}) async {
    try {
      final characterIndex = characters.indexWhere((c) => c.id == character.id);
      characters[characterIndex] = character;
    } catch (e) {
      errorMessage.value = 'Erro ao alterar o personagem';
    }
  }
}
