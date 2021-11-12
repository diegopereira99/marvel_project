import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {

  final void Function()? onPressed;
  final String text;

  const SaveButton({required this.onPressed, required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            minimumSize:
                MaterialStateProperty.all(const Size(double.infinity, 40))),
        child: Text(text,
            style: const TextStyle(color: Colors.white, fontSize: 16)));
  }
}
