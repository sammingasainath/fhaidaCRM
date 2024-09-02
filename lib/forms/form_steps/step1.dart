import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models.dart';
import '../property_form.dart';

class Step1Form extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formNotifier = ref.read(LeadFormProvider.notifier);
    final selectedAction = ref.watch(LeadFormProvider).action;

    LeadFormNotifier().updateAction(LeadAction.purchaseFrom);

    // Simplified action representations
    final List<Map<String, dynamic>> actions = [
      {
        'action': LeadAction.purchaseFrom,
        'label': 'Sell',
        'icon': Icons.shopping_bag
      },
      {
        'action': LeadAction.sellTo,
        'label': 'Buy',
        'icon': Icons.monetization_on
      },
      {'action': LeadAction.rentTo, 'label': 'Rent ', 'icon': Icons.home},
      {'action': LeadAction.toLet, 'label': ' To Let', 'icon': Icons.vpn_key},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What Will This Lead Do ?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.black87,
                ),
          ),
          // SizedBox(height: 32),
          ...actions.map((action) => _buildActionTile(
                context,
                action['action'],
                action['label'],
                action['icon'],
                selectedAction ?? LeadAction.purchaseFrom,
                formNotifier,
              )),
        ],
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, LeadAction action, String label,
      IconData icon, LeadAction selectedAction, LeadFormNotifier formNotifier) {
    final isSelected = action == selectedAction;
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            formNotifier.updateAction(action);
            print(action);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.grey[300]!,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              // CHANGE: Wrap the Row with an Expanded widget
              children: [
                Expanded(
                  // Add this Expanded widget
                  child: Row(
                    // Wrap the existing Row content with this new Row
                    children: [
                      Icon(
                        icon,
                        color: isSelected ? Colors.white : Colors.grey[600],
                        size: 28,
                      ),
                      SizedBox(width: 24),
                      // CHANGE: Wrap the Text widget with Expanded
                      Expanded(
                        child: Text(
                          label,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                // CHANGE: Move the Spacer and check icon outside the Expanded widget
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 28,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
