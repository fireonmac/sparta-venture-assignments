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

  Widget _buildButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isDisabled,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDisabled ? Colors.grey.shade300 : Colors.grey.shade500,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isDisabled ? Colors.grey.shade400 : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMinDisabled = quantity <= 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildButton(
          icon: Icons.remove,
          onPressed: isMinDisabled ? null : onDecrement,
          isDisabled: isMinDisabled,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        _buildButton(
          icon: Icons.add,
          onPressed: onIncrement,
          isDisabled: false,
        ),
      ],
    );
  }
}
