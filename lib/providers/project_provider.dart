import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';
import '../models/lead.dart';
import '../services/project_repository.dart';
import '../appwrite/services/crud_service.dart';

// Appwrite client provider
final appwriteClientProvider = Provider<Client>((ref) {
  final client = Client();
  client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('669f8f9b000b799d55e7')
      .setSelfSigned(status: true); // Use only in development
  return client;
});

// Project repository provider
final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  final client = ref.read(appwriteClientProvider);
  return ProjectRepository(client: client);
});

// Lead list provider
final leadListProvider = FutureProvider<List<Lead>>((ref) {
  final repository = ref.read(projectRepositoryProvider);
  return repository.getLeads();
});

// Dashboard tab enum
enum DashboardTab {
  all,
  buy,
  sell,
  rent,
  toLet,
}

// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Dashboard tab provider
final dashboardTabProvider =
    StateProvider<DashboardTab>((ref) => DashboardTab.all);

// Filtered lead list provider
final filteredLeadListProvider = Provider<AsyncValue<List<Lead>>>((ref) {
  final leadsAsyncValue = ref.watch(leadListProvider);
  final selectedTab = ref.watch(dashboardTabProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  return leadsAsyncValue.whenData((leads) {
    List<Lead> filteredLeads = leads;
    switch (selectedTab) {
      case DashboardTab.buy:
        filteredLeads = filteredLeads
            .where((lead) => lead.leadType == LeadType.buy)
            .toList();
        break;
      case DashboardTab.sell:
        filteredLeads = filteredLeads
            .where((lead) => lead.leadType == LeadType.sell)
            .toList();
        break;
      case DashboardTab.rent:
        filteredLeads = filteredLeads
            .where((lead) => lead.leadType == LeadType.rent)
            .toList();
        break;
      case DashboardTab.toLet:
        filteredLeads = filteredLeads
            .where((lead) => lead.leadType == LeadType.tolet)
            .toList();
        break;
      case DashboardTab.all:
      default:
        break;
    }
    if (searchQuery.isNotEmpty) {
      filteredLeads = filteredLeads.where((lead) {
        return lead.toMap().values.any((value) {
          if (value == null) return false;
          return value.toString().toLowerCase().contains(searchQuery);
        });
      }).toList();
    }
    return filteredLeads;
  });
});

// Selected leads provider
final selectedLeadsProvider =
    StateNotifierProvider<SelectedLeadsNotifier, List<String>>((ref) {
  return SelectedLeadsNotifier();
});

class SelectedLeadsNotifier extends StateNotifier<List<String>> {
  SelectedLeadsNotifier() : super([]);

  void toggleLead(String leadId) {
    if (state.contains(leadId)) {
      state = state.where((id) => id != leadId).toList();
    } else {
      state = [...state, leadId];
    }
  }

  void clearSelection() {
    state = [];
  }
}

// Schedule visit button visibility provider
final showScheduleVisitButtonProvider = Provider<bool>((ref) {
  return ref.watch(selectedLeadsProvider).isNotEmpty;
});

// Segregated selected leads provider
final segregatedSelectedLeadsProvider =
    Provider<Map<String, List<String>>>((ref) {
  final selectedLeads = ref.watch(selectedLeadsProvider);
  final allLeads = ref.watch(leadListProvider).value ?? [];

  final buyRentLeads = <String>[];
  final sellToLetLeads = <String>[];

  for (final leadId in selectedLeads) {
    final lead = allLeads.firstWhere((l) => l.id == leadId);
    if (lead.leadType == LeadType.buy || lead.leadType == LeadType.rent) {
      buyRentLeads.add(leadId);
    } else if (lead.leadType == LeadType.sell ||
        lead.leadType == LeadType.tolet) {
      sellToLetLeads.add(leadId);
    }
  }

  return {
    'buyRent': buyRentLeads,
    'sellToLet': sellToLetLeads,
  };
});

// Event service provider
final eventProvider =
    Provider((ref) => EventService(ref.read(appwriteClientProvider)));

class EventService {
  final Client client;

  EventService(this.client);

  Future<void> createEventAndUpdateLeads(DateTime dateTime,
      List<String> buyerLeads, List<String> propertyLead) async {
    bool fed = await getEventIds(dateTime);
    // print(fed);
    if (fed == false) {
      final databases = Databases(client);
      final eventId = await databases.createDocument(
        databaseId: '66a217bc0001534c6851',
        collectionId: 'events',
        documentId: ID.unique(),
        data: {
          'eventDate': dateTime.toIso8601String(),
          'propertyLead': propertyLead,
          'buyerLeads': buyerLeads
        },
      );

      print(propertyLead);
      print(buyerLeads);

      for (String leadId in propertyLead) {
        var propertyLead = await databases.getDocument(
          databaseId: '66a217bc0001534c6851',
          collectionId: 'property_lead',
          documentId: leadId,
        );
        await databases.updateDocument(
          databaseId: '66a217bc0001534c6851',
          collectionId: 'property_lead',
          documentId: leadId,
          data: {
            'events': [...propertyLead.data['events'], eventId.$id],
          },
        );
      }

      for (String leadId in buyerLeads) {
        var buyerLead = await databases.getDocument(
          databaseId: '66a217bc0001534c6851',
          collectionId: 'buyer_lead',
          documentId: leadId,
        );
        await databases.updateDocument(
          databaseId: '66a217bc0001534c6851',
          collectionId: 'buyer_lead',
          documentId: leadId,
          data: {
            'events': [...buyerLead.data['events'], eventId.$id],
          },
        );
      }
    } else {
      throw Exception('Dates are Clashing');
    }
  }
}
