import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_test/interfaces/character_repository.dart';
import 'package:marvel_test/models/character_model.dart';
import 'package:marvel_test/modules/character/character_controller.dart';
import 'package:marvel_test/modules/character/edit_character/edit_character_controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_character_controller.dart';
import '../../../mocks/mock_character_model.dart';
import '../../../mocks/mock_character_repository.dart';


final mockedCharacter = CharacterModel(
    name: 'Thor',
    description: 'Deus do trovão',
    id: '123',
    image: 'imagem.xpto');

main() {
  late ICharacterRepository characterRepository;
  late EditCharacterController controller;
  late CharacterController characterController;

  setUpAll(() {
    registerFallbackValue(FakeCharacterModel());
  });

  setUp(() {
    characterRepository = MockCharacterRepository();
    characterController = MockCharacterController();
    controller = EditCharacterController(
        character: mockedCharacter,
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

  test('Should update the character', () async {
    controller.name.value = 'novo nome';
    controller.description.value = 'nova descrição';
    controller.image.value = 'nova imagem';

    final updatedCharacterMock = CharacterModel(
        name: controller.name.value,
        description: controller.description.value,
        id: controller.character.id,
        image: controller.image.value);

    when(() => characterRepository.updateCharacter(any()))
        .thenAnswer((realInvocation) => Future.value(updatedCharacterMock));

    await controller.editCharacter();

    verify(() => characterController.updateCharacter(
        character: updatedCharacterMock)).called(1);
  });
}
