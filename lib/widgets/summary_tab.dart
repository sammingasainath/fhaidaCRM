import 'package:flutter/material.dart';
import '../models/lead.dart';
import 'package:url_launcher/url_launcher.dart';
import 'call_to_action_container.dart';

class SummaryTab extends StatelessWidget {
  final Lead lead;

  SummaryTab({required this.lead});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CallToActionContainer(
          //   lead: lead,
          // ),
          SizedBox(height: 22),
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
    );
  }

  List<Widget> _buildLeadDetails(BuildContext context) {
    List<Widget> details = [];
    // print('Check karle${lead.preferredLocations}');

    // Display common fields

    // Conditional fields based on leadType
    if (lead.leadType == LeadType.sell || lead.leadType == LeadType.tolet) {
      details.add(_buildDetailSection(
          'Property Details:',
          [
            _buildDetailRow(
                icon: Icons.home,
                title: 'Furnishing Type:',
                value: lead.furnishingType),
            _buildDetailRow(
                icon: Icons.build,
                title: 'Construction Status:',
                value: lead.constructionStatus),
            _buildDetailRow(
                icon: Icons.straighten,
                title: 'Built Area (SFT):',
                value: lead.builtAreaInSft?.toString()),
            _buildDetailRow(
                icon: Icons.layers,
                title: 'Total Floors:',
                value: lead.totalFloors?.toString()),
            _buildDetailRow(
                icon: Icons.square_foot,
                title: 'Plot Width:',
                value: lead.widthOfPlot?.toString()),
            _buildDetailRow(
                icon: Icons.square_foot,
                title: 'Plot Length:',
                value: lead.lengthOfPlot?.toString()),
            _buildDetailRow(
                icon: Icons.bed,
                title: 'Total Bedrooms:',
                value: lead.totalBedrooms?.toString()),
            _buildDetailRow(
                icon: Icons.bed,
                title: 'Master Bedrooms:',
                value: lead.masterBedrooms?.toString()),
            _buildDetailRow(
                icon: Icons.bathtub,
                title: 'Bathrooms:',
                value: lead.bathrooms?.toString()),
            _buildDetailRow(
                icon: Icons.balcony,
                title: 'Balconies:',
                value: lead.balconies?.toString()),
            _buildDetailRow(
                icon: Icons.star_border,
                title: 'External Maintenance Rating:',
                value: lead.externalMaintenanceRating?.toString()),
            _buildDetailRow(
                icon: Icons.star_border,
                title: 'Internal Maintenance Rating:',
                value: lead.internalMaintenanceRating?.toString()),
            _buildDetailRow(
                icon: Icons.map,
                title: 'Rough Address:',
                value: lead.roughAddress),
            _buildDetailRow(
                icon: Icons.place,
                title: 'Customer Visit Location:',
                value: lead.customerVisitLocation),
            _buildDetailRow(
                icon: Icons.location_on,
                title: 'Visit Location (Lat/Lng):',
                value:
                    '${lead.customerVisitLat ?? ''}, ${lead.customerVisitLng ?? ''}'),
            _buildDetailRow(
                icon: Icons.place,
                title: 'Exact Address:',
                value: lead.exactAddress),
            _buildDetailRow(
                icon: Icons.location_on,
                title: 'Exact Visit Location (Lat/Lng):',
                value:
                    '${lead.exactVisitLat ?? ''}, ${lead.exactVisitLng ?? ''}'),
            _buildDetailRow(
                icon: Icons.video_call,
                title: 'Video Link:',
                value: lead.videoLink),
            _buildDetailRow(
                icon: Icons.description,
                title: 'Description:',
                value: lead.description),
            _buildDetailRow(
                icon: Icons.attach_money,
                title: 'Cost Price:',
                value: lead.costPrice?.toString()),
            _buildDetailRow(
                icon: Icons.attach_money,
                title: 'Selling Price:',
                value: lead.sellingPrice?.toString()),
            _buildDetailRow(
                icon: Icons.percent,
                title: 'Commission Percentage:',
                value: lead.commissionPercentage?.toString()),
            _buildDetailRow(
                icon: Icons.calendar_today,
                title: 'Deadline to Sell:',
                value: lead.deadlineToSell),
            _buildDetailRow(
                icon: Icons.layers,
                title: 'Total Floors in Apartment:',
                value: lead.totalFloorsInApartment?.toString()),
            _buildDetailRow(
                icon: Icons.build,
                title: 'Total Blocks in Apartment:',
                value: lead.totalBlocksInApartment?.toString()),
            _buildDetailRow(
                icon: Icons.api_sharp,
                title: 'Floor of Flat:',
                value: lead.floorOfFlat),
            _buildDetailRow(
                icon: Icons.person,
                title: 'Preferred Tenant:',
                value: lead.preferredTenant),
            _buildDetailRow(
                icon: Icons.monetization_on,
                title: 'Preferred Advance:',
                value: lead.preferredAdvance?.toString()),
            _buildDetailRow(
                icon: Icons.monetization_on,
                title: 'Property Rent:',
                value: lead.propertyRent?.toString()),
            _buildDetailRow(
                icon: Icons.access_time,
                title: 'Age of Property:',
                value: lead.ageOfProperty?.toString()),
            _buildDetailRow(
                icon: Icons.exposure,
                title: 'Facing:',
                value: lead.facing?.join(', ')),
            _buildDetailRow(
                icon: Icons.square_foot,
                title: 'Area (SFT):',
                value: lead.areaInSft),
            //   _buildDetailRow(
            //       icon: Icons.photo,
            //       title: 'Photos:',
            //       value: lead.photoUrls?.join(', ')),
            //   _buildDetailRow(
            //       icon: Icons.attach_file,
            //       title: 'Documents:',
            //       value: lead.documentUrls?.join(', ')),
          ],
          context));
    } else if (lead.leadType == LeadType.buy ||
        lead.leadType == LeadType.rent) {
      details.add(_buildDetailSection(
          'Buyer Details:',
          [
            _buildDetailRow(
                icon: Icons.phone,
                title: 'Phone Number:',
                value: lead.buyerPhoneNumber),
            _buildDetailRow(
                icon: Icons.person, title: 'Name:', value: lead.buyerName),
            _buildDetailRow(
                icon: Icons.bed,
                title: 'Number of Bedrooms:',
                value: lead.numberOfBedrooms?.toString()),
            _buildDetailRow(
                icon: Icons.sync,
                title: 'Also Want to Sell:',
                value: lead.alsoWantToSell == true ? 'Yes' : 'No'),
            _buildDetailRow(
                icon: Icons.location_on,
                title: 'Location:',
                value: lead.buyerLocation),
            _buildDetailRow(
                icon: Icons.location_on,
                title: 'Location (Lat/Lng):',
                value: '${lead.buyerLat ?? ''}, ${lead.buyerLng ?? ''}'),
            _buildDetailRow(
                icon: Icons.attach_money,
                title: 'Budget:',
                value: lead.buyerBudget),
            _buildDetailRow(
                icon: Icons.email, title: 'Email:', value: lead.buyerEmail),
            _buildDetailRow(
                icon: Icons.work,
                title: 'Occupation:',
                value: lead.buyerOccupation),
            _buildDetailRow(
                icon: Icons.comment,
                title: 'Comments:',
                value: lead.buyerComments),
            // _buildDetailRow(
            //     icon: Icons.location_on,
            //     title: 'Preferred Locations:',
            //     value: lead.preferredLocations?.join(', ')),
            _buildDetailRow(
                icon: Icons.home,
                title: 'Property Type:',
                value: lead.propertyTyp),
            _buildDetailRow(
                icon: Icons.favorite,
                title: 'Preferred Properties:',
                value: lead.preferredProperties?.join(', ')),
          ],
          context));
    }

    if (lead.preferredLocations != null &&
        lead.preferredLocations!.isNotEmpty) {
      details.add(_buildDetailSection(
        'Preferred Locations:',
        lead.preferredLocations!.map((location) {
          final latitude = location['latitude'];
          final longitude = location['longitude'];
          final description = location['description'];
          final mapUrl =
              'https://www.google.com/maps/search/$latitude,$longitude';

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
        }).toList(),
        context,
      ));
    }

    return details;
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
        : SizedBox
            .shrink(); // Don't display the section if all widgets are empty
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    String? value,
  }) {
    return value != null && value.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Icon(icon, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '$title ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: value),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
