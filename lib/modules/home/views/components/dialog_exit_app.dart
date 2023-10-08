import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mervel_app/core/extensions/context_extensions.dart';

import '../../../../core/components/dialog_pattern.dart';
import '../../../../core/components/text_pattern.dart';

dialogExitApp(Function() onConfirm, BuildContext context) {
  return DialogPattern.show(
    backgroundColor: context.backgroundColor,
    width: 0.8,
    padding: const EdgeInsets.all(16),
    context: context,
    child: Material(
      color: context.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextPattern(
            text: 'Sair',
            fontSize: 18,
            color: context.primaryColor,
          ).bold(),
          const SizedBox(height: 16),
          TextPattern(
            text: 'Deseja realmente sair da aplicação?',
            fontSize: 16,
          ).regular(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Modular.to.pop();
                },
                child: TextPattern(
                  text: 'Cancelar',
                  fontSize: 16,
                  color: context.primaryColor,
                ).bold(),
              ),
              TextButton(
                onPressed: () async {
                  await onConfirm();
                },
                child: TextPattern(
                  text: 'Sair',
                  fontSize: 16,
                  color: context.primaryColor,
                ).bold(),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
