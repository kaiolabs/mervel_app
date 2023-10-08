import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mervel_app/core/components/button_pattern.dart';
import 'package:mervel_app/core/components/text_pattern.dart';
import 'package:mervel_app/core/extensions/context_extensions.dart';
import 'package:mervel_app/core/services/entities/character_entitie.dart';
import 'package:mervel_app/core/services/entities/item_entitie.dart';
import 'package:mervel_app/core/services/marvel_api/marvel_api.dart';
import 'package:mervel_app/modules/home/views/components/comic_details.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../core/components/image_loader.dart';
import '../../../../core/services/entities/comic_entitie.dart';
import '../../../../core/theme/size_outlet.dart';

class CharacterDetails extends StatefulWidget {
  final CharacterEntitie character;
  const CharacterDetails({super.key, required this.character});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  final PageController _pageController = PageController(initialPage: 0);
  MarvelApi marvelApi = MarvelApi();
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      for (ItemEntitie item in widget.character.comics) {
        final ComicEntitie comic = await marvelApi.getComic(item.resourceURI);
        widget.character.comicsEntities.add(comic);
      }
      isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonPattern(
          label: 'Voltar',
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.95,
              margin: const EdgeInsets.only(top: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
                child: ImageLoader(
                  url: widget.character.thumbnail,
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _selectedIndex,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.only(top: 22, left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _navigationBarTitle(context, 'Character', _selectedIndex.value == 0, onTap: () {
                      _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    }),
                    _navigationBarTitle(context, 'Comics', _selectedIndex.value == 1, onTap: () {
                      _pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  _selectedIndex.value = value;
                },
                children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(top: 12, left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextPattern(
                            text: widget.character.name,
                            fontSize: 18,
                          ).extraBold(),
                          const SizedBox(height: 8),
                          TextPattern(
                            text: widget.character.description.isEmpty ? 'Sem descrição' : widget.character.description,
                            fontSize: 16,
                          ).regular(),
                        ],
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, value, child) => Container(
                      padding: const EdgeInsets.only(top: 12, left: 24, right: 24),
                      child: Visibility(
                        visible: !isLoading.value,
                        replacement: GridView.builder(
                          itemCount: 6,
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 280,
                          ),
                          itemBuilder: (context, index) => SkeletonItem(
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                  height: 300, width: MediaQuery.of(context).size.width * 0.9, borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        child: GridView.builder(
                          itemCount: widget.character.comicsEntities.length,
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 280,
                          ),
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Modular.to.push(
                                MaterialPageRoute(builder: (context) => ComicDetails(comic: widget.character.comicsEntities[index])),
                              );
                            },
                            child: ImageLoader(url: widget.character.comicsEntities[index].thumbnail),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _navigationBarTitle(BuildContext context, String title, bool isSelect, {Function()? onTap}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      child: Column(
        children: [
          TextPattern(
            text: title,
            color: isSelect ? context.primaryColor : null,
            fontSize: 16,
          ).bold(),
          const SizedBox(height: 4),
          Visibility(
            visible: isSelect,
            child: Container(
              height: 4,
              width: 100,
              decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
