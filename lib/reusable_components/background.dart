import 'package:flutter/material.dart';

class Backg extends StatelessWidget {
  const Backg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
            top: -530,
            left: 30,
            child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/images/backg1.png',
                  width: size.width * 2,
                  height: size.height * 2,
                ))),
        Positioned(
            top: size.height * 1 / 5,
            left: -150,
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                "assets/images/backg2.png",
                width: size.width*1.2,
                height: size.height*1.2,
              ),
            )),
      ],
    );
  }
}
