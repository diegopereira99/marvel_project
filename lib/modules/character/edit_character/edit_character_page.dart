import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marvel_test/modules/character/widgets/character_form_empty_image_container.dart';
import 'package:marvel_test/modules/character/widgets/custom_text_field.dart';
import 'package:marvel_test/modules/character/edit_character/edit_character_controller.dart';
import 'package:marvel_test/modules/character/widgets/character_form_image_container.dart';
import 'package:marvel_test/modules/character/widgets/save_button.dart';
import 'package:marvel_test/validators/character_validator.dart';

class EditCharacterPage extends StatefulWidget {
  const EditCharacterPage({Key? key}) : super(key: key);

  @override
  _EditCharacterPageState createState() => _EditCharacterPageState();
}

class _EditCharacterPageState extends State<EditCharacterPage> {
  @override
  void initState() {
    ever(controller.errorMessage, (callback) {
      if (controller.errorMessage.isNotEmpty) {
        Get.rawSnackbar(
            title: 'Erro',
            message: controller.errorMessage.value,
            backgroundColor: Colors.red);
        controller.errorMessage.value = '';
      }
    });
    super.initState();
  }

  final controller = Get.find<EditCharacterController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("character_edit_appbar_title".tr),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(children: [
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                controller.setImage(image.path);
              }
            },
            child: Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: Obx(() {
                  if (controller.image.isNotEmpty) {
                    return CharacterFormImageContainer(
                        image: controller.image.value);
                  } else {
                    return const CharacterFormEmptyImageContainer();
                  }
                })),
          ),
          const SizedBox(height: 10),
          CustomTextField(
            required: true,
            label: 'character_name_input'.tr,
            value: controller.name.value,
            validator: CharacterValidator.validateName(),
            onChanged: controller.setName,
          ),
          const SizedBox(height: 15),
          CustomTextField(
              required: true,
              value: controller.description.value,
              label: 'character_description_input'.tr,
              validator: CharacterValidator.validateDescription(),
              onChanged: controller.setDescription),
          const SizedBox(height: 25),
          Obx(() {
            return SaveButton(
              onPressed: controller.formIsValid()
                  ? () async {
                      if (await controller.editCharacter()) {
                        Get.back();
                      }
                    }
                  : null,
              text: "character_save_button".tr,
            );
          }),
        ]),
      ),
    );
  }
}
