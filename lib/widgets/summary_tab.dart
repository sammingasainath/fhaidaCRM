import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/lead.dart';

class SummaryTab extends StatefulWidget {
  final Lead lead;

  SummaryTab({required this.lead});

  @override
  _SummaryTabState createState() => _SummaryTabState();
}

class _SummaryTabState extends State<SummaryTab> {
  Set<String> selectedFields = {};
  bool selectAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSelectAllCheckbox(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildLeadDetails(context),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildShareFAB(),
    );
  }

  Widget _buildSelectAllCheckbox() {
    return CheckboxListTile(
      title: Text('Select All'),
      value: selectAll,
      onChanged: (bool? value) {
        setState(() {
          selectAll = value ?? false;
          if (selectAll) {
            selectedFields = Set.from(_getSelectableFields());
          } else {
            selectedFields.clear();
          }
        });
      },
    );
  }

  Widget _buildShareFAB() {
    return selectedFields.isNotEmpty
        ? FloatingActionButton.extended(
            onPressed: _showShareOptions,
            label: Text('Share ${selectedFields.length} fields'),
            icon: Icon(Icons.share),
          )
        : FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.share),
          );
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('WhatsApp'),
              onTap: () => _shareVia('whatsapp'),
            ),
            ListTile(
              leading: Icon(Icons.sms),
              title: Text('SMS'),
              onTap: () => _shareVia('sms'),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              onTap: () => _shareVia('email'),
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text('Copy to Clipboard'),
              onTap: () => _shareVia('clipboard'),
            ),
          ],
        );
      },
    );
  }

  void _shareVia(String method) {
    String shareText = _getFormattedText();
    switch (method) {
      case 'whatsapp':
        launch('whatsapp://send?text=${Uri.encodeComponent(shareText)}');
        break;
      case 'sms':
        launch('sms:?body=${Uri.encodeComponent(shareText)}');
        break;
      case 'email':
        launch('mailto:?body=${Uri.encodeComponent(shareText)}');
        break;
      case 'clipboard':
        Clipboard.setData(ClipboardData(text: shareText));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Copied to clipboard')),
        );
        break;
    }
    Navigator.pop(context);
  }

  String _getFormattedText() {
    StringBuffer buffer = StringBuffer();
    for (String field in selectedFields) {
      buffer.writeln('$field: ${_getFieldValue(field)}');
    }
    return buffer.toString();
  }

  String _getFieldValue(String field) {
    switch (field) {
      case 'Furnishing Type':
        return widget.lead.furnishingType ?? '';
      case 'Construction Status':
        return widget.lead.constructionStatus ?? '';
      case 'Built Area (SFT)':
        return widget.lead.builtAreaInSft?.toString() ?? '';
      case 'Total Floors':
        return widget.lead.totalFloors?.toString() ?? '';
      case 'Plot Width':
        return widget.lead.widthOfPlot?.toString() ?? '';
      case 'Plot Length':
        return widget.lead.lengthOfPlot?.toString() ?? '';
      case 'Total Bedrooms':
        return widget.lead.totalBedrooms?.toString() ?? '';
      case 'Master Bedrooms':
        return widget.lead.masterBedrooms?.toString() ?? '';
      case 'Bathrooms':
        return widget.lead.bathrooms?.toString() ?? '';
      case 'Balconies':
        return widget.lead.balconies?.toString() ?? '';
      case 'External Maintenance Rating':
        return widget.lead.externalMaintenanceRating?.toString() ?? '';
      case 'Internal Maintenance Rating':
        return widget.lead.internalMaintenanceRating?.toString() ?? '';
      case 'Rough Address':
        return widget.lead.roughAddress ?? '';
      case 'Customer Visit Location':
        return widget.lead.customerVisitLocation ?? '';
      case 'Visit Location (Lat/Lng)':
        return 'https://www.google.com/maps/search/${widget.lead.customerVisitLat ?? ''},${widget.lead.customerVisitLng ?? ''}';
      case 'Exact Address':
        return widget.lead.exactAddress ?? '';
      case 'Exact Visit Location (Lat/Lng)':
        return '${widget.lead.exactVisitLat ?? ''}, ${widget.lead.exactVisitLng ?? ''}';
      case 'Video Link':
        return widget.lead.videoLink ?? '';
      case 'Description':
        return widget.lead.description ?? '';
      case 'Cost Price':
        return widget.lead.costPrice?.toString() ?? '';
      case 'Selling Price':
        return widget.lead.sellingPrice?.toString() ?? '';
      case 'Commission Percentage':
        return widget.lead.commissionPercentage?.toString() ?? '';
      case 'Deadline to Sell':
        return widget.lead.deadlineToSell ?? '';
      case 'Total Floors in Apartment':
        return widget.lead.totalFloorsInApartment?.toString() ?? '';
      case 'Total Blocks in Apartment':
        return widget.lead.totalBlocksInApartment?.toString() ?? '';
      case 'Floor of Flat':
        return widget.lead.floorOfFlat ?? '';
      case 'Preferred Tenant':
        return widget.lead.preferredTenant ?? '';
      case 'Preferred Advance':
        return widget.lead.preferredAdvance?.toString() ?? '';
      case 'Property Rent':
        return widget.lead.propertyRent?.toString() ?? '';
      case 'Age of Property':
        return widget.lead.ageOfProperty?.toString() ?? '';
      case 'Facing':
        return widget.lead.facing?.join(', ') ?? '';
      case 'Area (SFT)':
        return widget.lead.areaInSft ?? '';
      case 'Phone Number':
        return widget.lead.buyerPhoneNumber ?? '';
      case 'Name':
        return widget.lead.buyerName ?? '';
      case 'Number of Bedrooms':
        return widget.lead.numberOfBedrooms?.toString() ?? '';
      case 'Also Want to Sell':
        return widget.lead.alsoWantToSell == true ? 'Yes' : 'No';
      case 'Location':
        return widget.lead.buyerLocation ?? '';
      case 'Location (Lat/Lng)':
        return '${widget.lead.buyerLat ?? ''}, ${widget.lead.buyerLng ?? ''}';
      case 'Budget':
        return widget.lead.buyerBudget ?? '';
      case 'Email':
        return widget.lead.buyerEmail ?? '';
      case 'Occupation':
        return widget.lead.buyerOccupation ?? '';
      case 'Comments':
        return widget.lead.buyerComments ?? '';
      case 'Property Type':
        return widget.lead.propertyTyp ?? '';
      case 'Preferred Properties':
        return widget.lead.preferredProperties?.join(', ') ?? '';
      default:
        return '';
    }
  }

  List<String> _getAllFields() {
    List<String> fields = [
      'Furnishing Type',
      'Construction Status',
      'Built Area (SFT)',
      'Total Floors',
      'Plot Width',
      'Plot Length',
      'Total Bedrooms',
      'Master Bedrooms',
      'Bathrooms',
      'Balconies',
      'External Maintenance Rating',
      'Internal Maintenance Rating',
      'Rough Address',
      'Customer Visit Location',
      'Visit Location (Lat/Lng)',
      'Exact Address',
      'Exact Visit Location (Lat/Lng)',
      'Video Link',
      'Description',
      'Cost Price',
      'Selling Price',
      'Commission Percentage',
      'Deadline to Sell',
      'Total Floors in Apartment',
      'Total Blocks in Apartment',
      'Floor of Flat',
      'Preferred Tenant',
      'Preferred Advance',
      'Property Rent',
      'Age of Property',
      'Facing',
      'Area (SFT)',
      'Phone Number',
      'Name',
      'Number of Bedrooms',
      'Also Want to Sell',
      'Location',
      'Location (Lat/Lng)',
      'Budget',
      'Email',
      'Occupation',
      'Comments',
      'Property Type',
      'Preferred Properties',
    ];
    return fields.where((field) => _getFieldValue(field).isNotEmpty).toList();
  }

  List<Widget> _buildLeadDetails(BuildContext context) {
    List<Widget> details = [];

    if (widget.lead.leadType == LeadType.sell ||
        widget.lead.leadType == LeadType.tolet) {
      details.add(_buildDetailSection(
          'Property Details:', _buildPropertyDetails(), context));
    } else if (widget.lead.leadType == LeadType.buy ||
        widget.lead.leadType == LeadType.rent) {
      details.add(
          _buildDetailSection('Buyer Details:', _buildBuyerDetails(), context));
    }

    if (widget.lead.preferredLocations != null &&
        widget.lead.preferredLocations!.isNotEmpty) {
      details.add(_buildDetailSection(
          'Preferred Locations:', _buildPreferredLocations(), context));
    }

    return details;
  }

  List<Widget> _buildPropertyDetails() {
    return _getAllFields()
        .where((field) => [
              'Furnishing Type',
              'Construction Status',
              'Built Area (SFT)',
              'Total Floors',
              'Plot Width',
              'Plot Length',
              'Total Bedrooms',
              'Master Bedrooms',
              'Bathrooms',
              'Balconies',
              'External Maintenance Rating',
              'Internal Maintenance Rating',
              'Rough Address',
              'Customer Visit Location',
              'Visit Location (Lat/Lng)',
              'Exact Address',
              'Exact Visit Location (Lat/Lng)',
              'Video Link',
              'Description',
              'Cost Price',
              'Selling Price',
              'Commission Percentage',
              'Deadline to Sell',
              'Total Floors in Apartment',
              'Total Blocks in Apartment',
              'Floor of Flat',
              'Preferred Tenant',
              'Preferred Advance',
              'Property Rent',
              'Age of Property',
              'Facing',
              'Area (SFT)'
            ].contains(field))
        .map((field) => _buildDetailRow(field))
        .toList();
  }

  List<Widget> _buildBuyerDetails() {
    return _getAllFields()
        .where((field) => [
              'Phone Number',
              'Name',
              'Number of Bedrooms',
              'Also Want to Sell',
              'Location',
              'Location (Lat/Lng)',
              'Budget',
              'Email',
              'Occupation',
              'Comments',
              'Property Type',
              'Preferred Properties'
            ].contains(field))
        .map((field) => _buildDetailRow(field))
        .toList();
  }

  List<Widget> _buildPreferredLocations() {
    return widget.lead.preferredLocations!.map((location) {
      final latitude = location['latitude'];
      final longitude = location['longitude'];
      final description = location['description'];
      final mapUrl = 'https://www.google.com/maps/search/$latitude,$longitude';

      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(description ?? 'No description',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () async {
                      if (await canLaunch(mapUrl)) {
                        await launch(mapUrl);
                      } else {
                        throw 'Could not launch $mapUrl';
                      }
                    },
                    child: Text(
                      'View on Map',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildDetailSection(
      String title, List<Widget> details, BuildContext context) {
    final nonEmptyDetails =
        details.where((widget) => widget != SizedBox.shrink()).toList();

    return nonEmptyDetails.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ...nonEmptyDetails,
              SizedBox(height: 16),
            ],
          )
        : SizedBox.shrink();
  }

  List<String> _getSelectableFields() {
    // List of fields to be excluded from "Select All"
    final excludedFields = [
      'External Maintenance Rating',
      'Internal Maintenance Rating',
      'Comments',
      'Exact Address',
      'Exact Visit Location (Lat/Lng)',
      'Cost Price',
      'Commission Percentage',
      'Deadline to Sell',
      // 'Phone Number',
      // 'Name',
      'Also Want to Sell',
      'Location',
      'Location (Lat/Lng)',
      'Budget',
      'Email',
      'Occupation',
      'Comments',
      // 'Preferred Properties',
      // Add any other fields you want to exclude
    ];

    return _getAllFields()
        .where((field) => !excludedFields.contains(field))
        .toList();
  }

  Widget _buildDetailRow(String field) {
    IconData icon = Icons.info;
    switch (field) {
      case 'Furnishing Type':
        icon = Icons.chair;
        break;
      case 'Construction Status':
        icon = Icons.build;
        break;
      case 'Built Area (SFT)':
      case 'Plot Width':
      case 'Plot Length':
      case 'Area (SFT)':
        icon = Icons.square_foot;
        break;
      case 'Total Floors':
      case 'Total Floors in Apartment':
      case 'Floor of Flat':
        icon = Icons.layers;
        break;
      case 'Total Bedrooms':
      case 'Master Bedrooms':
      case 'Number of Bedrooms':
        icon = Icons.bed;
        break;
      case 'Bathrooms':
        icon = Icons.bathtub;
        break;
      case 'Balconies':
        icon = Icons.balcony;
        break;
      case 'External Maintenance Rating':
      case 'Internal Maintenance Rating':
        icon = Icons.star_border;
        break;
      case 'Rough Address':
      case 'Customer Visit Location':
      case 'Exact Address':
      case 'Location':
        icon = Icons.place;
        break;
      case 'Visit Location (Lat/Lng)':
      case 'Exact Visit Location (Lat/Lng)':
      case 'Location (Lat/Lng)':
        icon = Icons.location_on;
        break;
      case 'Video Link':
        icon = Icons.video_call;
        break;
      case 'Description':
      case 'Comments':
        icon = Icons.description;
        break;
      case 'Cost Price':
      case 'Selling Price':
      case 'Budget':
      case 'Preferred Advance':
      case 'Property Rent':
        icon = Icons.attach_money;
        break;
      case 'Commission Percentage':
        icon = Icons.percent;
        break;
      case 'Deadline to Sell':
      case 'Age of Property':
        icon = Icons.calendar_today;
        break;
      case 'Total Blocks in Apartment':
        icon = Icons.apartment;
        break;
      case 'Preferred Tenant':
        icon = Icons.person;
        break;
      case 'Facing':
        icon = Icons.compass_calibration;
        break;
      case 'Phone Number':
        icon = Icons.phone;
        break;
      case 'Name':
        icon = Icons.person;
        break;
      case 'Also Want to Sell':
        icon = Icons.sync;
        break;
      case 'Email':
        icon = Icons.email;
        break;
      case 'Occupation':
        icon = Icons.work;
        break;
      case 'Property Type':
        icon = Icons.home;
        break;
      case 'Preferred Properties':
        icon = Icons.favorite;
        break;
    }

    final isSelectable = _getSelectableFields().contains(field);

    return CheckboxListTile(
        title: Row(
          children: [
            Icon(icon, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$field: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: _getFieldValue(field)),
                  ],
                ),
              ),
            ),
          ],
        ),
        value: selectedFields.contains(field),
        onChanged: isSelectable
            ? (bool? value) {
                setState(() {
                  if (value ?? false) {
                    selectedFields.add(field);
                  } else {
                    selectedFields.remove(field);
                  }
                  selectAll =
                      selectedFields.length == _getSelectableFields().length;
                });
              }
            : null);
  }
}
