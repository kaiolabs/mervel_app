// Context Extensions

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => size.height;
  double get width => size.width;
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get backgroundColor => Theme.of(this).colorScheme.background;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get colorText => Theme.of(this).textTheme.bodyLarge!.color!;
}
