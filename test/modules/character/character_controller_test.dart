import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_test/errors/character_error.dart';
import 'package:marvel_test/interfaces/character_repository.dart';
import 'package:marvel_test/models/character_model.dart';
import 'package:marvel_test/modules/character/character_controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_character_repository.dart';

final mockCharacters = [
  CharacterModel(
      id: '123',
      name: 'Homem Aranha',
      description: 'Homem com poder de aranha'),
  CharacterModel(
      id: '1234', name: 'Incrível Hulk', description: 'Home super forte'),
];

main() {
  late ICharacterRepository characterRepository;
  late CharacterController controller;

  setUp(() {
    characterRepository = MockCharacterRepository();
    controller = CharacterController(characterRepository: characterRepository);
  });

  test(
      'Should start the list of movies empty, loading false and the errorMessage empty',
      () async {
    expect(controller.characters.length, equals(0));
    expect(controller.loading.value, isFalse);
    expect(controller.errorMessage.value, isEmpty);
  });

  test('Should get the movies from local storage if it has data', () async {
    when(() => characterRepository.getCharactersFromlocalStorage())
        .thenAnswer((realInvocation) => Future.value(mockCharacters));

    await controller.getCharacters();
    verifyNever(() => characterRepository.getCharacters());
    expect(controller.characters.length, equals(2));
  });
  test('Should get the movies from API if the storage is empty', () async {
    when(() => characterRepository.getCharactersFromlocalStorage())
        .thenAnswer((realInvocation) => Future.value([]));
    when(() => characterRepository.getCharacters())
        .thenAnswer((realInvocation) => Future.value(mockCharacters));

    await controller.getCharacters();

    verify(() => characterRepository.getCharacters()).called(1);
    verify(() => characterRepository.getCharactersFromlocalStorage()).called(1);

    expect(controller.characters.length, equals(2));
  });
  test('Should get a mapped error when fetch the movies', () async {
    when(() => characterRepository.getCharactersFromlocalStorage())
        .thenThrow(CharacterErrors.unexpected);

    await controller.getCharacters();

    expect(controller.characters.length, equals(0));
    expect(controller.loading.value, isFalse);
    expect(controller.errorMessage.value, equals('Erro ao buscar personagens'));
  });
  test('Should get a unexpected error when fetch the movies', () async {
    when(() => characterRepository.getCharactersFromlocalStorage())
        .thenThrow(Error());

    await controller.getCharacters();

    expect(controller.characters.length, equals(0));
    expect(controller.loading.value, isFalse);
    expect(controller.errorMessage.value, equals('Erro inesperado'));
  });

  test('Should reset the movies from local storage', () async {
    when(() => characterRepository.getCharacters())
        .thenAnswer((realInvocation) => Future.value(mockCharacters));
    when(() => characterRepository.saveCharactersInLocalStorage(any()))
        .thenAnswer((realInvocation) async => {});

    await controller.resetLocalCharacters();

    verify(() =>
            characterRepository.saveCharactersInLocalStorage(mockCharacters))
        .called(1);
    expect(controller.characters.length, equals(2));
  });

  test('Should filter the movies', () async {
    controller.filter.value = 'Aranha';
    controller.characters.addAll(mockCharacters);

    controller.filterCharacters();

    expect(controller.characters.length, equals(2));
    expect(controller.filteredCharacters.length, equals(1));
    expect(controller.filteredCharacters[0].name, equals('Homem Aranha'));
  });

  test('Should remove an specific character and update the local storage',
      () async {
    when(() => characterRepository.deleteCharacter(mockCharacters[0]))
        .thenAnswer((realInvocation) => Future.value(true));

    controller.characters.addAll(mockCharacters);

    await controller.removeCharacter(character: mockCharacters[0]);

    expect(controller.characters.length, equals(1));
    verify(() => characterRepository.deleteCharacter(mockCharacters[0]))
        .called(1);
  });

  test('Should add the new character in the list', () async {
    final newCharacter =
        CharacterModel(name: 'Thor', description: 'Rei trovão');

    controller.characters.addAll(mockCharacters);

    controller.addCharacter(character: newCharacter);

    expect(controller.characters.length, equals(3));
  });

  test('Should update the list of characters with the updated characted',
      () async {
    controller.characters.addAll(mockCharacters);

    final updatedCharacter = mockCharacters[0];
    updatedCharacter.name = 'nome atualizado';

    controller.updateCharacter(character: mockCharacters[0]);

    expect(controller.characters.length, equals(2));
    expect(controller.characters[0].name, equals('nome atualizado'));
  });
}
