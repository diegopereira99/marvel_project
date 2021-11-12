import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? value;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool required;
  const CustomTextField({required this.label, this.required = false, this.value, this.onChanged, this.validator, Key? key})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      validator: widget.validator,
      style: const TextStyle(color: Colors.white),
      initialValue: widget.value,
      minLines: 1,
      maxLines: 5,
      decoration: InputDecoration(
          labelText: "${widget.label} ${widget.required ? '*' : ''}",
          labelStyle: const TextStyle(color: Colors.white),
          floatingLabelStyle: const TextStyle(color: Colors.red)),
    );
  }
}
