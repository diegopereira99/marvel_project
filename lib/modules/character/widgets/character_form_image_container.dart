import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marvel_test/shared/widgets/custom_loading.dart';

class CharacterFormImageContainer extends StatelessWidget {
  final String image;
  const CharacterFormImageContainer({required this.image, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                              alignment: Alignment.center,
                              height: 5,
                              width: 5,
                              child: CustomLoading(
                                  progress: downloadProgress.progress)),
                      errorWidget: (context, url, error) =>
                          Image.file(File(image)),
                    );
  }
}