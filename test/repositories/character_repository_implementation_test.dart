import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_test/errors/character_error.dart';
import 'package:marvel_test/models/character_model.dart';
import 'package:marvel_test/repositories/character_repository_implementation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_character_model.dart';

class DioMock extends Mock implements DioForNative {}

class SharedPreferencesMock extends Mock implements SharedPreferences {}

final mockedHttpResponse =
    Response(requestOptions: RequestOptions(path: '123'), data: {
  "data": {
    "results": [
      {
        "title": "Homem aranha",
        "description": "Homem que solta teia",
        "thumbnail": {"path": "imagepath", "extension": "jpg"}
      },
      {
        "title": "Homem de Ferro",
        "description": "Homem com armadura",
        "thumbnail": {"path": "imagepath", "extension": "jpg"}
      }
    ]
  }
});
final mockCharacters = [
  CharacterModel(
      id: '123',
      name: 'Homem Aranha',
      description: 'Homem com poder de aranha'),
  CharacterModel(
      id: '1234', name: 'Incrível Hulk', description: 'Home super forte'),
];

main() {
  late DioForNative http;
  late SharedPreferences prefs;
  late CharacterRepositoryImplementation repository;

  setUp(() {
    http = DioMock();
    prefs = SharedPreferencesMock();
    repository = CharacterRepositoryImplementation(http: http, prefs: prefs);
  });

  setUpAll(() {
    registerFallbackValue(FakeCharacterModel());
  });

  test('should get the characters from API', () async {
    when(() => http.get(any()))
        .thenAnswer((invocation) async => mockedHttpResponse);
    final characters = await repository.getCharacters();
    expect(characters.length, equals(2));
  });

  test(
      'should get a exception CharacterErrors.unexpected when try to fetch characters from API',
      () async {
    when(() => http.get(any())).thenThrow(CharacterErrors.unexpected);
    try {
      await repository.getCharacters();
    } catch (e) {
      expect(e, equals(CharacterErrors.unexpected));
    }
  });

  test('should get the characters from local storage', () async {
    when(() => prefs.getString('characters'))
        .thenAnswer((invocation) => jsonEncode(mockCharacters));
    final characters = await repository.getCharactersFromlocalStorage();
    expect(characters.length, equals(2));
  });

  test('should save the characters in local storage', () async {
    when(() => prefs.setString('characters', jsonEncode(mockCharacters)))
        .thenAnswer((invocation) async => true);
    await repository.saveCharactersInLocalStorage(mockCharacters);
    verify(() => prefs.setString('characters', jsonEncode(mockCharacters)))
        .called(1);
  });

  test('should update the character in local storage', () async {
    when(() => prefs.getString('characters'))
        .thenAnswer((invocation) => jsonEncode(mockCharacters));
    when(() => prefs.setString('characters', any()))
        .thenAnswer((invocation) async => true);

    final character = CharacterModel(
        name: 'Novo nome', description: 'Descrição', id: mockCharacters[0].id);
    final updatedCharacter = await repository.updateCharacter(character);

    expect(updatedCharacter.name, equals('Novo nome'));

    mockCharacters[0] = updatedCharacter;

    verify(() => prefs.setString('characters', jsonEncode(mockCharacters)))
        .called(1);
  });

  test('should create the character', () async {
    when(() => prefs.getString('characters'))
        .thenAnswer((invocation) => jsonEncode(mockCharacters));
    when(() => prefs.setString('characters', any()))
        .thenAnswer((invocation) async => true);

    final character = CharacterModel(
        name: 'Thor', description: 'Deus do trovão', image: 'imagem.jpg');
    final createdCharacater = await repository.createCharacter(character);

    expect(createdCharacater.name, equals('Thor'));
    expect(createdCharacater.id, isNotNull);
    verify(() => prefs.setString(
            'characters', jsonEncode([createdCharacater, ...mockCharacters])))
        .called(1);
  });

  test('should delete the character', () async {
    when(() => prefs.getString('characters'))
        .thenAnswer((invocation) => jsonEncode(mockCharacters));
    when(() => prefs.setString('characters', any()))
        .thenAnswer((invocation) async => true);

    final character = mockCharacters[0];
    final characterDeleted = await repository.deleteCharacter(character);

    expect(characterDeleted, isTrue);
    verify(() => prefs.setString('characters', jsonEncode([mockCharacters[1]])))
        .called(1);
  });
}
