import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mervel_app/core/extensions/context_extensions.dart';

import '../../../../core/components/text_pattern.dart';

buttonNavigationBar({
  required String label,
  required IconData icon,
  required Function() onTap,
  bool selected = false,
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            size: 18,
            color: selected ? context.primaryColor : context.colorText,
            icon,
          ),
          TextPattern(
            text: label,
            fontSize: 14,
            color: selected ? context.primaryColor : context.colorText,
          ).medium()
        ],
      ),
    ),
  );
}
