import 'package:flutter/material.dart';

Widget makeTestableWidget(Widget widget) => MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    );
