import 'package:daily_verse/reusable_components/colors.dart';
import 'package:flutter/material.dart';



Container circularProgress(){
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 10.0),
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(turquoise)
    ),
  );
}


Container linearProgress(){
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(bottom: 10.0),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(turquoise)
    ),
  );
}