import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:get/get.dart';
import 'package:marvel_test/errors/character_error.dart';
import 'package:marvel_test/interfaces/character_repository.dart';
import 'package:marvel_test/models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterRepositoryImplementation implements ICharacterRepository {
  final charactersUrl =
      "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=8208c2c06415a3b1e85df80dc0a910d9&hash=ea867ac59be7a2d166f619d27e56d452&limit=15";
  final Dio http;
  final SharedPreferences prefs;
  CharacterRepositoryImplementation({required DioForNative this.http, required this.prefs});

  @override
  Future<CharacterModel> createCharacter(CharacterModel character) async {
    character.id = DateTime.now().toString();
    final characters = await getCharactersFromlocalStorage();
    characters.insert(0, character);
    await saveCharactersInLocalStorage(characters);
    return character;
  }

  @override
  Future<bool> deleteCharacter(CharacterModel character) async {
    try {
      final characters = await getCharactersFromlocalStorage();
      final characterIndex = characters.indexWhere((c) => c.id == character.id);
      characters.removeAt(characterIndex);
      await saveCharactersInLocalStorage(characters);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await http.get(charactersUrl);
      return (response.data["data"]["results"] as List)
          .map((character) => CharacterModel.fromMap({
                ...character,
                'image':
                    "${character['thumbnail']?['path']}/standard_medium.${character['thumbnail']?["extension"]}"
              }))
          .toList();
    } catch (e) {
      throw CharacterErrors.unexpected;
    }
  }

  @override
  Future<void> saveCharactersInLocalStorage(
      List<CharacterModel> characters) async {
    await prefs.setString("characters", jsonEncode(characters));
  }

  @override
  Future<CharacterModel> updateCharacter(CharacterModel character) async {
    final characters = await getCharactersFromlocalStorage();
    final characterIndex = characters.indexWhere((c) => c.id == character.id);
    characters[characterIndex] = character;
    await saveCharactersInLocalStorage(characters);
    return character;
  }

  @override
  Future<List<CharacterModel>> getCharactersFromlocalStorage() async {
    final charactersInStorage = prefs.getString('characters');
    if (charactersInStorage != null) {
      return (jsonDecode(charactersInStorage) as List)
          .map((character) => CharacterModel.fromJson(character))
          .toList();
    } else {
      return [];
    }
  }
}
