import 'package:anucivil_client/forms/maps_functionality/place_search.dart';
import 'package:anucivil_client/widgets/facingMultiSelect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../property_form.dart';
import 'step3.dart';

class SellRentForm extends ConsumerWidget {
  final LeadFormData formData;
  final LeadFormNotifier formNotifier;

  SellRentForm({required this.formData, required this.formNotifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Locations preferred
        PlaceSearchField(
          label: 'Add Preferred Location',
          onSelected: (PlaceSearchResult result) {
            _addPreferredLocation(result);
          },
          uniqueKey: 'preferredLocation',
        ),

        if (formData.preferredLocations != null &&
            formData.preferredLocations!.isNotEmpty)
          Container(
            height: 200, // Set a fixed height for the scrollable area
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: formData.preferredLocations!.length,
              itemBuilder: (context, index) {
                final location = formData.preferredLocations![index];
                return ListTile(
                  title: Text(
                    'Location: ${location.description}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                      'Lat: ${location.latitude}, Lng: ${location.longitude}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Location Description'),
                              content: Text(location.description),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          List<LatLng1> updatedLocations =
                              List.from(formData.preferredLocations!);
                          updatedLocations.removeAt(index);
                          formNotifier
                              .updatePreferredLocations(updatedLocations);

                          formNotifier.updateLeadDetails(
                              {'preferredLocations': updatedLocations});
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        else
          Text('No preferred locations added yet.'),

        TextFormField(
          decoration: InputDecoration(labelText: 'Call Transcription'),
          maxLines: 3,
          onChanged: (value) =>
              formNotifier.updateLeadDetails({'callTranscription': value}),
        ),

        TextFormField(
          decoration: InputDecoration(labelText: 'Phone Number'),
          keyboardType: TextInputType.phone,
          onChanged: (value) =>
              formNotifier.updateLeadDetails({'buyerPhoneNumber': value}),
        ),

        TextFormField(
          decoration: InputDecoration(labelText: 'Name'),
          onChanged: (value) =>
              formNotifier.updateLeadDetails({'buyerName': value}),
        ),

        if (formData.propertyTypes.contains(PropertyType.flat) ||
            formData.propertyTypes.contains(PropertyType.house))
          TextFormField(
            decoration: InputDecoration(labelText: 'Number of Bedrooms'),
            keyboardType: TextInputType.number,
            onChanged: (value) => formNotifier
                .updateLeadDetails({'numberOfBedrooms': int.tryParse(value)}),
          ),

        buildMultiSelectFacing(context, ref, 'Facing'),

        CheckboxListTile(
          title: Text('Also Want to Sell?'),
          value: formData.leadDetails['alsoWantToSell'] as bool? ?? false,
          onChanged: (bool? value) {
            formNotifier.updateLeadDetails({'alsoWantToSell': value});
          },
        ),

        PlaceSearchField(
          label: 'Buyer Location',
          uniqueKey: 'buyerLocation',
          onSelected: (result) {
            formNotifier.updateLeadDetails({
              'buyerLocation': result.description,
              'buyerLat': result.lat,
              'buyerLng': result.lng,
            });
          },
        ),

        TextFormField(
          decoration: InputDecoration(labelText: 'Budget'),
          keyboardType: TextInputType.number,
          onChanged: (value) =>
              formNotifier.updateLeadDetails({'buyerBudget': value}),
        ),

        TextFormField(
          decoration: InputDecoration(labelText: 'Email Id'),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) =>
              formNotifier.updateLeadDetails({'buyerEmail': value}),
        ),

        TextFormField(
          decoration: InputDecoration(labelText: 'Occupation'),
          onChanged: (value) =>
              formNotifier.updateLeadDetails({'buyerOccupation': value}),
        ),

        TextFormField(
          decoration: InputDecoration(labelText: 'Comments'),
          maxLines: 3,
          onChanged: (value) =>
              formNotifier.updateLeadDetails({'buyerComments': value}),
        ),
      ],
    );
  }

  void _addPreferredLocation(PlaceSearchResult result) {
    final newLocation = LatLng1(result.lat, result.lng, result.description);
    List<LatLng1> currentLocations =
        List.from(formData.preferredLocations ?? []);
    currentLocations.add(newLocation);
    formNotifier.updatePreferredLocations(currentLocations);
    formNotifier.updateLeadDetails({'preferredLocations': currentLocations});
  }
}
