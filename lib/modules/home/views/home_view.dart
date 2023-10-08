// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mervel_app/modules/home/views/subscreens/configs.dart';
import 'package:mervel_app/modules/home/views/subscreens/home.dart';

import '../../../core/components/page_state.dart';
import '../controller/home_controller.dart';
import 'components/buttom_navigation_Bar.dart';
import 'components/dialog_exit_app.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends PageState<HomeView, HomeController> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: controller.currentPage,
        builder: (context, value, child) => SizedBox(
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: buttonNavigationBar(
                  label: 'Home',
                  icon: FontAwesomeIcons.house,
                  context: context,
                  onTap: () {
                    controller.currentPage.value = 0;
                    controller.pageController.jumpToPage(0);
                  },
                  selected: controller.currentPage.value == 0,
                ),
              ),
              Expanded(
                child: buttonNavigationBar(
                  label: 'Configs',
                  icon: FontAwesomeIcons.slidersH,
                  context: context,
                  onTap: () {
                    controller.currentPage.value = 1;
                    controller.pageController.jumpToPage(1);
                  },
                  selected: controller.currentPage.value == 1,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            dialogExitApp(
              () async {
                SystemNavigator.pop();
              },
              context,
            );
            return true;
          },
          child: ValueListenableBuilder(
            valueListenable: controller.user,
            builder: (context, value, child) => Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    children: const [
                      Home(),
                      Configs(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
