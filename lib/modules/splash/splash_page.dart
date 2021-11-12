import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16
      ),
      width: double.infinity,
      height: double.infinity,
      color: Colors.red,
      child: Center(
        child: Image.asset("assets/marvel_logo.png"),
      )
    );
  }
}