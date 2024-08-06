import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../forms/models.dart';
import '../forms/property_form.dart';
import '../forms/form_steps/step3/step3.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget buildMultiSelectFacing(
    BuildContext context, WidgetRef ref, String title) {
  final formData = ref.watch(LeadFormProvider);
  final formNotifier = ref.read(LeadFormProvider.notifier);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('$title',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold)),
      SizedBox(height: 12),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: Facing.values.map((facing) {
          bool isSelected =
              (formData.leadDetails?['facing'] as List<Facing>? ?? [])
                  .contains(facing);
          return _buildFacingChip(context, facing, isSelected, ref);
        }).toList(),
      ),
    ],
  );
}

Widget _buildFacingChip(
    BuildContext context, Facing facing, bool isSelected, WidgetRef ref) {
  final formData = ref.watch(LeadFormProvider);
  final formNotifier = ref.read(LeadFormProvider.notifier);
  return FilterChip(
    label: Text(formatText(facing.toString().split('.').last)),
    selected: isSelected,
    onSelected: (selected) {
      List<Facing> currentFacings =
          List<Facing>.from(formData.leadDetails?['facing'] ?? []);
      if (selected) {
        currentFacings.add(facing);
      } else {
        currentFacings.remove(facing);
      }
      formNotifier.updateLeadDetails({'facing': currentFacings});
    },
    selectedColor: Theme.of(context).primaryColor.withOpacity(0.8),
    checkmarkColor: Colors.white,
    labelStyle: TextStyle(
      color: isSelected ? Colors.white : Colors.black87,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
    ),
    backgroundColor: Colors.grey[200],
    elevation: 2,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  );
}

String formatText(String input) {
  if (input.isEmpty) return '';

  // Capitalize the first letter
  String formatted = '${input[0].toUpperCase()}${input.substring(1)}';

  // Add space before uppercase letters and capitalize them
  formatted =
      formatted.replaceAllMapped(RegExp(r'(?<!^)(?=[A-Z])'), (Match match) {
    return ' ${match.group(0)}';
  });

  return formatted;
}
