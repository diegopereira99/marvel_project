import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_test/models/character_model.dart';
import 'package:marvel_test/modules/character/character_controller.dart';
import 'package:marvel_test/modules/character/widgets/button_sheet_item.dart';
import 'package:marvel_test/modules/character/widgets/character_card.dart';
import 'package:marvel_test/modules/character/widgets/search_field.dart';
import 'package:marvel_test/modules/character/widgets/settings_button.dart';
import 'package:marvel_test/shared/widgets/custom_loading.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final controller = Get.find<CharacterController>();

  @override
  void initState() {
    controller.getCharacters();
    ever(controller.errorMessage, (callback) {
      if (controller.errorMessage.isNotEmpty) {
        Get.rawSnackbar(
            title: 'Erro',
            message: controller.errorMessage.value,
            backgroundColor: Colors.red);
      }
      controller.errorMessage.value = '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("character_page_appbar_title".tr),
          actions: [
            SettingsButton(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed('/character/create');
            },
            child: const Icon(Icons.add, color: Colors.white)),
        body: Column(
          children: [
            SearchField(
              onChanged: (value) {
                controller.setFilter(value);
                controller.filterCharacters();
              },
            ),
            Expanded(child: Obx(() {
              if (controller.loading.value) {
                return const Center(
                  child: CustomLoading(),
                );
              }
              if (controller.filteredCharacters.isEmpty) {
                return const Center(
                  child: Text("Nenhum filme encontrado",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                );
              }
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return CharacterCard(
                        character: controller.filteredCharacters[index],
                        onTap: () {
                          _showModalButtonSheet(
                              character: controller.filteredCharacters[index]);
                        });
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: controller.filteredCharacters.length);
            }))
          ],
        ));
  }

  _showModalButtonSheet({required CharacterModel character}) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonSheetItem(
                title: "character_remove_tab_title".tr,
                onTap: () async {
                  controller.removeCharacter(character: character);
                  Navigator.of(context).pop();
                }),
            ButtonSheetItem(
                title: "character_edit_tab_title".tr,
                onTap: () async {
                  Navigator.of(context).pop();
                  Get.toNamed('/character/edit', arguments: character);
                }),
          ],
        );
      },
    );
  }
}
