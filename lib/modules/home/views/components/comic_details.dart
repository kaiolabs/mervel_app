import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mervel_app/core/components/image_loader.dart';
import 'package:mervel_app/core/components/text_pattern.dart';
import 'package:mervel_app/core/extensions/context_extensions.dart';
import 'package:mervel_app/core/extensions/string_extensions.dart';
import 'package:mervel_app/core/services/entities/comic_entitie.dart';

import '../../../../core/components/button_pattern.dart';

class ComicDetails extends StatefulWidget {
  final ComicEntitie comic;
  const ComicDetails({super.key, required this.comic});

  @override
  State<ComicDetails> createState() => _ComicDetailsState();
}

class _ComicDetailsState extends State<ComicDetails> {
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextPattern(
                  text: widget.comic.title,
                  color: context.primaryColor,
                  fontSize: 18,
                  textAlign: TextAlign.center,
                ).bold(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: SizedBox(
                        height: 370,
                        child: ImageLoader(
                          url: widget.comic.thumbnail,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 8),
                      child: TextPattern(
                        text: 'Produtores',
                        fontSize: 18,
                        color: context.primaryColor,
                      ).bold(),
                    ),
                    ListView.builder(
                      itemCount: widget.comic.creators.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextPattern(
                            text: widget.comic.creators[index].role.toCapitalize,
                            fontSize: 16,
                          ).bold(),
                          TextPattern(
                            text: widget.comic.creators[index].name,
                            fontSize: 16,
                          ).regular(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    TextPattern(
                      text: 'Descrição',
                      fontSize: 18,
                      color: context.primaryColor,
                    ).bold(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16, top: 8),
                      child: TextPattern(
                        text: widget.comic.description.isEmpty ? 'Sem descrição' : widget.comic.description,
                        fontSize: 16,
                      ).regular(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
