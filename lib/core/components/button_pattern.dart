import 'package:flutter/material.dart';
import 'package:mervel_app/core/extensions/context_extensions.dart';

import '../theme/size_outlet.dart';
import 'text_pattern.dart';

class ButtonPattern extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? textColor;
  final String? fontFamily;
  final Function()? onPressed;
  const ButtonPattern({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor = Colors.white,
    this.fontFamily = 'Inter',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizePattern),
      ),
      width: MediaQuery.of(context).size.width,
      height: 56,
      child: Material(
        color: color ?? context.primaryColor,
        borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizePattern),
        child: InkWell(
          onTap: onPressed ?? () {},
          borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizePattern),
          child: Center(
              child: TextPattern(
            text: label,
            color: textColor ?? Colors.white,
          ).bold()),
        ),
      ),
    );
  }
}
