import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String label;
  final void Function(bool?)? onChanged;
  final bool initialValue;

  CustomCheckbox({
    required this.label,
    required this.onChanged,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Checkbox(
          value: initialValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
