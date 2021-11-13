import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CharacterFormEmptyImageContainer extends StatelessWidget {
  const CharacterFormEmptyImageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Icon(
          Icons.photo,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          "character_add_image_container".tr,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }
}
