import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/services/server/sign/sign.dart';

class SignController extends ChangeNotifier {
  TextEditingController emailControllerLogin = TextEditingController();
  TextEditingController passwordControllerLogin = TextEditingController();
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  clearControllersSignIn() {
    emailControllerLogin.clear();
    passwordControllerLogin.clear();
    isLoading.value = false;
  }

  Future<(bool, String)> signIn() async {
    isLoading.value = true;
    Box box = await Hive.openBox('logged');
    Box boxemail = await Hive.openBox('email');

    final res = await Sign().signIn(email: emailControllerLogin.text, password: passwordControllerLogin.text);

    if (res.$1) {
      box.put('logged', true);
      boxemail.put('email', emailControllerLogin.text);
    }

    isLoading.value = false;
    return res;
  }
}
