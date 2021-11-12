import 'package:flutter/material.dart';

class ButtonSheetItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const ButtonSheetItem({required this.title, this.onTap, key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        onTap: onTap);
  }
}
