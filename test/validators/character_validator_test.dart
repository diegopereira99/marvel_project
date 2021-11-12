import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_test/validators/character_validator.dart';


main() {

  test('Should validate the name', () async {
    String name = '';

    expect(CharacterValidator.validateName()!(name),
        equals('Campo obrigatório'));

    name = 'Diego';

    expect(CharacterValidator.validateName()!(name), isNull);
  });

  test('Should validate the description', () async {
    String description = '';

    expect(CharacterValidator.validateDescription()!(description),
        equals('Campo obrigatório'));

    description = 'Diego';

    expect(CharacterValidator.validateDescription()!(description),
        isNull);
  });
}
