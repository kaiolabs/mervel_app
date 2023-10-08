import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mervel_app/core/components/page_state.dart';
import 'package:mervel_app/modules/home/controller/home_controller.dart';

import '../../../../core/components/text_pattern.dart';
import '../components/card_character.dart';
import '../components/character_details.dart';
import '../components/skeleton_card_character.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends PageState<Home, HomeController> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.infiniteScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: ValueListenableBuilder(
        valueListenable: controller.isLoading,
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 16, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  TextPattern(
                    color: Theme.of(context).primaryColor,
                    text: 'Home',
                    fontSize: 22,
                  ).bold(),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller.characters,
              builder: (context, value, child) => Visibility(
                visible: controller.characters.value.isNotEmpty,
                replacement: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) => const SkeletonCardCharacter(),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.characters.value.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CardCharacter(
                    character: controller.characters.value[index],
                    onTap: () {
                      Modular.to.push(MaterialPageRoute(
                        builder: (context) => CharacterDetails(
                          character: controller.characters.value[index],
                        ),
                      ));
                    },
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller.characters,
              builder: (context, value, child) => Visibility(
                visible: controller.isLoading.value,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => const SkeletonCardCharacter(),
                ),
              ),
            ),
            Visibility(
              visible: controller.isLoading.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
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
