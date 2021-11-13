import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marvel_test/modules/character/create_character/create_character_controller.dart';
import 'package:marvel_test/modules/character/widgets/character_form_empty_image_container.dart';
import 'package:marvel_test/modules/character/widgets/custom_text_field.dart';
import 'package:marvel_test/modules/character/widgets/character_form_image_container.dart';
import 'package:marvel_test/modules/character/widgets/save_button.dart';
import 'package:marvel_test/validators/character_validator.dart';

class CreateCharacterPage extends StatefulWidget {
  const CreateCharacterPage({Key? key}) : super(key: key);

  @override
  _CreateCharacterPageState createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<CreateCharacterPage> {
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

  final controller = Get.find<CreateCharacterController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("character_new_appbar_title".tr),
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
            child: SizedBox(
                width: 150,
                height: 150,
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
            validator: CharacterValidator.validateName(),
            onChanged: controller.setName,
          ),
          const SizedBox(height: 15),
          CustomTextField(
              required: true,
              label: 'character_description_input'.tr,
              validator: CharacterValidator.validateDescription(),
              onChanged: controller.setDescription),
          const SizedBox(height: 25),
          Obx(() {
            return SaveButton(
              onPressed: controller.formIsValid()
                  ? () async {
                      if (await controller.createCharacter()) {
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
