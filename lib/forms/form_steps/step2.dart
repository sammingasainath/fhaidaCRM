import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models.dart';
import '../property_form.dart';

class Step2Form extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(LeadFormProvider);
    final formNotifier = ref.read(LeadFormProvider.notifier);
    final leadDetails = formData.leadDetails ?? {};

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'What type of property?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.black87,
                ),
          ),
          // SizedBox(height: 24),
          _buildPropertyTypeSelector(context, formData, formNotifier),
          SizedBox(height: 16),
          if (formData.propertyTypes!.isEmpty)
            Text(
              'Please select at least one property type',
              style: TextStyle(color: Colors.redAccent, fontSize: 14),
            ),
        ],
      ),
    );
  }

  Widget _buildPropertyTypeSelector(BuildContext context, LeadFormData formData,
      LeadFormNotifier formNotifier) {
    final isSingleSelection = formData.action == LeadAction.purchaseFrom ||
        formData.action == LeadAction.toLet;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: PropertyType.values.map((type) {
        final isSelected = formData.propertyTypes!.contains(type);
        return _buildPropertyTypeChip(
          context,
          type,
          isSelected,
          (selected) {
            if (isSingleSelection) {
              formNotifier.updatePropertyTypes([type]);
            } else {
              List<PropertyType> updatedTypes =
                  List.from(formData.propertyTypes!);
              if (selected) {
                updatedTypes.add(type);
              } else {
                updatedTypes.remove(type);
              }
              formNotifier.updatePropertyTypes(updatedTypes);
            }
          },
        );
      }).toList(),
    );
  }

  Widget _buildPropertyTypeChip(BuildContext context, PropertyType type,
      bool isSelected, Function(bool) onSelected) {
    return Material(
      color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => onSelected(!isSelected),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey[300]!,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatPropertyType(type),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              if (isSelected) ...[
                SizedBox(width: 8),
                Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatPropertyType(PropertyType type) {
    final typeName = type.toString().split('.').last;
    return typeName
        .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (Match match) => '${match.group(1)} ${match.group(2)}',
        )
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' '); // Capitalize each word
  }
}
