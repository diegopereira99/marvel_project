import 'package:marvel_test/models/character_model.dart';

abstract class ICharacterRepository {
  Future<List<CharacterModel>> getCharacters();
  Future<List<CharacterModel>> getCharactersFromlocalStorage();
  Future<void> saveCharactersInLocalStorage(List<CharacterModel> characters);
  Future<CharacterModel> createCharacter(CharacterModel character);
  Future<CharacterModel> updateCharacter(CharacterModel character);
  Future<bool> deleteCharacter(CharacterModel character);
}
