import 'package:flutter/material.dart';
import 'package:mervel_app/core/extensions/context_extensions.dart';
import 'package:mervel_app/core/services/entities/character_entitie.dart';

import '../../../../core/components/image_loader.dart';
import '../../../../core/components/text_pattern.dart';
import '../../../../core/theme/size_outlet.dart';

class CardCharacter extends StatefulWidget {
  final CharacterEntitie character;
  final Function() onTap;
  const CardCharacter({super.key, required this.character, required this.onTap});

  @override
  State<CardCharacter> createState() => _CardCharacterState();
}

class _CardCharacterState extends State<CardCharacter> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(12),
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ImageLoader(
                    url: widget.character.thumbnail,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextPattern(
                  text: widget.character.name,
                  fontSize: 16,
                ).bold(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
