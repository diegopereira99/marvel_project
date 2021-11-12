import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final double? progress;
  const CustomLoading({this.progress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        value: progress);
  }
}
