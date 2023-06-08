import 'package:flutter/material.dart';

extension Space on num {
  SizedBox get sH => SizedBox(height: toDouble());

  SizedBox get sW => SizedBox(width: toDouble());
}

extension ContextExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get theme => Theme.of(this);

  Orientation get orientation => MediaQuery.of(this).orientation;
}
