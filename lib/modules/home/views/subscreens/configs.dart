import 'package:flutter/material.dart';
import 'package:mervel_app/core/components/button_pattern.dart';
import 'package:mervel_app/core/components/page_state.dart';
import 'package:mervel_app/core/extensions/context_extensions.dart';
import 'package:mervel_app/modules/home/controller/home_controller.dart';
import 'package:mervel_app/modules/home/views/components/dialog_exit_app.dart';

import '../../../../core/components/text_pattern.dart';

class Configs extends StatefulWidget {
  const Configs({super.key});

  @override
  State<Configs> createState() => _ConfigsState();
}

class _ConfigsState extends PageState<Configs, HomeController> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 16, bottom: 48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              TextPattern(
                color: context.primaryColor,
                text: 'Configurações',
                fontSize: 22,
              ).bold(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextPattern(
                text: 'Tema escuro',
                fontSize: 18,
              ).regular(),
              ValueListenableBuilder(
                valueListenable: controller.isThemeDark,
                builder: (context, value, child) => Switch(
                  value: controller.isThemeDark.value,
                  onChanged: (value) async {
                    await controller.toogleTheme();
                  },
                  activeColor: context.primaryColor,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 24, right: 24, top: 48),
          child: ButtonPattern(
            label: 'Logout',
            onPressed: () async {
              dialogExitApp(
                () async {
                  await controller.logout();
                },
                context,
              );
            },
          ),
        )
      ],
    );
  }
}
