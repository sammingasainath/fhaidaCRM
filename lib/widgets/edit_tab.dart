import 'package:anucivil_client/appwrite/services/convert_data_buy&rent%20%20without%20asso.dart';
import 'package:anucivil_client/appwrite/services/convert_data_sell&tolet%20without%20Associate%20Details.dart';
import 'package:anucivil_client/appwrite/services/convert_data_sell&tolet.dart';
import 'package:anucivil_client/appwrite/services/crud_service.dart';
import 'package:anucivil_client/models/lead.dart';
import 'package:anucivil_client/providers/navigation_provider.dart';
import 'package:anucivil_client/providers/project_provider.dart';
import 'package:anucivil_client/services/sms_service.dart';
import 'package:anucivil_client/utils/formatText.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../forms/models.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class PropertyLeadEditPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> initialData;

  PropertyLeadEditPage({Key? key, required this.initialData}) : super(key: key);

  @override
  _PropertyLeadEditPageState createState() => _PropertyLeadEditPageState();
}

class _PropertyLeadEditPageState extends ConsumerState<PropertyLeadEditPage> {
  late Map<String, dynamic> _editedData;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _editedData = Map.from(widget.initialData);
    print(widget.initialData['leadType']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: (widget.initialData['leadType'].toString() ==
                        'LeadType.sell' ||
                    widget.initialData['leadType'].toString() ==
                        'LeadType.tolet')
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Edit Property'),
                      _buildDropdownFormField(
                          'Lead Status', 'status', PropertyLeadStatus.values),
                      _buildTextFormField('Owner Name', 'ownerName'),
                      _buildTextFormField(
                          'Owner Phone Number', 'ownerPhoneNumber'),
                      _buildSwitchFormField(
                          'Also Want To Buy', 'alsoWantToBuy'),
                      if (widget.initialData['propertyTyp'] == 'house' ||
                          widget.initialData['propertyTyp'] == 'flat' ||
                          widget.initialData['propertyTyp'] ==
                              'commercialBuildings')
                        _buildDropdownFormField('Furnishing Type',
                            'furnishingType', FurnishingType.values),
                      _buildDropdownFormField('Construction Status',
                          'constructionStatus', ConstructionStatus.values),
                      _buildMultiSelectFormField(
                          'Facing', 'facing', Facing.values),
                      _buildTextFormField('Area in Sqft', 'areaInSft'),
                      if (widget.initialData['propertyTyp'] == 'flat')
                        _buildTextFormField('Total Floors in Apartment',
                            'totalFloorsInApartment'),
                      if (widget.initialData['propertyTyp'] == 'flat')
                        _buildTextFormField('Total Blocks in Apartment',
                            'totalBlocksInApartment'),
                      _buildTextFormField('Total Floors', 'totalFloors'),
                      if (widget.initialData['propertyTyp'] == 'flat')
                        _buildTextFormField('Floor of Flat', 'floorOfFlat'),
                      if (widget.initialData['propertyTyp'] == 'house' ||
                          widget.initialData['propertyTyp'] == 'flat' ||
                          widget.initialData['propertyTyp'] ==
                              'commercialBuildings')
                        _buildTextFormField('Total Bedrooms', 'totalBedrooms'),
                      if (widget.initialData['propertyTyp'] == 'house' ||
                          widget.initialData['propertyTyp'] == 'flat' ||
                          widget.initialData['propertyTyp'] ==
                              'commercialBuildings')
                        _buildTextFormField(
                            'Master Bedrooms', 'masterBedrooms'),
                      if (widget.initialData['propertyTyp'] == 'house' ||
                          widget.initialData['propertyTyp'] == 'flat' ||
                          widget.initialData['propertyTyp'] ==
                              'commercialBuildings')
                        _buildTextFormField('Bathrooms', 'bathrooms'),
                      if (widget.initialData['propertyTyp'] == 'house' ||
                          widget.initialData['propertyTyp'] == 'flat' ||
                          widget.initialData['propertyTyp'] ==
                              'commercialBuildings')
                        _buildTextFormField('Balconies', 'balconies'),
                      _buildSliderFormField('External Maintenance Rating',
                          'externalMaintenanceRating'),
                      if (widget.initialData['propertyTyp'] == 'house' ||
                          widget.initialData['propertyTyp'] == 'flat' ||
                          widget.initialData['propertyTyp'] ==
                              'commercialBuildings')
                        _buildSliderFormField('Internal Maintenance Rating',
                            'internalMaintenanceRating'),
                      _buildTextFormField('Rough Address', 'roughAddress'),
                      _buildTextFormField('Exact Address', 'exactAddress'),
                      _buildTextFormField('Video Link', 'videoLink'),
                      _buildTextFormField('Cost Price', 'costPrice'),
                      _buildTextFormField('Selling Price', 'sellingPrice'),
                      _buildTextFormField(
                          'Commission Percentage', 'commissionPercentage'),
                      _buildDateFormField('Deadline to Sell', 'deadlineToSell'),
                      _buildTextFormField(
                          'Built Area in Sqft', 'builtAreaInSft'),
                      if (widget.initialData['propertyTyp'] != 'house' ||
                          widget.initialData['propertyTyp'] != 'flat' ||
                          widget.initialData['propertyTyp'] !=
                              'commercialBuildings')
                        _buildTextFormField('Width of Plot', 'widthOfPlot'),
                      if (widget.initialData['propertyTyp'] != 'house' ||
                          widget.initialData['propertyTyp'] != 'flat' ||
                          widget.initialData['propertyTyp'] !=
                              'commercialBuildings')
                        _buildTextFormField('Length of Plot', 'lengthOfPlot'),
                      _buildTextFormField(
                          'Preferred Tenant', 'preferredTenant'),
                      _buildTextFormField(
                          'Preferred Advance', 'preferredAdvance'),
                      _buildTextFormField('Property Rent', 'propertyRent'),
                      _buildTextFormField(
                          'Customer Visit Location', 'customerVisitLocation'),
                      _buildTextFormField(
                          'Customer Visit Latitude', 'customerVisitLat'),
                      _buildTextFormField(
                          'Customer Visit Longitude', 'customerVisitLng'),
                      _buildTextFormField(
                          'Exact Visit Location', 'exactVisitLocation'),
                      _buildTextFormField(
                          'Exact Visit Latitude', 'exactVisitLat'),
                      _buildTextFormField(
                          'Exact Visit Longitude', 'exactVisitLng'),
                      _buildTextFormField('Description', 'description'),
                      _buildDropdownFormField(
                          'Listed By', 'listedBy', ListedBy.values),
                      _buildTextFormField('Associate Name', 'associateName'),
                      _buildTextFormField(
                          'Associate Number', 'associateNumber'),
                      _buildFilePickerField('Photos', 'photos'),
                      _buildFilePickerField('Documents', 'documents'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await _submitForm(ref);
                        },
                        child: Text('Save Changes'),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Edit Buyer'),
                      _buildTextFormField(
                          'Call Transcription', 'callTranscription'),
                      _buildTextFormField(
                          'Buyer Phone Number', 'buyerPhoneNumber'),
                      _buildTextFormField('Buyer Name', 'buyerName'),
                      _buildTextFormField(
                          'Number of Bedrooms', 'numberOfBedrooms'),
                      _buildSwitchFormField(
                          'Also Want To Sell', 'alsoWantToSell'),
                      _buildTextFormField('Buyer Location', 'buyerLocation'),
                      _buildTextFormField('Buyer Latitude', 'buyerLat'),
                      _buildTextFormField('Buyer Longitude', 'buyerLng'),
                      _buildTextFormField('Buyer Budget', 'buyerBudget'),
                      _buildTextFormField('Buyer Email', 'buyerEmail'),
                      _buildTextFormField(
                          'Buyer Occupation', 'buyerOccupation'),
                      _buildTextFormField('Buyer Comments', 'buyerComments'),
                      _buildMultiSelectFormField(
                          'Facing', 'facing', Facing.values),
                      _buildDropdownFormField(
                          'Listed By', 'listedBy', ListedBy.values),
                      _buildTextFormField('Associate Name', 'associateName'),
                      _buildTextFormField(
                          'Associate Number', 'associateNumber'),
                      // _buildLocationPicker('Preferred Locations', 'preferredLocations'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await _submitForm(ref);
                        },
                        child: Text('Save Changes'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, String field) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: _editedData[field]?.toString() ?? '',
      onSaved: (value) => _editedData[field] = value,
    );
  }

  Widget _buildSwitchFormField(String label, String field) {
    return SwitchListTile(
      title: Text(label),
      value: _editedData[field] ?? false,
      onChanged: (bool value) {
        setState(() {
          _editedData[field] = value;
        });
      },
    );
  }

  Widget _buildDropdownFormField(
      String label, String field, List<dynamic> items) {
    return DropdownButtonFormField(
      decoration: InputDecoration(labelText: label),
      value: _editedData[field],
      items: items
          .map((item) => DropdownMenuItem(
                value: item.toString().split('.').last,
                child: Text(formatText(item.toString().split('.').last)),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _editedData[field] = value;
        });
      },
    );
  }

  Widget _buildMultiSelectFormField(
      String label, String field, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        ...items
            .map((item) => CheckboxListTile(
                  title: Text(item.toString().split('.').last),
                  value: (_editedData[field] as List<dynamic>?)
                          ?.contains(item.toString().split('.').last) ??
                      false,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        (_editedData[field] as List<dynamic>? ?? [])
                            .add(item.toString().split('.').last);
                      } else {
                        (_editedData[field] as List<dynamic>? ?? [])
                            .remove(item.toString().split('.').last);
                      }
                    });
                  },
                ))
            .toList(),
      ],
    );
  }

  Widget _buildSliderFormField(String label, String field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: double.parse(_editedData[field]?.toString() ?? '0'),
          min: 0,
          max: 10,
          divisions: 10,
          label: _editedData[field]?.toString() ?? '0',
          onChanged: (double value) {
            setState(() {
              _editedData[field] = value.toString();
            });
          },
        ),
      ],
    );
  }

  Widget _buildDateFormField(String label, String field) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );
        if (pickedDate != null) {
          setState(() {
            _editedData[field] = pickedDate.toIso8601String();
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(labelText: label),
        child: Text(_editedData[field]?.toString() ?? 'Select Date'),
      ),
    );
  }

  Widget _buildFilePickerField(String label, String field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(allowMultiple: true);
            if (result != null) {
              setState(() {
                _editedData[field] = result.files;
              });
            }
          },
          child: Text('Pick Files'),
        ),
        if (_editedData[field] != null)
          Text('${(_editedData[field] as List).length} file(s) selected'),
      ],
    );
  }

  Future<void> _submitForm(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _editedData['photoUrls'] = widget.initialData['photoUrls'];
      _editedData['documentUrls'] = widget.initialData['documentUrls'];

      String leadType = widget.initialData['leadType']
          .toString()
          .split('.')
          .last
          .toLowerCase();
      _editedData['leadType'] = leadType;

      if (leadType == 'sell' || leadType == 'tolet') {
        try {
          var data1 = await convertDataWithoutAsso(
              _editedData, leadType, widget.initialData['propertyTyp']);
          await updatePropertyLead(data1, widget.initialData['id']);

          ref.read(projectRepositoryProvider);
          ref.refresh(projectRepositoryProvider);
          ref.read(selectedIndexProvider1.notifier).state = 0;

          Navigator.pushNamed(context, '/dashboard');

          // Refresh the project repository

          // Show success message
          Phoenix.rebirth(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Property lead updated successfully')),
          );

          // Navigate back
        } catch (e) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating property lead: $e')),
          );
        }
      } else {
        try {
          var data1 = await convertData1withoutasso(
              _editedData, leadType, widget.initialData['preferredProperties']);
          await updateBuyerLead(data1, widget.initialData['id']);

          ref.read(projectRepositoryProvider);
          ref.refresh(projectRepositoryProvider);
          ref.read(selectedIndexProvider1.notifier).state = 0;

          Navigator.pushNamed(context, '/dashboard');

          // Refresh the project repository

          // Show success message
          Phoenix.rebirth(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Property lead updated successfully')),
          );

          // Navigate back
        } catch (e) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating property lead: $e')),
          );
        }
      }
    }
  }
}
