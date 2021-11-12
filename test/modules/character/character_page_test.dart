import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:marvel_test/app_routes.dart';
import 'package:marvel_test/interfaces/character_repository.dart';
import 'package:marvel_test/models/character_model.dart';
import 'package:marvel_test/modules/character/character_controller.dart';
import 'package:marvel_test/modules/character/character_page.dart';
import 'package:marvel_test/modules/character/widgets/character_card.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mock_character_repository.dart';

Widget makeTestable(Widget page) => GetMaterialApp(
      home: page,
    );
final mockCharacters = [
  CharacterModel(
      id: '123',
      name: 'Homem Aranha',
      description: 'Homem com poder de aranha'),
  CharacterModel(
      id: '1234', name: 'Incrível Hulk', description: 'Home super forte'),
];

main() {
  Get.testMode = true;
  late ICharacterRepository characterRepository;
  setUp(() {
    characterRepository = MockCharacterRepository();
    Get.put(CharacterController(characterRepository: characterRepository));
  });
  testWidgets('should show the list of characters',
      (WidgetTester tester) async {
    when(() => characterRepository.getCharactersFromlocalStorage())
        .thenAnswer((invocation) async => mockCharacters);
    when(() => characterRepository.getCharacters())
        .thenAnswer((invocation) async => mockCharacters);
    when(() => characterRepository.saveCharactersInLocalStorage(any()))
        .thenAnswer((invocation) async => {});

    await tester.pumpWidget(makeTestable(const CharacterPage()));
    await tester.pumpAndSettle();
    
    expect(find.byElementType(CharacterCard), findsNWidgets(2));
  });
}
