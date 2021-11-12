import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final void Function(String)? onChanged;
  const SearchField({this.onChanged, Key? key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 45,
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: TextField(
          onChanged: widget.onChanged,
          decoration: InputDecoration(
              hintText: "Pesquisar...",
              border: InputBorder.none,
              suffixIcon:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))),
        ),
      ),
    );
  }
}
