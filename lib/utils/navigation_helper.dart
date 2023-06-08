import 'package:flutter/material.dart';

class NavigationHelper {
  static push(BuildContext context, Widget targetClass) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => targetClass));
  }

  static pushReplacement(BuildContext context, Widget targetClass) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => targetClass));
  }
}
