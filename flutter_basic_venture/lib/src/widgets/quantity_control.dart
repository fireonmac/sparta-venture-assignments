import 'package:flutter/material.dart';

class QuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback? onDecrement;

  const QuantityControl({
    super.key,
    required this.quantity,
    required this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final isMinDisabled = quantity <= 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _ControlButton(
          icon: Icons.remove,
          onPressed: isMinDisabled ? null : onDecrement,
          isDisabled: isMinDisabled,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            quantity.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        _ControlButton(
          icon: Icons.add,
          onPressed: onIncrement,
          isDisabled: false,
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isDisabled;

  const _ControlButton({
    required this.icon,
    required this.onPressed,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDisabled ? theme.disabledColor : theme.colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isDisabled ? theme.disabledColor : theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
