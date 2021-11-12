import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel_test/models/character_model.dart';
import 'package:marvel_test/shared/widgets/custom_loading.dart';

class CharacterCard extends StatefulWidget {
  final CharacterModel character;
  final VoidCallback? onTap;

  const CharacterCard({required this.character, this.onTap, Key? key}) : super(key: key);

  @override
  _CharacterCardState createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.transparent,
        height: 75,
        child: Row(
          children: [
            SizedBox(
              height: 75,
              width: 75,
              child: CachedNetworkImage(
                imageUrl:
                    "${widget.character.image}",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                        alignment: Alignment.center,
                        height: 5,
                        width: 5,
                        child: CustomLoading(progress: downloadProgress.progress)),
                errorWidget: (context, url, error) =>
                    widget.character.image != null ? Image.file(File(widget.character.image!)) : const Icon(Icons.error, color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.character.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.character.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
