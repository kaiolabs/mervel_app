import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/theme/preferences_theme.dart';
import '../core/theme/theme_data_app.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: PreferencesTheme.brightness,
      builder: (context, theme, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Marvel App',
          theme: PreferencesTheme.brightness.value == Brightness.light ? ThemeDataApp().lightTheme : ThemeDataApp().darkTheme,
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
        );
      },
    );
  }
}
