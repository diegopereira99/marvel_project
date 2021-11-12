import 'package:get/get.dart';
import 'package:marvel_test/modules/character/character_page.dart';
import 'package:marvel_test/modules/character/create_character/create_character_bindings.dart';
import 'package:marvel_test/modules/character/create_character/create_character_page.dart';
import 'package:marvel_test/modules/character/edit_character/edit_character_bindings.dart';
import 'package:marvel_test/modules/character/edit_character/edit_character_page.dart';
import 'package:marvel_test/modules/splash/splash_page.dart';

class AppRoutes {
  static const initialRoute = '/';

  static final routes = [
    GetPage(name: "/", page: () => const SplashPage()),
    GetPage(name: "/character", page: () => const CharacterPage()),
    GetPage(name: "/character/create", page: () => const CreateCharacterPage(), binding: CreateCharacterBindings()),
    GetPage(name: "/character/edit", page: () => const EditCharacterPage(), binding: EditCharacterBindings()),
  ];
}
