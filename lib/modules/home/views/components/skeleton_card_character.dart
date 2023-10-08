import 'package:flutter/material.dart';
import 'package:mervel_app/core/extensions/context_extensions.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../core/theme/size_outlet.dart';

class SkeletonCardCharacter extends StatefulWidget {
  const SkeletonCardCharacter({super.key});

  @override
  State<SkeletonCardCharacter> createState() => _SkeletonCardCharacterState();
}

class _SkeletonCardCharacterState extends State<SkeletonCardCharacter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
      ),
      child: SkeletonItem(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.9,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 20,
                width: MediaQuery.of(context).size.width * 0.9,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
