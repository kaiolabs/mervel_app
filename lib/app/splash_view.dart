import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mervel_app/core/extensions/context_extensions.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  init() async {
    Box box = Hive.box('logged');

    Future.delayed(
      const Duration(milliseconds: 1700),
      () {
        if (box.get('logged') == true) {
          Modular.to.pushReplacementNamed('/home/');
        } else {
          Modular.to.pushReplacementNamed('/sign/');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 700),
                builder: (context, double value, child) {
                  return AnimatedOpacity(
                    opacity: value,
                    onEnd: () {},
                    duration: const Duration(milliseconds: 700),
                    child: Transform.scale(scale: value, child: child),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
