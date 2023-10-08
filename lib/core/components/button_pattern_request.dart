import 'package:flutter/material.dart';
import 'package:mervel_app/core/extensions/context_extensions.dart';

import '../theme/size_outlet.dart';
import 'button_pattern.dart';

class ButtonPatternRequest extends ButtonPattern {
  final ValueNotifier<bool> isLoading;

  const ButtonPatternRequest({
    super.key,
    required this.isLoading,
    required String label,
    required Function() onPressed,
  }) : super(
          label: label,
          onPressed: onPressed,
          textColor: Colors.white,
        );

  @override
  Function() get onPressed {
    return () {
      super.onPressed!();
    };
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (context, value, child) {
        return value
            ? Container(
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizePattern),
                ),
                width: MediaQuery.of(context).size.width,
                height: 56,
                child: Material(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizePattern),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizePattern),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            : super.build(context);
      },
    );
  }
}
