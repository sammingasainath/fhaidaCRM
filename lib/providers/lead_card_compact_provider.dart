import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lead.dart';
import '../appwrite/services/crud_service.dart';

final isLoadingProvider = StateProvider<bool>((ref) => false);
final leadsProvider = StateProvider<List<Lead>>((ref) => []);
final buttonTextProvider = StateProvider<String>((ref) => 'Load Leads');

// Function to fetch leads and update the state
Future<void> fetchLeads(WidgetRef ref, String eventId) async {
  ref.read(isLoadingProvider.notifier).state = true;
  ref.read(buttonTextProvider.notifier).state = 'Loading...';

  List<Lead> leads = await readLeadsWithEvent(eventId);

  ref.read(leadsProvider.notifier).state = leads;
  ref.read(isLoadingProvider.notifier).state = false;
  ref.read(buttonTextProvider.notifier).state =
      leads.isNotEmpty ? 'Hide Leads' : 'No Leads Found';
}
