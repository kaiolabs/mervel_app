import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../log/log_pattern.dart';
import '../db/tables.dart';
import '../methods/methods_api.dart';

class Sign {
  MethodsApi methods = MethodsApi();

  Tables db = Tables();
  LogPattern log = LogPattern();

  Future<(bool status, String result)> signIn({required String email, required String password}) async {
    try {
      final res = await methods.get(table: Tables.users, filter: {'email': email});

      if (res.isNotEmpty) {
        if (res.first['senha'] == password) {
          return (true, 'Login realizado com sucesso');
        } else {
          return (false, 'Senha ou email incorretos');
        }
      } else {
        return (false, 'Usuário não encontrado');
      }
    } on AuthException catch (status) {
      log.wtf('Erro ao logar: $status');
      return (false, status.message);
    }
  }
}
