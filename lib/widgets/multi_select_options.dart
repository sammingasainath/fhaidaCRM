import 'package:flutter/material.dart';

class CustomMultiSelect extends StatelessWidget {
  final String label;
  final List<String> options;
  final List<String> selectedOptions;
  final Function(List<String>) onSelectionChanged;

  CustomMultiSelect({
    required this.label,
    required this.options,
    required this.selectedOptions,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Wrap(
          spacing: 10.0,
          children: options.map((option) {
            return FilterChip(
              label: Text(option),
              selected: selectedOptions.contains(option),
              onSelected: (bool selected) {
                final newSelectedOptions = List<String>.from(selectedOptions);
                if (selected) {
                  newSelectedOptions.add(option);
                } else {
                  newSelectedOptions.remove(option);
                }
                onSelectionChanged(newSelectedOptions);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
