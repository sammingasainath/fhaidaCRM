import 'package:fhaidaCrm/widgets/facingMultiSelect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models.dart';
import '../../property_form.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'step3.dart';

class PlotForm extends ConsumerWidget {
  final LeadFormData formData;
  final LeadFormNotifier formNotifier;

  PlotForm({required this.formData, required this.formNotifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomStepperForm(
      title: 'Plot Details',
      steps: [
        _buildBasicDetails(context, ref),
        _buildSizeDetails(context),
        _buildAdditionalDetails(context),
      ],
    );
  }

  Widget _buildBasicDetails(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
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
        _buildTextField(
            context, 'Width of Plot', 'widthOfPlot', TextInputType.number),
        _buildTextField(
            context, 'Length of Plot', 'lengthOfPlot', TextInputType.number),
      ],
    );
  }

  Widget _buildAdditionalDetails(BuildContext context) {
    return Column(
      children: [
        _buildStarRating(context, 'External Maintenance Rating',
            'externalMaintenanceRating'),
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
