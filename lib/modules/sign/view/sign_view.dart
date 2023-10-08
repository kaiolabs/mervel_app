import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mervel_app/core/components/button_pattern_request.dart';
import 'package:mervel_app/core/components/snack_bar_messenger.dart';
import 'package:mervel_app/core/extensions/context_extensions.dart';
import 'package:mervel_app/core/theme/color_outlet.dart';

import '../../../core/components/input_field_pattern.dart';
import '../../../core/components/page_state.dart';
import '../../../core/components/text_pattern.dart';
import '../controller/sign_controller.dart';

class SignView extends StatefulWidget {
  final SignController controller;
  const SignView({super.key, required this.controller});

  @override
  State<SignView> createState() => SignViewState();
}

class SignViewState extends PageState<SignView, SignController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ButtonPatternRequest(
          isLoading: controller.isLoading,
          label: 'Entrar',
          onPressed: () async {
            await controller.signIn().then((value) {
              if (value.$1) {
                Modular.to.pushNamedAndRemoveUntil('/home/', (route) => false);
                snackBarMessenger(context: context, message: value.$2);
              } else {
                snackBarMessenger(context: context, message: value.$2, color: ColorOutlet.errorColor);
              }
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  bottom: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TextPattern(
                          text: 'Bem vindo a',
                          fontSize: 24,
                        ).bold(),
                        TextPattern(
                          color: context.primaryColor,
                          text: ' Marvel Studios',
                          fontSize: 24,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ).bold(),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextPattern(
                      text: 'Um universo de heróis, venha conhecer!',
                      fontSize: 16,
                    ).regular(),
                  ],
                ),
              ),
              Column(
                children: [
                  InputFieldPattern(
                    prefixIcon: FontAwesomeIcons.user,
                    label: 'Email',
                    maxLength: 100,
                    controller: controller.emailControllerLogin,
                  ),
                  InputFieldPattern(
                    prefixIcon: FontAwesomeIcons.lock,
                    passwordMode: true,
                    label: 'Senha',
                    maxLength: 100,
                    controller: controller.passwordControllerLogin,
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
