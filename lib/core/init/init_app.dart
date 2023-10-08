import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mervel_app/core/theme/preferences_theme.dart';

class InitApp {
  initSorage() async {
    await Hive.initFlutter();

    Box box = await Hive.openBox('logged');
    Box theme = await Hive.openBox('theme');

    if (box.get('logged') == null) {
      box.put('logged', false);
    }

    if (theme.get('theme') == null) {
      theme.put('theme', false);
    }
  }

  Future<void> theme() async {
    Box boxTheme = await Hive.openBox('theme');
    bool box = boxTheme.get('theme', defaultValue: false);
    PreferencesTheme.brightness.value = box ? Brightness.dark : Brightness.light;
  }
}
