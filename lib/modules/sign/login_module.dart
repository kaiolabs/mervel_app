import 'package:flutter_modular/flutter_modular.dart';

import 'controller/sign_controller.dart';
import 'view/sign_view.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => SignController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => SignView(controller: Modular.get<SignController>())),
      ];
}
