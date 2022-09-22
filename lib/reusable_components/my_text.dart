import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  String s;
  double size = 20;
  MyText({
    Key? key,
    required this.s,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      s,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}
