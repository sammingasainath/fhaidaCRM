import 'package:anucivil_client/utils/formatText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models.dart';
import '../property_form.dart';
import 'step3/step3.dart';

class Step5Form extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(LeadFormProvider);
    final formNotifier = ref.read(LeadFormProvider.notifier);

    // Get the current 'Listed By' value
    final listedBy = formData.leadDetails['listedBy'] as ListedBy?;

    Widget _buildBasicDetails(BuildContext context, WidgetRef ref) {
      return Column(children: [
        DropdownButtonFormField<ListedBy>(
          decoration: InputDecoration(labelText: 'Listed By'),
          items: ListedBy.values.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(formatText(type.toString().split('.').last)),
            );
          }).toList(),
          onChanged: (value) {
            formNotifier.updateLeadDetails({'listedBy': value});
          },
          value: listedBy,
        ),
        if (listedBy != ListedBy.owner) ...[
          TextFormField(
            decoration: InputDecoration(labelText: 'Associate Name'),
            onChanged: (value) =>
                formNotifier.updateLeadDetails({'associateName': value}),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Associate Number'),
            keyboardType: TextInputType.phone,
            onChanged: (value) =>
                formNotifier.updateLeadDetails({'associateNumber': value}),
          ),
          if (formData.action == LeadAction.purchaseFrom ||
              formData.action == LeadAction.toLet)
            TextFormField(
              decoration: InputDecoration(labelText: 'Owner Name'),
              onChanged: (value) =>
                  formNotifier.updateLeadDetails({'ownerName': value}),
            ),
          if (formData.action == LeadAction.purchaseFrom ||
              formData.action == LeadAction.toLet)
            TextFormField(
              decoration: InputDecoration(labelText: 'Owner Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) =>
                  formNotifier.updateLeadDetails({'ownerPhoneNumber': value}),
            ),
        ] else ...[
          if (formData.action == LeadAction.purchaseFrom ||
              formData.action == LeadAction.toLet)
            TextFormField(
              decoration: InputDecoration(labelText: 'Owner Name'),
              onChanged: (value) =>
                  formNotifier.updateLeadDetails({'sellerName': value}),
            ),
          if (formData.action == LeadAction.purchaseFrom ||
              formData.action == LeadAction.toLet)
            TextFormField(
              decoration: InputDecoration(labelText: 'Owner Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) =>
                  formNotifier.updateLeadDetails({'sellerPhoneNumber': value}),
            ),
        ],
      ]);
    }

    return _buildBasicDetails(context, ref);
  }
}
