import 'package:anucivil_client/appwrite/services/crud_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/project_provider.dart';
import '../notifiers/last_selected_tab_notifier.dart';
import '../widgets/lead_card.dart';
import '../models/lead.dart';
import '../services/sms_service.dart';
import '../widgets/schedule_visit_popup.dart';
import 'package:alarm/alarm.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      ref.read(searchQueryProvider.notifier).state = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lastSelectedTabIndex = ref.watch(lastSelectedTabProvider) ?? 0;
    final showScheduleVisitButton =
        ref.watch(showScheduleVisitButtonProvider) ?? false;

    return DefaultTabController(
      length: DashboardTab.values.length,
      initialIndex: lastSelectedTabIndex,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    const Text(
                      'What Will The Lead Do ?',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 16),
                    SearchBar(controller: _searchController),
                    TabBarWidget(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final selectedTab =
                      ref.watch(dashboardTabProvider) ?? DashboardTab.all;
                  return _buildTabContent(selectedTab, ref);
                },
              ),
            ),
          ],
        ),
        floatingActionButton: showScheduleVisitButton
            ? FloatingActionButton.extended(
                onPressed: () => _showScheduleVisitPopup(context),
                label: Text('Schedule Visit'),
                icon: Icon(Icons.schedule),
              )
            : null,
      ),
    );
  }

  Widget _buildTabContent(DashboardTab selectedTab, WidgetRef ref) {
    final leadListAsyncValue = ref.watch(filteredLeadListProvider);
    final selectedLeads = ref.watch(selectedLeadsProvider) ?? [];

    return leadListAsyncValue.when(
      data: (leads) => ListView.builder(
        itemCount: leads.length,
        itemBuilder: (context, index) {
          final lead = leads[index];
          return LeadCard(
            lead: lead,
            isSelected: selectedLeads.contains(lead.id),
            onTap: () =>
                ref.read(selectedLeadsProvider.notifier).toggleLead(lead.id),
          );
        },
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  int generateUniqueId() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch & 0x3FFFFF;
    final randomBits = random.nextInt(512);
    return (timestamp << 9) | randomBits;
  }

  void _showScheduleVisitPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScheduleVisitPopup(
          onSchedule: (DateTime selectedDateTime) async {
            final segregatedLeads =
                ref.read(segregatedSelectedLeadsProvider) ?? {};
            final eventService = ref.read(eventProvider);
            List<String> buyerLeads = segregatedLeads['buyRent'] ?? [];
            List<String> propertyLeads = segregatedLeads['sellToLet'] ?? [];

            ref.read(selectedLeadsProvider.notifier).clearSelection();

            try {
              Navigator.pop(context);

              for (var item in buyerLeads) {
                var item1 = await readBuyerLead(item);
                print(item1);

                String formattedDateTime =
                    DateFormat('MMMM d, yyyy h:mm a').format(selectedDateTime);
                await SmsService.sendSms(
                    message:
                        'Hello ${item1['buyerName']}, Your Site Visit is booked with aastee.com for visiting properties on ${formattedDateTime}',
                    recipient: item1['buyerPhoneNumber']);
              }
              await eventService.createEventAndUpdateLeads(
                  selectedDateTime, buyerLeads, propertyLeads);

              final alarmSettings = AlarmSettings(
                id: generateUniqueId(),
                dateTime: selectedDateTime.subtract(Duration(minutes: 45)),
                assetAudioPath: 'assets/alarm.mp3',
                loopAudio: true,
                vibrate: true,
                volume: 1,
                fadeDuration: 3.0,
                notificationTitle: 'Site Visit in 45 minutes',
                notificationBody: 'Check Your Calendars',
                enableNotificationOnKill: true,
              );

              print(await Alarm.set(alarmSettings: alarmSettings));

              Navigator.pushNamed(context, '/dashboard');

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Visit scheduled successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            } catch (e) {
              print(e);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to schedule visit. Please try again.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        );
      },
    );
  }
}

class TabBarWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leadListAsyncValue = ref.watch(filteredLeadListProvider);
    final leadListAsyncValue1 = ref.watch(leadListProvider);

    return leadListAsyncValue1.when(
      data: (leads) {
        int allCount = leads.length;
        int buyCount = leads.where((l) => l.leadType == LeadType.buy).length;
        int sellCount = leads.where((l) => l.leadType == LeadType.sell).length;
        int rentCount = leads.where((l) => l.leadType == LeadType.rent).length;
        int toLetCount =
            leads.where((l) => l.leadType == LeadType.tolet).length;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: TabBar(
              isScrollable: true,
              indicatorColor: Color.fromARGB(255, 158, 15, 235),
              indicatorWeight: 4.0,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black.withOpacity(0.6),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: 'All ($allCount)'),
                Tab(text: 'Buy ($buyCount)'),
                Tab(text: 'Sell ($sellCount)'),
                Tab(text: 'Rent ($rentCount)'),
                Tab(text: 'To Let ($toLetCount)'),
              ],
              onTap: (index) {
                ref.read(dashboardTabProvider.notifier).state =
                    DashboardTab.values[index];
                ref.read(lastSelectedTabProvider.notifier).setTabIndex(index);
              },
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class SearchBar extends ConsumerWidget {
  final TextEditingController controller;

  const SearchBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 9, vertical: 0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search leads...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).state = value;
        },
      ),
    );
  }
}
