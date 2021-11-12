import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:marvel_test/modules/character/character_controller.dart';

class SettingsButton extends StatelessWidget {
  
  SettingsButton({Key? key}) : super(key: key);
  final controller = Get.find<CharacterController>();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(Icons.settings),
        onSelected: (value) {
          if(value == 'change_locale') {
            _changeLocale();
          }
          if(value == 'reset_characters') {
            controller.resetLocalCharacters();
          }
        },
        itemBuilder: (context) {
          return <PopupMenuEntry<String>>[
            PopupMenuItem(
              child: Text("change_locale".tr),
              value: 'change_locale',
            ),
            PopupMenuItem(
              child: Text("character_reset_button".tr),
              value: 'reset_characters',
            ),
          ];
        });
  }

  void _changeLocale() {
    final currentLocale = Get.locale;
    if(currentLocale.toString() == 'pt_BR') {
      Get.updateLocale(const Locale('en_US'));
    }else {
      Get.updateLocale(const Locale('pt_BR'));
    }
  }

  
}
