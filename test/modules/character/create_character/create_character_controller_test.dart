import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_test/interfaces/character_repository.dart';
import 'package:marvel_test/models/character_model.dart';
import 'package:marvel_test/modules/character/character_controller.dart';
import 'package:marvel_test/modules/character/create_character/create_character_controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_character_controller.dart';
import '../../../mocks/mock_character_model.dart';
import '../../../mocks/mock_character_repository.dart';

main() {
  late ICharacterRepository characterRepository;
  late CreateCharacterController controller;
  late CharacterController characterController;

  setUpAll(() {
    registerFallbackValue(FakeCharacterModel());
  });

  setUp(() {
    characterRepository = MockCharacterRepository();
    characterController = MockCharacterController();
    controller = CreateCharacterController(
        characterController: characterController,
        characterRepository: characterRepository);
  });

  test('Should the form be valid', () async {
    controller.description.value = 'Descrição';
    controller.name.value = 'Diego';

    expect(controller.formIsValid(), isTrue);
  });

  test('Should the form be invalid', () async {
    controller.description.value = '';
    controller.name.value = 'Diego';
    expect(controller.formIsValid(), isFalse);

    controller.description.value = 'Descrição';
    controller.name.value = '';
    expect(controller.formIsValid(), isFalse);

    controller.description.value = '';
    controller.name.value = '';
    expect(controller.formIsValid(), isFalse);
  });

  test('Should create the character', () async {
    controller.description.value = 'Descrição';
    controller.name.value = 'Diego';
    controller.image.value = 'imagem.xpto';

    final createdCharacterMock = CharacterModel(
        name: 'Diego', description: 'Descrição', image: 'imagem.xpto');

    when(() => characterRepository.createCharacter(any()))
        .thenAnswer((_) async => createdCharacterMock);

    await controller.createCharacter();

    verify(() => characterRepository.createCharacter(any())).called(1);
    verify(() => characterController.addCharacter(character: createdCharacterMock)).called(1);
  });
}
