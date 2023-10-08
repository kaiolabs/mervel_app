import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'core/init/init_app.dart';
import 'core/services/server/init/init_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await InitDatabase().initSupaBase();
  await InitApp().initSorage();
  await InitApp().theme();

  runApp(
    ModularApp(module: AppModule(), child: const AppWidget()),
  );
}
