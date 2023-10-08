import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mervel_app/core/services/entities/character_entitie.dart';
import 'package:mervel_app/core/theme/preferences_theme.dart';

import '../../../core/log/log_pattern.dart';
import '../../../core/services/marvel_api/marvel_api.dart';
import '../../../core/services/server/methods/methods_api.dart';
import '../models/clients.dart';

class HomeController extends ChangeNotifier {
  MethodsApi methods = MethodsApi();

  LogPattern log = LogPattern();

  ValueNotifier<Client> user = ValueNotifier<Client>(Client.empty());
  TextEditingController searchController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  PageController pageController = PageController(initialPage: 0);
  ValueNotifier<int> currentPage = ValueNotifier<int>(0);
  ValueNotifier<bool> isMoreOptions = ValueNotifier<bool>(false);

  ValueNotifier<List<CharacterEntitie>> characters = ValueNotifier<List<CharacterEntitie>>([]);

  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> isThemeDark = ValueNotifier<bool>(false);

  String userId = '';

  MarvelApi marvelApi = MarvelApi();

  Future<bool> checkLogin() async {
    Box email = await Hive.openBox('email');
    userId = email.get('email').toString();

    if (userId.isEmpty) {
      Modular.to.navigate('/');
      Box box = await Hive.openBox('logged');
      box.put('logged', false);
      return false;
    } else {
      return true;
    }
  }

  Future<void> getCharacters() async {
    List<CharacterEntitie> list = [];
    try {
      list = await marvelApi.getCharacters();

      characters.value = list;
    } catch (e) {
      characters.value = [];
    }
  }

  Future<void> getCharactersPaginado() async {
    List<CharacterEntitie> list = [];
    try {
      list = await marvelApi.getCharacters();

      characters.value = [...characters.value, ...list];
    } catch (e) {
      characters.value = [];
    }
  }

  Future<void> infiniteScroll() async {
    scrollController.addListener(() async {
      if ((scrollController.position.pixels + 300) >= scrollController.position.maxScrollExtent) {
        if (!isLoading.value) {
          isLoading.value = true;
          await getCharactersPaginado();
          isLoading.value = false;
        }
      }
    });
  }

  Future<void> toogleTheme() async {
    Box box = Hive.box('theme');
    await box.put('theme', !box.get('theme'));
    PreferencesTheme.brightness.value = box.get('theme') ? Brightness.dark : Brightness.light;
    isThemeDark.value = box.get('theme');
  }

  Future<void> getTheme() async {
    Box box = await Hive.openBox('theme');
    isThemeDark.value = box.get('theme');
  }

  Future<void> logout() async {
    Box box = await Hive.openBox('logged');
    box.put('logged', false);
    Modular.to.navigate('/');
  }
}
