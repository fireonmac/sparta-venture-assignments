import 'package:flutter/material.dart';
import 'package:flutter_basic_venture/src/styles.dart';

class ListItemContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;

  const ListItemContainer({
    super.key,
    required this.child,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? colorScheme.surface,
            borderRadius: Styles.cardBorderRadius,
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
