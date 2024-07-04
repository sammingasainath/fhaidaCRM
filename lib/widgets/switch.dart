import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final String label;
  final void Function(bool) onChanged;
  final bool initialValue;
  final Color activeColor;

  CustomSwitch({
    required this.label,
    required this.onChanged,
    required this.initialValue,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Switch(
          value: initialValue,
          onChanged: onChanged,
          activeColor: activeColor,
          activeTrackColor: Color.fromARGB(255, 208, 171, 229),
          trackOutlineColor: MyColor(),
        ),
      ],
    );
  }
}

class MyColor extends WidgetStateColor {
  const MyColor() : super(23);
  @override
  Color resolve(Set<WidgetState> states) {
    return const Color.fromARGB(255, 208, 171, 229);
  }
}
