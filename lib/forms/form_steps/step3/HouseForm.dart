import 'package:anucivil_client/widgets/facingMultiSelect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models.dart';
import '../../property_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'step3.dart';

class HouseForm extends ConsumerWidget {
  final LeadFormData formData;
  final LeadFormNotifier formNotifier;

  HouseForm({required this.formData, required this.formNotifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomStepperForm(
      title: 'House Details',
      steps: [
        _buildBasicDetails(context, ref),
        _buildSizeDetails(context),
        _buildRoomDetails(context),
        _buildAdditionalDetails(context),
      ],
    );
  }

  Widget _buildBasicDetails(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildTextField(context, 'Age of Property', 'ageOfProperty'),
        _buildDropdownField(
            context, 'Furnishing', FurnishingType.values, 'furnishingType'),
        _buildDropdownField(context, 'Construction Status',
            ConstructionStatus.values, 'constructionStatus'),
        buildMultiSelectFacing(context, ref, 'Facing'),
      ],
    );
  }

  Widget _buildSizeDetails(BuildContext context) {
    return Column(
      children: [
        _buildTextField(
            context, 'Area in Sft.', 'areaInSft', TextInputType.number),
        _buildTextField(context, 'Built Area in Sft.', 'builtAreaInSft',
            TextInputType.number),
        _buildTextField(
            context, 'Total Floors', 'totalFloors', TextInputType.number),
        _buildTextField(
            context, 'Width of Plot', 'widthOfPlot', TextInputType.number),
        _buildTextField(
            context, 'Length of Plot', 'lengthOfPlot', TextInputType.number),
      ],
    );
  }

  Widget _buildRoomDetails(BuildContext context) {
    return Column(
      children: [
        _buildTextField(context, 'Total Number of Bedrooms', 'totalBedrooms',
            TextInputType.number),
        _buildTextField(context, 'Number of Master Bedrooms', 'masterBedrooms',
            TextInputType.number),
        _buildTextField(
            context, 'Number of Bathrooms', 'bathrooms', TextInputType.number),
        _buildTextField(
            context, 'Number of Balconies', 'balconies', TextInputType.number),
      ],
    );
  }

  Widget _buildAdditionalDetails(BuildContext context) {
    return Column(
      children: [
        _buildStarRating(context, 'External Maintenance Rating',
            'externalMaintenanceRating'),
        _buildStarRating(context, 'Internal Maintenance Rating',
            'internalMaintenanceRating'),
      ],
    );
  }

  Widget _buildStarRating(BuildContext context, String label, String key) {
    double rating = 0.0; // Initial rating

    return Column(
      children: [
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (newRating) {
            // Update formNotifier with the new rating value
            formNotifier.updateLeadDetails({key: newRating.toString()});
          },
        ),
        Text(label),
      ],
    );
  }

  //formNotifier.updateLeadDetails({key: value})

  Widget _buildTextField(BuildContext context, String label, String key,
      [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: label),
        keyboardType: keyboardType,
        onChanged: (value) => formNotifier.updateLeadDetails({key: value}),
      ),
    );
  }

  Widget _buildDropdownField<T>(
      BuildContext context, String label, List<T> items, String key) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(labelText: label),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(formatText(item.toString().split('.').last)),
          );
        }).toList(),
        onChanged: (value) => formNotifier.updateLeadDetails({key: value}),
      ),
    );
  }
}
